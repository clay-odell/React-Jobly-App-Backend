"use strict";

const supabase = require("../db");
const bcrypt = require("bcrypt");
const { sqlForPartialUpdate } = require("../helpers/sql");
const {
  NotFoundError,
  BadRequestError,
  UnauthorizedError,
} = require("../expressError");

const { BCRYPT_WORK_FACTOR } = require("../config.js");

/** Related functions for users. */

class User {
  /** authenticate user with username, password.
   *
   * Returns { username, first_name, last_name, email, is_admin }
   *
   * Throws UnauthorizedError if user not found or wrong password.
   **/
  static async authenticate(username, password) {
    const { data, error } = await supabase.auth.signInWithPassword({
      username,
      password,
    });

    if (error) {
      throw new UnauthorizedError("Invalid username/password");
    }

    const user = data.user;

    if (user) {
      return {
        username: user.user_metadata.username,
        firstName: user.user_metadata.firstName,
        lastName: user.user_metadata.lastName,
        email: user.email,
        isAdmin: user.user_metadata.isAdmin,
      };
    }

    throw new UnauthorizedError("Invalid username/password");
  }

  /** Register user with data.
   *
   * Returns { username, firstName, lastName, email, isAdmin }
   *
   * Throws BadRequestError on duplicates.
   **/
  static async register({
    username,
    password,
    firstName,
    lastName,
    email,
    isAdmin,
  }) {
    const { data, error } = await supabase.auth.signUp({
      email: email,
      password: password,
      options: {
        data: {
          username,
          firstName,
          lastName,
          isAdmin,
        },
      },
    });

    if (error) {
      throw new BadRequestError(`Duplicate username: ${username}`);
    }

    const user = data.user;

    return {
      username: user.user_metadata.username,
      firstName: user.user_metadata.firstName,
      lastName: user.user_metadata.lastName,
      email: user.email,
      isAdmin: user.user_metadata.isAdmin,
    };
  }

  /** Find all users.
   *
   * Returns [{ username, first_name, last_name, email, is_admin }, ...]
   **/
  static async findAll() {
    const { data, error } = await supabase
      .from("users")
      .select("username, first_name, last_name, email, is_admin");

    if (error) {
      throw new NotFoundError("No users found");
    }

    return data;
  }

  /** Given a username, return data about user.
   *
   * Returns { username, first_name, last_name, is_admin, applications }
   *   where applications is [job_id, ...]
   *
   * Throws NotFoundError if user not found.
   **/
  static async get(username) {
    const { data: user, error } = await supabase
      .from("users")
      .select("username, first_name, last_name, email, is_admin")
      .eq("username", username)
      .single();

    if (error) {
      throw new NotFoundError(`No user: ${username}`);
    }

    const { data: applications, error: applicationsError } = await supabase
      .from("applications")
      .select("job_id")
      .eq("username", username);

    if (applicationsError) {
      throw new NotFoundError("Error fetching user applications");
    }

    user.applications = applications.map((a) => a.job_id);
    return user;
  }

  /** Update user data with `data`.
   *
   * This is a "partial update" --- it's fine if data doesn't contain
   * all the fields; this only changes provided ones.
   *
   * Data can include:
   *   { firstName, lastName, password, email, isAdmin }
   *
   * Returns { username, firstName, lastName, email, isAdmin }
   *
   * Throws NotFoundError if not found.
   **/
  static async update(username, data) {
    if (data.password) {
      data.password = await bcrypt.hash(data.password, BCRYPT_WORK_FACTOR);
    }

    const { setCols, values } = sqlForPartialUpdate(data, {
      firstName: "first_name",
      lastName: "last_name",
      isAdmin: "is_admin",
    });

    const { data: updatedUser, error } = await supabase
      .from("users")
      .update({ ...data })
      .eq("username", username)
      .select();

    if (error) {
      throw new NotFoundError(`No user: ${username}`);
    }

    return updatedUser[0];
  }

  /** Delete given user from database; returns undefined. */
  static async remove(username) {
    const { data, error } = await supabase
      .from("users")
      .delete()
      .eq("username", username);

    if (error) {
      throw new NotFoundError(`No user: ${username}`);
    }
  }

  /** Apply for job: update db, returns undefined.
   *
   * - username: username applying for job
   * - jobId: job id
   **/
  static async applyToJob(username, jobId) {
    const { data: job, error: jobError } = await supabase
      .from("jobs")
      .select("id")
      .eq("id", jobId)
      .single();

    if (jobError) {
      throw new NotFoundError(`No job: ${jobId}`);
    }

    const { data: user, error: userError } = await supabase
      .from("users")
      .select("username")
      .eq("username", username)
      .single();

    if (userError) {
      throw new NotFoundError(`No username: ${username}`);
    }

    const { data, error } = await supabase
      .from("applications")
      .insert([{ job_id: jobId, username }]);

    if (error) {
      throw new Error("Failed to apply for job");
    }
  }
}

module.exports = User;

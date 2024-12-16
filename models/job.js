"use strict";

const supabase = require("../db");
const { NotFoundError } = require("../expressError");
const { sqlForPartialUpdate } = require("../helpers/sql");

/** Related functions for jobs. */
class Job {
  /** Create a job (from data), update db, return new job data.
   *
   * data should be { title, salary, equity, companyHandle }
   *
   * Returns { id, title, salary, equity, companyHandle }
   **/
  static async create(data) {
    const { data: job, error } = await supabase
      .from('jobs')
      .insert([{ 
        title: data.title,
        salary: data.salary,
        equity: data.equity,
        company_handle: data.companyHandle 
      }])
      .select();

    if (error) {
      throw new Error(error.message);
    }

    return job[0];
  }

  /** Find all jobs (optional filter on searchFilters).
   *
   * searchFilters (all optional):
   * - minSalary
   * - hasEquity (true returns only jobs with equity > 0, other values ignored)
   * - title (will find case-insensitive, partial matches)
   *
   * Returns [{ id, title, salary, equity, companyHandle, companyName }, ...]
   * */
  static async findAll({ minSalary, hasEquity, title } = {}) {
    let query = supabase
      .from('jobs')
      .select('id, title, salary, equity, company_handle, companies(name)')
      .leftJoin('companies', 'jobs.company_handle', 'companies.handle');

    if (minSalary !== undefined) {
      query = query.gte('salary', minSalary);
    }

    if (hasEquity) {
      query = query.gt('equity', 0);
    }

    if (title) {
      query = query.ilike('title', `%${title}%`);
    }

    const { data: jobs, error } = await query;

    if (error) {
      throw new Error(error.message);
    }

    return jobs;
  }

  /** Given a job id, return data about job.
   *
   * Returns { id, title, salary, equity, companyHandle, company }
   *   where company is { handle, name, description, numEmployees, logoUrl }
   *
   * Throws NotFoundError if not found.
   **/
  static async get(id) {
    const { data: job, error } = await supabase
      .from('jobs')
      .select('id, title, salary, equity, company_handle')
      .eq('id', id)
      .single();

    if (error) {
      throw new NotFoundError(`No job: ${id}`);
    }

    const { data: company, error: companyError } = await supabase
      .from('companies')
      .select('handle, name, description, num_employees, logo_url')
      .eq('handle', job.company_handle)
      .single();

    if (companyError) {
      throw new NotFoundError(`No company: ${job.company_handle}`);
    }

    delete job.company_handle;
    job.company = company;

    return job;
  }

  /** Update job data with `data`.
   *
   * This is a "partial update" --- it's fine if data doesn't contain
   * all the fields; this only changes provided ones.
   *
   * Data can include: { title, salary, equity }
   *
   * Returns { id, title, salary, equity, companyHandle }
   *
   * Throws NotFoundError if not found.
   */
  static async update(id, data) {
    const { setCols, values } = sqlForPartialUpdate(
      data,
      {}
    );

    const { data: updatedJob, error } = await supabase
      .from('jobs')
      .update(setCols)
      .eq('id', id)
      .select();

    if (error || !updatedJob) {
      throw new NotFoundError(`No job: ${id}`);
    }

    return updatedJob[0];
  }

  /** Delete given job from database; returns undefined.
   *
   * Throws NotFoundError if company not found.
   **/
  static async remove(id) {
    const { data: job, error } = await supabase
      .from('jobs')
      .delete()
      .eq('id', id)
      .select();

    if (error || !job) {
      throw new NotFoundError(`No job: ${id}`);
    }
  }
}

module.exports = Job;

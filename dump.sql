--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY "public"."jobs" DROP CONSTRAINT IF EXISTS "jobs_company_handle_fkey";
ALTER TABLE IF EXISTS ONLY "public"."applications" DROP CONSTRAINT IF EXISTS "applications_username_fkey";
ALTER TABLE IF EXISTS ONLY "public"."applications" DROP CONSTRAINT IF EXISTS "applications_job_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."users" DROP CONSTRAINT IF EXISTS "users_pkey";
ALTER TABLE IF EXISTS ONLY "public"."jobs" DROP CONSTRAINT IF EXISTS "jobs_pkey";
ALTER TABLE IF EXISTS ONLY "public"."companies" DROP CONSTRAINT IF EXISTS "companies_pkey";
ALTER TABLE IF EXISTS ONLY "public"."companies" DROP CONSTRAINT IF EXISTS "companies_name_key";
ALTER TABLE IF EXISTS ONLY "public"."applications" DROP CONSTRAINT IF EXISTS "applications_pkey";
ALTER TABLE IF EXISTS "public"."jobs" ALTER COLUMN "id" DROP DEFAULT;
DROP TABLE IF EXISTS "public"."users";
DROP SEQUENCE IF EXISTS "public"."jobs_id_seq";
DROP TABLE IF EXISTS "public"."jobs";
DROP TABLE IF EXISTS "public"."companies";
DROP TABLE IF EXISTS "public"."applications";
--
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."applications" (
    "username" character varying(25) NOT NULL,
    "job_id" integer NOT NULL
);


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."companies" (
    "handle" character varying(25) NOT NULL,
    "name" "text" NOT NULL,
    "num_employees" integer,
    "description" "text" NOT NULL,
    "logo_url" "text",
    CONSTRAINT "companies_handle_check" CHECK ((("handle")::"text" = "lower"(("handle")::"text"))),
    CONSTRAINT "companies_num_employees_check" CHECK (("num_employees" >= 0))
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."jobs" (
    "id" integer NOT NULL,
    "title" "text" NOT NULL,
    "salary" integer,
    "equity" numeric,
    "company_handle" character varying(25) NOT NULL,
    CONSTRAINT "jobs_equity_check" CHECK (("equity" <= 1.0)),
    CONSTRAINT "jobs_salary_check" CHECK (("salary" >= 0))
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."jobs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."jobs_id_seq" OWNED BY "public"."jobs"."id";


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."users" (
    "username" character varying(25) NOT NULL,
    "password" "text" NOT NULL,
    "first_name" "text" NOT NULL,
    "last_name" "text" NOT NULL,
    "email" "text" NOT NULL,
    "is_admin" boolean DEFAULT false NOT NULL,
    CONSTRAINT "users_email_check" CHECK ((POSITION(('@'::"text") IN ("email")) > 1))
);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."jobs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."jobs_id_seq"'::"regclass");


--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."applications" ("username", "job_id") FROM stdin;
testuser	800
testuser	200
testuser	1200
testuser	400
testuser	1000
testuser	36
testuser	850
testuser	236
testuser	836
testuser	561
testuser	895
testuser	1161
testuser	961
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."companies" ("handle", "name", "num_employees", "description", "logo_url") FROM stdin;
bauer-gallagher	Bauer-Gallagher	862	Difficult ready trip question produce produce someone.	\N
edwards-lee-reese	Edwards, Lee and Reese	744	To much recent it reality coach decision Mr. Dog language evidence minute either deep situation pattern. Other cold bad loss surface real show.	/logos/logo2.png
hall-davis	Hall-Davis	749	Adult go economic off into. Suddenly happy according only common. Father plant wrong free traditional.	/logos/logo2.png
watson-davis	Watson-Davis	819	Year join loss.	/logos/logo3.png
baker-santos	Baker-Santos	225	Compare certain use. Writer time lay word garden. Resource task interesting voice.	/logos/logo3.png
erickson-inc	Erickson Inc	267	Interesting environment owner beautiful school politics. General friend hair player dinner last administration teacher.	/logos/logo4.png
norman-harvey	Norman-Harvey	\N	Drop along test material education. Opportunity forget campaign federal certainly total hair.	/logos/logo4.png
boyd-evans	Boyd-Evans	698	Build respond generation tree. No five keep. Happy medical back fine focus suffer modern.	/logos/logo4.png
mitchell-brown	Mitchell-Brown	288	Republican truth church generation voice price issue.	/logos/logo1.png
russo-gillespie-conrad	Russo, Gillespie and Conrad	398	South sound knowledge guy. Up I size anyone issue drop. Agent light significant mouth while.	/logos/logo2.png
ingram-ferguson-rubio	Ingram, Ferguson and Rubio	753	Human summer field mean impact could exactly. Business read north project will. Left dream use Democrat.	/logos/logo3.png
anderson-arias-morrow	Anderson, Arias and Morrow	245	Somebody program how I. Face give away discussion view act inside. Your official relationship administration here.	/logos/logo3.png
jackson-sons	Jackson and Sons	649	President couple political sit create.	/logos/logo4.png
miller-woods-hernandez	Miller, Woods and Hernandez	444	Including theory protect reveal energy himself probably. Test leave mother area however.	/logos/logo4.png
arnold-berger-townsend	Arnold, Berger and Townsend	795	Kind crime at perhaps beat. Enjoy deal purpose serve begin or thought. Congress everything miss tend.	\N
davis-davis	Davis-Davis	23	Career participant difficult. Decide claim particular century society. Question growth two staff.	\N
smith-llc	Smith LLC	908	Statement use per mission method. Order truth method.	\N
morgan-sullivan	Morgan-Sullivan	409	Own once artist part put authority wait. Focus free even. Why friend civil visit.	\N
taylor-yu-lee	Taylor, Yu and Lee	226	Down bag serve. Officer season company.	/logos/logo2.png
scott-smith	Scott-Smith	993	Room newspaper foot. Student daughter their themselves top almost near. Wait time recently it street follow medical nothing.	/logos/logo2.png
garcia-ray	Garcia-Ray	217	Laugh low follow fear. Politics main size fine.	/logos/logo2.png
logan-miller	Logan-Miller	429	Pattern hand where never. Social across ability which structure.	\N
hudson-inc	Hudson Inc	627	End now meet staff. Long government force why bar. Provide bring hope staff almost many be a.	\N
rivas-llc	Rivas LLC	552	Would road lot research wide mouth. Resource along office drug.	\N
garner-michael	Garner-Michael	940	Necessary thousand parent since discuss director. Visit machine skill five the.	\N
owen-newton	Owen-Newton	953	Red compare try way. Bed standard again number wrong force. Stop exactly agent product economy someone. North describe site manager employee customer.	\N
foster-rice	Foster-Rice	901	Either relate himself. Source TV data one general. Actually than seat eight.	\N
moore-plc	Moore PLC	100	Magazine thing eight shake window might they organization. Environmental it bag green.	\N
ayala-buchanan	Ayala-Buchanan	309	Make radio physical southern. His white on attention kitchen market upon. Represent west open seven. Particularly subject billion much score thank bag somebody.	\N
willis-henson-miller	Willis, Henson and Miller	821	About dream practice. Father significant senior health within four.	\N
stone-stewart	Stone-Stewart	459	Require successful family but. Traditional article late eight lose common send budget. Better opportunity law country various represent strong probably.	\N
wiggins-frederick-boyer	Wiggins, Frederick and Boyer	298	Institution structure say argue bit. Each option high executive easy pattern. Majority white hour there reach drive produce.	/logos/logo2.png
reynolds-greene	Reynolds-Greene	343	Effect win area officer office economy. Congress travel would resource difficult. Nice president mind dinner.	/logos/logo2.png
perez-miller	Perez-Miller	298	Space one approach wife son. Themselves give necessary follow employee return feel. Step animal doctor sign water early.	/logos/logo4.png
burton-ltd	Burton Ltd	610	Cover couple speech bar cell measure movement finally. Nation pull inside.	/logos/logo4.png
gillespie-smith	Gillespie-Smith	302	Candidate ability democratic make drug. Player themselves like front. Over through style loss win very when.	/logos/logo1.png
martinez-daniels	Martinez-Daniels	12	Five source market nation. Drop foreign raise pass.	/logos/logo4.png
jackson-davila-conley	Jackson, Davila and Conley	813	Consider with build either.	/logos/logo4.png
salas-group	Salas Group	624	Central whom mouth partner bring newspaper special city. Show second cost newspaper can early play.	/logos/logo4.png
thomas-sons	Thomas and Sons	51	Book detail scene continue. Art strategy because list two.	/logos/logo1.png
mejia-scott-ryan	Mejia, Scott and Ryan	\N	General traditional late situation discussion dog. Before best up strategy about direction.	/logos/logo4.png
mueller-moore	Mueller-Moore	932	Edge may report though least pressure likely. Cost short appear program hair seven.	/logos/logo2.png
pugh-ltd	Pugh Ltd	87	Believe reflect perform TV son.	/logos/logo2.png
carr-wells-jones	Carr, Wells and Jones	27	Human medical throw book pick possible. Maybe yeah word beat treatment impact campaign.	/logos/logo3.png
hall-mills	Hall-Mills	266	Change stage tell note hundred. Worry where program wait.	/logos/logo3.png
robbins-marsh-martin	Robbins, Marsh and Martin	709	Now never worry usually another ability concern hair. Fly lot six protect participant. Teach through head.	/logos/logo3.png
sellers-bryant	Sellers-Bryant	369	Language discussion mission soon wait according executive. Financial say husband anyone money politics. Dinner action purpose mouth environment I white.	/logos/logo3.png
humphrey-llc	Humphrey LLC	678	Agent actually able paper nor. Tell then court full agree without assume.	/logos/logo4.png
graham-herring-lane	Graham, Herring and Lane	188	Enough attack return. Fall gas someone her another point those. Star public painting show concern.	/logos/logo4.png
weber-hernandez	Weber-Hernandez	681	Contain product south picture scientist.	/logos/logo4.png
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."jobs" ("id", "title", "salary", "equity", "company_handle") FROM stdin;
1	Conservator, furniture	110000	0	watson-davis
2	Information officer	200000	0	hall-mills
3	Consulting civil engineer	60000	0	sellers-bryant
4	Early years teacher	55000	0	perez-miller
5	Intelligence analyst	77000	0	garner-michael
6	Surveyor, building	144000	0	russo-gillespie-conrad
7	Technical brewer	157000	0	anderson-arias-morrow
8	Control and instrumentation engineer	171000	0	salas-group
9	Photographer	198000	0	davis-davis
10	Multimedia programmer	192000	0	graham-herring-lane
11	English as a foreign language teacher	111000	0	russo-gillespie-conrad
12	Passenger transport manager	70000	0	rivas-llc
13	Psychologist, clinical	172000	0	hudson-inc
14	Financial planner	115000	0	taylor-yu-lee
15	Scientist, forensic	50000	0	foster-rice
16	Occupational therapist	183000	0	garcia-ray
17	Ophthalmologist	135000	0	hall-mills
18	Embryologist, clinical	138000	0	anderson-arias-morrow
19	Marine scientist	54000	0	scott-smith
20	Tourist information centre manager	88000	0	foster-rice
21	Interior and spatial designer	177000	0	gillespie-smith
22	Surveyor, rural practice	193000	0	weber-hernandez
23	Colour technologist	81000	0	burton-ltd
24	Technical brewer	77000	0	thomas-sons
25	Pharmacist, hospital	194000	0	boyd-evans
26	Medical sales representative	125000	0	jackson-davila-conley
27	Energy engineer	62000	0	norman-harvey
28	Research officer, government	167000	0	mejia-scott-ryan
29	Barrister	130000	0	stone-stewart
30	Loss adjuster, chartered	76000	0	bauer-gallagher
31	Database administrator	79000	0	willis-henson-miller
32	IT consultant	59000	0	gillespie-smith
33	Museum/gallery conservator	82000	0	mejia-scott-ryan
34	Engineering geologist	170000	0	garcia-ray
35	Television production assistant	125000	0	logan-miller
36	Accountant, chartered certified	175000	0	stone-stewart
37	Merchant navy officer	106000	0	mitchell-brown
38	Medical physicist	84000	0	perez-miller
39	Podiatrist	68000	\N	reynolds-greene
40	Nurse, children's	162000	\N	humphrey-llc
41	Teacher, music	127000	\N	ingram-ferguson-rubio
42	Occupational hygienist	79000	\N	reynolds-greene
43	Research officer, political party	134000	\N	garner-michael
44	Therapist, occupational	82000	\N	mejia-scott-ryan
45	Teacher, secondary school	127000	\N	sellers-bryant
46	Scientist, product/process development	106000	\N	scott-smith
47	Astronomer	143000	\N	watson-davis
48	Counsellor	\N	0	owen-newton
49	Financial controller	\N	0	sellers-bryant
50	Advertising account executive	\N	0	thomas-sons
51	Buyer, industrial	\N	\N	reynolds-greene
52	Interpreter	55000	0	hudson-inc
53	Best boy	\N	0	jackson-sons
54	Freight forwarder	183000	0	hudson-inc
55	Designer, jewellery	\N	0	weber-hernandez
56	Tree surgeon	\N	0.001	hall-davis
57	Management consultant	183000	0	edwards-lee-reese
58	Ergonomist	160000	0	bauer-gallagher
59	Psychologist, forensic	176000	0	boyd-evans
60	Architectural technologist	57000	0	owen-newton
61	Patent attorney	143000	0	foster-rice
62	Art gallery manager	\N	0.085	anderson-arias-morrow
63	Engineer, chemical	81000	0	russo-gillespie-conrad
64	Speech and language therapist	159000	0	gillespie-smith
65	Orthoptist	200000	0	perez-miller
66	Camera operator	130000	0	arnold-berger-townsend
67	Field trials officer	137000	0	davis-davis
68	Transport planner	\N	\N	reynolds-greene
69	Bonds trader	\N	\N	mitchell-brown
70	Editor, magazine features	118000	0.002	foster-rice
71	Applications developer	84000	0.091	sellers-bryant
72	Clothing/textile technologist	171000	0.041	smith-llc
73	Secretary/administrator	172000	0.096	jackson-sons
74	Field seismologist	62000	0.064	martinez-daniels
75	Engineer, materials	185000	0.081	garner-michael
76	Race relations officer	97000	0.065	bauer-gallagher
77	Engineering geologist	89000	0.043	ayala-buchanan
78	Aeronautical engineer	135000	0.078	norman-harvey
79	Development worker, community	192000	0.047	weber-hernandez
80	Speech and language therapist	154000	0.014	humphrey-llc
81	Health promotion specialist	72000	0.010	burton-ltd
82	Careers adviser	57000	0.051	carr-wells-jones
83	Surveyor, minerals	98000	0.037	carr-wells-jones
84	Forest/woodland manager	156000	0.030	carr-wells-jones
85	Haematologist	63000	0.062	ayala-buchanan
86	Advertising account executive	130000	0.064	thomas-sons
87	Ship broker	124000	0.045	davis-davis
88	Fisheries officer	67000	0.062	hall-davis
89	Air cabin crew	105000	0.077	ingram-ferguson-rubio
90	Financial trader	153000	0.012	garner-michael
91	Paramedic	122000	0.047	baker-santos
92	Historic buildings inspector/conservation officer	129000	0.052	watson-davis
93	Transport planner	123000	0.091	hudson-inc
94	Public librarian	115000	0.099	norman-harvey
95	Writer	172000	0.091	anderson-arias-morrow
96	Designer, fashion/clothing	81000	0.026	garcia-ray
97	Information systems manager	123000	0.100	arnold-berger-townsend
98	Art gallery manager	73000	0.054	perez-miller
99	Operational researcher	167000	0.020	ayala-buchanan
100	Solicitor	131000	0.034	wiggins-frederick-boyer
101	Intelligence analyst	148000	0	sellers-bryant
102	Naval architect	126000	0	scott-smith
103	Dealer	175000	0	hall-mills
104	Multimedia programmer	154000	\N	owen-newton
105	Psychologist, occupational	190000	\N	robbins-marsh-martin
106	Leisure centre manager	135000	\N	edwards-lee-reese
107	Television production assistant	99000	\N	edwards-lee-reese
108	Historic buildings inspector/conservation officer	135000	\N	rivas-llc
109	Sports development officer	102000	\N	scott-smith
110	Investment banker, corporate	131000	\N	ingram-ferguson-rubio
111	Conservation officer, historic buildings	168000	\N	robbins-marsh-martin
112	Physicist, medical	190000	\N	humphrey-llc
113	Press sub	100000	\N	erickson-inc
114	Engineer, civil (contracting)	\N	0.018	moore-plc
115	Therapist, music	103000	0.087	reynolds-greene
116	Water engineer	\N	0.028	mejia-scott-ryan
117	Engineer, energy	\N	0.048	arnold-berger-townsend
118	Plant breeder/geneticist	\N	0.081	thomas-sons
119	Oceanographer	\N	0.097	anderson-arias-morrow
120	Clinical cytogeneticist	152000	0.027	mitchell-brown
121	Nature conservation officer	82000	0.093	watson-davis
122	Insurance underwriter	\N	0.008	hall-davis
123	Chief of Staff	110000	0.016	scott-smith
124	Surveyor, insurance	\N	0.066	foster-rice
125	Surveyor, building control	\N	\N	reynolds-greene
126	Trade mark attorney	\N	\N	mueller-moore
127	Glass blower/designer	126000	0.099	anderson-arias-morrow
128	Geochemist	130000	0.004	smith-llc
129	Scientist, research (physical sciences)	117000	0.090	ayala-buchanan
130	Historic buildings inspector/conservation officer	65000	0.075	mejia-scott-ryan
131	Surveyor, insurance	130000	0.009	martinez-daniels
132	Contractor	89000	0.065	mueller-moore
133	Hydrologist	50000	0.097	wiggins-frederick-boyer
134	Aeronautical engineer	156000	0.055	perez-miller
135	Freight forwarder	183000	0.093	burton-ltd
136	Engineer, materials	140000	0.057	mitchell-brown
137	Product designer	184000	0.090	gillespie-smith
138	Editor, film/video	199000	0.070	bauer-gallagher
139	Fashion designer	131000	0.080	taylor-yu-lee
140	Legal secretary	155000	0.080	pugh-ltd
141	Financial risk analyst	72000	0.001	scott-smith
142	Regulatory affairs officer	96000	0.061	logan-miller
143	Ranger/warden	86000	0.095	ayala-buchanan
144	Farm manager	138000	0.085	stone-stewart
145	Primary school teacher	142000	0.036	moore-plc
146	Quality manager	138000	0.002	russo-gillespie-conrad
147	Radio producer	99000	0.038	mitchell-brown
148	Music therapist	100000	0.058	taylor-yu-lee
149	Farm manager	68000	0.049	morgan-sullivan
150	Camera operator	51000	0.066	jackson-davila-conley
151	Engineer, technical sales	167000	0.077	ingram-ferguson-rubio
152	Ranger/warden	145000	0.046	jackson-davila-conley
153	Lawyer	162000	0.072	hall-mills
154	Estate manager/land agent	94000	0.008	jackson-davila-conley
155	Orthoptist	129000	0.062	willis-henson-miller
156	Recycling officer	57000	0.098	carr-wells-jones
157	Scientist, research (life sciences)	157000	0.057	ayala-buchanan
158	Armed forces technical officer	136000	0.012	scott-smith
159	Public relations officer	112000	0.087	weber-hernandez
160	Set designer	132000	0.055	russo-gillespie-conrad
161	Accountant, chartered certified	86000	0.070	boyd-evans
162	Special effects artist	101000	0.023	willis-henson-miller
163	Glass blower/designer	60000	0.095	mueller-moore
164	Print production planner	197000	0.095	humphrey-llc
165	Psychologist, counselling	180000	0.008	perez-miller
166	Meteorologist	81000	0.037	sellers-bryant
167	Therapist, drama	200000	0.095	hall-mills
168	Engineer, technical sales	157000	0.083	baker-santos
169	Scientist, audiological	61000	0.095	foster-rice
170	Dietitian	198000	0	ayala-buchanan
171	Electrical engineer	157000	\N	jackson-davila-conley
172	Agricultural consultant	67000	\N	moore-plc
173	Geochemist	104000	\N	hudson-inc
174	Geologist, engineering	116000	\N	jackson-davila-conley
175	Clinical biochemist	92000	\N	norman-harvey
176	Probation officer	128000	\N	foster-rice
177	Chief Executive Officer	83000	\N	miller-woods-hernandez
178	Surveyor, building	144000	0.007	salas-group
179	Engineer, water	165000	0.010	ingram-ferguson-rubio
180	Psychologist, counselling	111000	0.059	taylor-yu-lee
181	Astronomer	55000	0.074	martinez-daniels
182	Medical physicist	110000	0.015	mitchell-brown
183	Chief Technology Officer	64000	0.067	robbins-marsh-martin
184	Arboriculturist	191000	0.062	salas-group
185	Conservation officer, nature	108000	0.006	jackson-davila-conley
186	Psychologist, sport and exercise	172000	0.061	ayala-buchanan
187	Designer, furniture	149000	0.041	mueller-moore
188	Chartered loss adjuster	72000	0.084	davis-davis
189	Producer, radio	168000	0.010	salas-group
190	Operational investment banker	200000	0.022	smith-llc
191	Surveyor, quantity	72000	0.071	mejia-scott-ryan
192	Ship broker	177000	0	hall-davis
193	Bookseller	164000	0	reynolds-greene
194	Medical sales representative	196000	0	hall-mills
195	Copy	103000	0	foster-rice
196	Engineer, broadcasting (operations)	86000	0	baker-santos
197	Fashion designer	137000	0	reynolds-greene
198	Learning disability nurse	66000	\N	ayala-buchanan
199	Research scientist (medical)	175000	\N	norman-harvey
200	Accommodation manager	126000	\N	mejia-scott-ryan
201	Conservator, furniture	110000	0	watson-davis
202	Information officer	200000	0	hall-mills
203	Consulting civil engineer	60000	0	sellers-bryant
204	Early years teacher	55000	0	perez-miller
205	Intelligence analyst	77000	0	garner-michael
206	Surveyor, building	144000	0	russo-gillespie-conrad
207	Technical brewer	157000	0	anderson-arias-morrow
208	Control and instrumentation engineer	171000	0	salas-group
209	Photographer	198000	0	davis-davis
210	Multimedia programmer	192000	0	graham-herring-lane
211	English as a foreign language teacher	111000	0	russo-gillespie-conrad
212	Passenger transport manager	70000	0	rivas-llc
213	Psychologist, clinical	172000	0	hudson-inc
214	Financial planner	115000	0	taylor-yu-lee
215	Scientist, forensic	50000	0	foster-rice
216	Occupational therapist	183000	0	garcia-ray
217	Ophthalmologist	135000	0	hall-mills
218	Embryologist, clinical	138000	0	anderson-arias-morrow
219	Marine scientist	54000	0	scott-smith
220	Tourist information centre manager	88000	0	foster-rice
221	Interior and spatial designer	177000	0	gillespie-smith
222	Surveyor, rural practice	193000	0	weber-hernandez
223	Colour technologist	81000	0	burton-ltd
224	Technical brewer	77000	0	thomas-sons
225	Pharmacist, hospital	194000	0	boyd-evans
226	Medical sales representative	125000	0	jackson-davila-conley
227	Energy engineer	62000	0	norman-harvey
228	Research officer, government	167000	0	mejia-scott-ryan
229	Barrister	130000	0	stone-stewart
230	Loss adjuster, chartered	76000	0	bauer-gallagher
231	Database administrator	79000	0	willis-henson-miller
232	IT consultant	59000	0	gillespie-smith
233	Museum/gallery conservator	82000	0	mejia-scott-ryan
234	Engineering geologist	170000	0	garcia-ray
235	Television production assistant	125000	0	logan-miller
236	Accountant, chartered certified	175000	0	stone-stewart
237	Merchant navy officer	106000	0	mitchell-brown
238	Medical physicist	84000	0	perez-miller
239	Podiatrist	68000	\N	reynolds-greene
240	Nurse, children's	162000	\N	humphrey-llc
241	Teacher, music	127000	\N	ingram-ferguson-rubio
242	Occupational hygienist	79000	\N	reynolds-greene
243	Research officer, political party	134000	\N	garner-michael
244	Therapist, occupational	82000	\N	mejia-scott-ryan
245	Teacher, secondary school	127000	\N	sellers-bryant
246	Scientist, product/process development	106000	\N	scott-smith
247	Astronomer	143000	\N	watson-davis
248	Counsellor	\N	0	owen-newton
249	Financial controller	\N	0	sellers-bryant
250	Advertising account executive	\N	0	thomas-sons
251	Buyer, industrial	\N	\N	reynolds-greene
252	Interpreter	55000	0	hudson-inc
253	Best boy	\N	0	jackson-sons
254	Freight forwarder	183000	0	hudson-inc
255	Designer, jewellery	\N	0	weber-hernandez
256	Tree surgeon	\N	0.001	hall-davis
257	Management consultant	183000	0	edwards-lee-reese
258	Ergonomist	160000	0	bauer-gallagher
259	Psychologist, forensic	176000	0	boyd-evans
260	Architectural technologist	57000	0	owen-newton
261	Patent attorney	143000	0	foster-rice
262	Art gallery manager	\N	0.085	anderson-arias-morrow
263	Engineer, chemical	81000	0	russo-gillespie-conrad
264	Speech and language therapist	159000	0	gillespie-smith
265	Orthoptist	200000	0	perez-miller
266	Camera operator	130000	0	arnold-berger-townsend
267	Field trials officer	137000	0	davis-davis
268	Transport planner	\N	\N	reynolds-greene
269	Bonds trader	\N	\N	mitchell-brown
270	Editor, magazine features	118000	0.002	foster-rice
271	Applications developer	84000	0.091	sellers-bryant
272	Clothing/textile technologist	171000	0.041	smith-llc
273	Secretary/administrator	172000	0.096	jackson-sons
274	Field seismologist	62000	0.064	martinez-daniels
275	Engineer, materials	185000	0.081	garner-michael
276	Race relations officer	97000	0.065	bauer-gallagher
277	Engineering geologist	89000	0.043	ayala-buchanan
278	Aeronautical engineer	135000	0.078	norman-harvey
279	Development worker, community	192000	0.047	weber-hernandez
280	Speech and language therapist	154000	0.014	humphrey-llc
281	Health promotion specialist	72000	0.010	burton-ltd
282	Careers adviser	57000	0.051	carr-wells-jones
283	Surveyor, minerals	98000	0.037	carr-wells-jones
284	Forest/woodland manager	156000	0.030	carr-wells-jones
285	Haematologist	63000	0.062	ayala-buchanan
286	Advertising account executive	130000	0.064	thomas-sons
287	Ship broker	124000	0.045	davis-davis
288	Fisheries officer	67000	0.062	hall-davis
289	Air cabin crew	105000	0.077	ingram-ferguson-rubio
290	Financial trader	153000	0.012	garner-michael
291	Paramedic	122000	0.047	baker-santos
292	Historic buildings inspector/conservation officer	129000	0.052	watson-davis
293	Transport planner	123000	0.091	hudson-inc
294	Public librarian	115000	0.099	norman-harvey
295	Writer	172000	0.091	anderson-arias-morrow
296	Designer, fashion/clothing	81000	0.026	garcia-ray
297	Information systems manager	123000	0.100	arnold-berger-townsend
298	Art gallery manager	73000	0.054	perez-miller
299	Operational researcher	167000	0.020	ayala-buchanan
300	Solicitor	131000	0.034	wiggins-frederick-boyer
301	Intelligence analyst	148000	0	sellers-bryant
302	Naval architect	126000	0	scott-smith
303	Dealer	175000	0	hall-mills
304	Multimedia programmer	154000	\N	owen-newton
305	Psychologist, occupational	190000	\N	robbins-marsh-martin
306	Leisure centre manager	135000	\N	edwards-lee-reese
307	Television production assistant	99000	\N	edwards-lee-reese
308	Historic buildings inspector/conservation officer	135000	\N	rivas-llc
309	Sports development officer	102000	\N	scott-smith
310	Investment banker, corporate	131000	\N	ingram-ferguson-rubio
311	Conservation officer, historic buildings	168000	\N	robbins-marsh-martin
312	Physicist, medical	190000	\N	humphrey-llc
313	Press sub	100000	\N	erickson-inc
314	Engineer, civil (contracting)	\N	0.018	moore-plc
315	Therapist, music	103000	0.087	reynolds-greene
316	Water engineer	\N	0.028	mejia-scott-ryan
317	Engineer, energy	\N	0.048	arnold-berger-townsend
318	Plant breeder/geneticist	\N	0.081	thomas-sons
319	Oceanographer	\N	0.097	anderson-arias-morrow
320	Clinical cytogeneticist	152000	0.027	mitchell-brown
321	Nature conservation officer	82000	0.093	watson-davis
322	Insurance underwriter	\N	0.008	hall-davis
323	Chief of Staff	110000	0.016	scott-smith
324	Surveyor, insurance	\N	0.066	foster-rice
325	Surveyor, building control	\N	\N	reynolds-greene
326	Trade mark attorney	\N	\N	mueller-moore
327	Glass blower/designer	126000	0.099	anderson-arias-morrow
328	Geochemist	130000	0.004	smith-llc
329	Scientist, research (physical sciences)	117000	0.090	ayala-buchanan
330	Historic buildings inspector/conservation officer	65000	0.075	mejia-scott-ryan
331	Surveyor, insurance	130000	0.009	martinez-daniels
332	Contractor	89000	0.065	mueller-moore
333	Hydrologist	50000	0.097	wiggins-frederick-boyer
334	Aeronautical engineer	156000	0.055	perez-miller
335	Freight forwarder	183000	0.093	burton-ltd
336	Engineer, materials	140000	0.057	mitchell-brown
337	Product designer	184000	0.090	gillespie-smith
338	Editor, film/video	199000	0.070	bauer-gallagher
339	Fashion designer	131000	0.080	taylor-yu-lee
340	Legal secretary	155000	0.080	pugh-ltd
341	Financial risk analyst	72000	0.001	scott-smith
342	Regulatory affairs officer	96000	0.061	logan-miller
343	Ranger/warden	86000	0.095	ayala-buchanan
344	Farm manager	138000	0.085	stone-stewart
345	Primary school teacher	142000	0.036	moore-plc
346	Quality manager	138000	0.002	russo-gillespie-conrad
347	Radio producer	99000	0.038	mitchell-brown
348	Music therapist	100000	0.058	taylor-yu-lee
349	Farm manager	68000	0.049	morgan-sullivan
350	Camera operator	51000	0.066	jackson-davila-conley
351	Engineer, technical sales	167000	0.077	ingram-ferguson-rubio
352	Ranger/warden	145000	0.046	jackson-davila-conley
353	Lawyer	162000	0.072	hall-mills
354	Estate manager/land agent	94000	0.008	jackson-davila-conley
355	Orthoptist	129000	0.062	willis-henson-miller
356	Recycling officer	57000	0.098	carr-wells-jones
357	Scientist, research (life sciences)	157000	0.057	ayala-buchanan
358	Armed forces technical officer	136000	0.012	scott-smith
359	Public relations officer	112000	0.087	weber-hernandez
360	Set designer	132000	0.055	russo-gillespie-conrad
361	Accountant, chartered certified	86000	0.070	boyd-evans
362	Special effects artist	101000	0.023	willis-henson-miller
363	Glass blower/designer	60000	0.095	mueller-moore
364	Print production planner	197000	0.095	humphrey-llc
365	Psychologist, counselling	180000	0.008	perez-miller
366	Meteorologist	81000	0.037	sellers-bryant
367	Therapist, drama	200000	0.095	hall-mills
368	Engineer, technical sales	157000	0.083	baker-santos
369	Scientist, audiological	61000	0.095	foster-rice
370	Dietitian	198000	0	ayala-buchanan
371	Electrical engineer	157000	\N	jackson-davila-conley
372	Agricultural consultant	67000	\N	moore-plc
373	Geochemist	104000	\N	hudson-inc
374	Geologist, engineering	116000	\N	jackson-davila-conley
375	Clinical biochemist	92000	\N	norman-harvey
376	Probation officer	128000	\N	foster-rice
377	Chief Executive Officer	83000	\N	miller-woods-hernandez
378	Surveyor, building	144000	0.007	salas-group
379	Engineer, water	165000	0.010	ingram-ferguson-rubio
380	Psychologist, counselling	111000	0.059	taylor-yu-lee
381	Astronomer	55000	0.074	martinez-daniels
382	Medical physicist	110000	0.015	mitchell-brown
383	Chief Technology Officer	64000	0.067	robbins-marsh-martin
384	Arboriculturist	191000	0.062	salas-group
385	Conservation officer, nature	108000	0.006	jackson-davila-conley
386	Psychologist, sport and exercise	172000	0.061	ayala-buchanan
387	Designer, furniture	149000	0.041	mueller-moore
388	Chartered loss adjuster	72000	0.084	davis-davis
389	Producer, radio	168000	0.010	salas-group
390	Operational investment banker	200000	0.022	smith-llc
391	Surveyor, quantity	72000	0.071	mejia-scott-ryan
392	Ship broker	177000	0	hall-davis
393	Bookseller	164000	0	reynolds-greene
394	Medical sales representative	196000	0	hall-mills
395	Copy	103000	0	foster-rice
396	Engineer, broadcasting (operations)	86000	0	baker-santos
397	Fashion designer	137000	0	reynolds-greene
398	Learning disability nurse	66000	\N	ayala-buchanan
399	Research scientist (medical)	175000	\N	norman-harvey
400	Accommodation manager	126000	\N	mejia-scott-ryan
401	Conservator, furniture	110000	0	watson-davis
402	Information officer	200000	0	hall-mills
403	Consulting civil engineer	60000	0	sellers-bryant
404	Early years teacher	55000	0	perez-miller
405	Intelligence analyst	77000	0	garner-michael
406	Surveyor, building	144000	0	russo-gillespie-conrad
407	Technical brewer	157000	0	anderson-arias-morrow
408	Control and instrumentation engineer	171000	0	salas-group
409	Photographer	198000	0	davis-davis
410	Multimedia programmer	192000	0	graham-herring-lane
411	English as a foreign language teacher	111000	0	russo-gillespie-conrad
412	Passenger transport manager	70000	0	rivas-llc
413	Psychologist, clinical	172000	0	hudson-inc
414	Financial planner	115000	0	taylor-yu-lee
415	Scientist, forensic	50000	0	foster-rice
416	Occupational therapist	183000	0	garcia-ray
417	Ophthalmologist	135000	0	hall-mills
418	Embryologist, clinical	138000	0	anderson-arias-morrow
419	Marine scientist	54000	0	scott-smith
420	Tourist information centre manager	88000	0	foster-rice
421	Interior and spatial designer	177000	0	gillespie-smith
422	Surveyor, rural practice	193000	0	weber-hernandez
423	Colour technologist	81000	0	burton-ltd
424	Technical brewer	77000	0	thomas-sons
425	Pharmacist, hospital	194000	0	boyd-evans
426	Medical sales representative	125000	0	jackson-davila-conley
427	Energy engineer	62000	0	norman-harvey
428	Research officer, government	167000	0	mejia-scott-ryan
429	Barrister	130000	0	stone-stewart
430	Loss adjuster, chartered	76000	0	bauer-gallagher
431	Database administrator	79000	0	willis-henson-miller
432	IT consultant	59000	0	gillespie-smith
433	Museum/gallery conservator	82000	0	mejia-scott-ryan
434	Engineering geologist	170000	0	garcia-ray
435	Television production assistant	125000	0	logan-miller
436	Accountant, chartered certified	175000	0	stone-stewart
437	Merchant navy officer	106000	0	mitchell-brown
438	Medical physicist	84000	0	perez-miller
439	Podiatrist	68000	\N	reynolds-greene
440	Nurse, children's	162000	\N	humphrey-llc
441	Teacher, music	127000	\N	ingram-ferguson-rubio
442	Occupational hygienist	79000	\N	reynolds-greene
443	Research officer, political party	134000	\N	garner-michael
444	Therapist, occupational	82000	\N	mejia-scott-ryan
445	Teacher, secondary school	127000	\N	sellers-bryant
446	Scientist, product/process development	106000	\N	scott-smith
447	Astronomer	143000	\N	watson-davis
448	Counsellor	\N	0	owen-newton
449	Financial controller	\N	0	sellers-bryant
450	Advertising account executive	\N	0	thomas-sons
451	Buyer, industrial	\N	\N	reynolds-greene
452	Interpreter	55000	0	hudson-inc
453	Best boy	\N	0	jackson-sons
454	Freight forwarder	183000	0	hudson-inc
455	Designer, jewellery	\N	0	weber-hernandez
456	Tree surgeon	\N	0.001	hall-davis
457	Management consultant	183000	0	edwards-lee-reese
458	Ergonomist	160000	0	bauer-gallagher
459	Psychologist, forensic	176000	0	boyd-evans
460	Architectural technologist	57000	0	owen-newton
461	Patent attorney	143000	0	foster-rice
462	Art gallery manager	\N	0.085	anderson-arias-morrow
463	Engineer, chemical	81000	0	russo-gillespie-conrad
464	Speech and language therapist	159000	0	gillespie-smith
465	Orthoptist	200000	0	perez-miller
466	Camera operator	130000	0	arnold-berger-townsend
467	Field trials officer	137000	0	davis-davis
468	Transport planner	\N	\N	reynolds-greene
469	Bonds trader	\N	\N	mitchell-brown
470	Editor, magazine features	118000	0.002	foster-rice
471	Applications developer	84000	0.091	sellers-bryant
472	Clothing/textile technologist	171000	0.041	smith-llc
473	Secretary/administrator	172000	0.096	jackson-sons
474	Field seismologist	62000	0.064	martinez-daniels
475	Engineer, materials	185000	0.081	garner-michael
476	Race relations officer	97000	0.065	bauer-gallagher
477	Engineering geologist	89000	0.043	ayala-buchanan
478	Aeronautical engineer	135000	0.078	norman-harvey
479	Development worker, community	192000	0.047	weber-hernandez
480	Speech and language therapist	154000	0.014	humphrey-llc
481	Health promotion specialist	72000	0.010	burton-ltd
482	Careers adviser	57000	0.051	carr-wells-jones
483	Surveyor, minerals	98000	0.037	carr-wells-jones
484	Forest/woodland manager	156000	0.030	carr-wells-jones
485	Haematologist	63000	0.062	ayala-buchanan
486	Advertising account executive	130000	0.064	thomas-sons
487	Ship broker	124000	0.045	davis-davis
488	Fisheries officer	67000	0.062	hall-davis
489	Air cabin crew	105000	0.077	ingram-ferguson-rubio
490	Financial trader	153000	0.012	garner-michael
491	Paramedic	122000	0.047	baker-santos
492	Historic buildings inspector/conservation officer	129000	0.052	watson-davis
493	Transport planner	123000	0.091	hudson-inc
494	Public librarian	115000	0.099	norman-harvey
495	Writer	172000	0.091	anderson-arias-morrow
496	Designer, fashion/clothing	81000	0.026	garcia-ray
497	Information systems manager	123000	0.100	arnold-berger-townsend
498	Art gallery manager	73000	0.054	perez-miller
499	Operational researcher	167000	0.020	ayala-buchanan
500	Solicitor	131000	0.034	wiggins-frederick-boyer
501	Intelligence analyst	148000	0	sellers-bryant
502	Naval architect	126000	0	scott-smith
503	Dealer	175000	0	hall-mills
504	Multimedia programmer	154000	\N	owen-newton
505	Psychologist, occupational	190000	\N	robbins-marsh-martin
506	Leisure centre manager	135000	\N	edwards-lee-reese
507	Television production assistant	99000	\N	edwards-lee-reese
508	Historic buildings inspector/conservation officer	135000	\N	rivas-llc
509	Sports development officer	102000	\N	scott-smith
510	Investment banker, corporate	131000	\N	ingram-ferguson-rubio
511	Conservation officer, historic buildings	168000	\N	robbins-marsh-martin
512	Physicist, medical	190000	\N	humphrey-llc
513	Press sub	100000	\N	erickson-inc
514	Engineer, civil (contracting)	\N	0.018	moore-plc
515	Therapist, music	103000	0.087	reynolds-greene
516	Water engineer	\N	0.028	mejia-scott-ryan
517	Engineer, energy	\N	0.048	arnold-berger-townsend
518	Plant breeder/geneticist	\N	0.081	thomas-sons
519	Oceanographer	\N	0.097	anderson-arias-morrow
520	Clinical cytogeneticist	152000	0.027	mitchell-brown
521	Nature conservation officer	82000	0.093	watson-davis
522	Insurance underwriter	\N	0.008	hall-davis
523	Chief of Staff	110000	0.016	scott-smith
524	Surveyor, insurance	\N	0.066	foster-rice
525	Surveyor, building control	\N	\N	reynolds-greene
526	Trade mark attorney	\N	\N	mueller-moore
527	Glass blower/designer	126000	0.099	anderson-arias-morrow
528	Geochemist	130000	0.004	smith-llc
529	Scientist, research (physical sciences)	117000	0.090	ayala-buchanan
530	Historic buildings inspector/conservation officer	65000	0.075	mejia-scott-ryan
531	Surveyor, insurance	130000	0.009	martinez-daniels
532	Contractor	89000	0.065	mueller-moore
533	Hydrologist	50000	0.097	wiggins-frederick-boyer
534	Aeronautical engineer	156000	0.055	perez-miller
535	Freight forwarder	183000	0.093	burton-ltd
536	Engineer, materials	140000	0.057	mitchell-brown
537	Product designer	184000	0.090	gillespie-smith
538	Editor, film/video	199000	0.070	bauer-gallagher
539	Fashion designer	131000	0.080	taylor-yu-lee
540	Legal secretary	155000	0.080	pugh-ltd
541	Financial risk analyst	72000	0.001	scott-smith
542	Regulatory affairs officer	96000	0.061	logan-miller
543	Ranger/warden	86000	0.095	ayala-buchanan
544	Farm manager	138000	0.085	stone-stewart
545	Primary school teacher	142000	0.036	moore-plc
546	Quality manager	138000	0.002	russo-gillespie-conrad
547	Radio producer	99000	0.038	mitchell-brown
548	Music therapist	100000	0.058	taylor-yu-lee
549	Farm manager	68000	0.049	morgan-sullivan
550	Camera operator	51000	0.066	jackson-davila-conley
551	Engineer, technical sales	167000	0.077	ingram-ferguson-rubio
552	Ranger/warden	145000	0.046	jackson-davila-conley
553	Lawyer	162000	0.072	hall-mills
554	Estate manager/land agent	94000	0.008	jackson-davila-conley
555	Orthoptist	129000	0.062	willis-henson-miller
556	Recycling officer	57000	0.098	carr-wells-jones
557	Scientist, research (life sciences)	157000	0.057	ayala-buchanan
558	Armed forces technical officer	136000	0.012	scott-smith
559	Public relations officer	112000	0.087	weber-hernandez
560	Set designer	132000	0.055	russo-gillespie-conrad
561	Accountant, chartered certified	86000	0.070	boyd-evans
562	Special effects artist	101000	0.023	willis-henson-miller
563	Glass blower/designer	60000	0.095	mueller-moore
564	Print production planner	197000	0.095	humphrey-llc
565	Psychologist, counselling	180000	0.008	perez-miller
566	Meteorologist	81000	0.037	sellers-bryant
567	Therapist, drama	200000	0.095	hall-mills
568	Engineer, technical sales	157000	0.083	baker-santos
569	Scientist, audiological	61000	0.095	foster-rice
570	Dietitian	198000	0	ayala-buchanan
571	Electrical engineer	157000	\N	jackson-davila-conley
572	Agricultural consultant	67000	\N	moore-plc
573	Geochemist	104000	\N	hudson-inc
574	Geologist, engineering	116000	\N	jackson-davila-conley
575	Clinical biochemist	92000	\N	norman-harvey
576	Probation officer	128000	\N	foster-rice
577	Chief Executive Officer	83000	\N	miller-woods-hernandez
578	Surveyor, building	144000	0.007	salas-group
579	Engineer, water	165000	0.010	ingram-ferguson-rubio
580	Psychologist, counselling	111000	0.059	taylor-yu-lee
581	Astronomer	55000	0.074	martinez-daniels
582	Medical physicist	110000	0.015	mitchell-brown
583	Chief Technology Officer	64000	0.067	robbins-marsh-martin
584	Arboriculturist	191000	0.062	salas-group
585	Conservation officer, nature	108000	0.006	jackson-davila-conley
586	Psychologist, sport and exercise	172000	0.061	ayala-buchanan
587	Designer, furniture	149000	0.041	mueller-moore
588	Chartered loss adjuster	72000	0.084	davis-davis
589	Producer, radio	168000	0.010	salas-group
590	Operational investment banker	200000	0.022	smith-llc
591	Surveyor, quantity	72000	0.071	mejia-scott-ryan
592	Ship broker	177000	0	hall-davis
593	Bookseller	164000	0	reynolds-greene
594	Medical sales representative	196000	0	hall-mills
595	Copy	103000	0	foster-rice
596	Engineer, broadcasting (operations)	86000	0	baker-santos
597	Fashion designer	137000	0	reynolds-greene
598	Learning disability nurse	66000	\N	ayala-buchanan
599	Research scientist (medical)	175000	\N	norman-harvey
600	Accommodation manager	126000	\N	mejia-scott-ryan
601	Conservator, furniture	110000	0	watson-davis
602	Information officer	200000	0	hall-mills
603	Consulting civil engineer	60000	0	sellers-bryant
604	Early years teacher	55000	0	perez-miller
605	Intelligence analyst	77000	0	garner-michael
606	Surveyor, building	144000	0	russo-gillespie-conrad
607	Technical brewer	157000	0	anderson-arias-morrow
608	Control and instrumentation engineer	171000	0	salas-group
609	Photographer	198000	0	davis-davis
610	Multimedia programmer	192000	0	graham-herring-lane
611	English as a foreign language teacher	111000	0	russo-gillespie-conrad
612	Passenger transport manager	70000	0	rivas-llc
613	Psychologist, clinical	172000	0	hudson-inc
614	Financial planner	115000	0	taylor-yu-lee
615	Scientist, forensic	50000	0	foster-rice
616	Occupational therapist	183000	0	garcia-ray
617	Ophthalmologist	135000	0	hall-mills
618	Embryologist, clinical	138000	0	anderson-arias-morrow
619	Marine scientist	54000	0	scott-smith
620	Tourist information centre manager	88000	0	foster-rice
621	Interior and spatial designer	177000	0	gillespie-smith
622	Surveyor, rural practice	193000	0	weber-hernandez
623	Colour technologist	81000	0	burton-ltd
624	Technical brewer	77000	0	thomas-sons
625	Pharmacist, hospital	194000	0	boyd-evans
626	Medical sales representative	125000	0	jackson-davila-conley
627	Energy engineer	62000	0	norman-harvey
628	Research officer, government	167000	0	mejia-scott-ryan
629	Barrister	130000	0	stone-stewart
630	Loss adjuster, chartered	76000	0	bauer-gallagher
631	Database administrator	79000	0	willis-henson-miller
632	IT consultant	59000	0	gillespie-smith
633	Museum/gallery conservator	82000	0	mejia-scott-ryan
634	Engineering geologist	170000	0	garcia-ray
635	Television production assistant	125000	0	logan-miller
636	Accountant, chartered certified	175000	0	stone-stewart
637	Merchant navy officer	106000	0	mitchell-brown
638	Medical physicist	84000	0	perez-miller
639	Podiatrist	68000	\N	reynolds-greene
640	Nurse, children's	162000	\N	humphrey-llc
641	Teacher, music	127000	\N	ingram-ferguson-rubio
642	Occupational hygienist	79000	\N	reynolds-greene
643	Research officer, political party	134000	\N	garner-michael
644	Therapist, occupational	82000	\N	mejia-scott-ryan
645	Teacher, secondary school	127000	\N	sellers-bryant
646	Scientist, product/process development	106000	\N	scott-smith
647	Astronomer	143000	\N	watson-davis
648	Counsellor	\N	0	owen-newton
649	Financial controller	\N	0	sellers-bryant
650	Advertising account executive	\N	0	thomas-sons
651	Buyer, industrial	\N	\N	reynolds-greene
652	Interpreter	55000	0	hudson-inc
653	Best boy	\N	0	jackson-sons
654	Freight forwarder	183000	0	hudson-inc
655	Designer, jewellery	\N	0	weber-hernandez
656	Tree surgeon	\N	0.001	hall-davis
657	Management consultant	183000	0	edwards-lee-reese
658	Ergonomist	160000	0	bauer-gallagher
659	Psychologist, forensic	176000	0	boyd-evans
660	Architectural technologist	57000	0	owen-newton
661	Patent attorney	143000	0	foster-rice
662	Art gallery manager	\N	0.085	anderson-arias-morrow
663	Engineer, chemical	81000	0	russo-gillespie-conrad
664	Speech and language therapist	159000	0	gillespie-smith
665	Orthoptist	200000	0	perez-miller
666	Camera operator	130000	0	arnold-berger-townsend
667	Field trials officer	137000	0	davis-davis
668	Transport planner	\N	\N	reynolds-greene
669	Bonds trader	\N	\N	mitchell-brown
670	Editor, magazine features	118000	0.002	foster-rice
671	Applications developer	84000	0.091	sellers-bryant
672	Clothing/textile technologist	171000	0.041	smith-llc
673	Secretary/administrator	172000	0.096	jackson-sons
674	Field seismologist	62000	0.064	martinez-daniels
675	Engineer, materials	185000	0.081	garner-michael
676	Race relations officer	97000	0.065	bauer-gallagher
677	Engineering geologist	89000	0.043	ayala-buchanan
678	Aeronautical engineer	135000	0.078	norman-harvey
679	Development worker, community	192000	0.047	weber-hernandez
680	Speech and language therapist	154000	0.014	humphrey-llc
681	Health promotion specialist	72000	0.010	burton-ltd
682	Careers adviser	57000	0.051	carr-wells-jones
683	Surveyor, minerals	98000	0.037	carr-wells-jones
684	Forest/woodland manager	156000	0.030	carr-wells-jones
685	Haematologist	63000	0.062	ayala-buchanan
686	Advertising account executive	130000	0.064	thomas-sons
687	Ship broker	124000	0.045	davis-davis
688	Fisheries officer	67000	0.062	hall-davis
689	Air cabin crew	105000	0.077	ingram-ferguson-rubio
690	Financial trader	153000	0.012	garner-michael
691	Paramedic	122000	0.047	baker-santos
692	Historic buildings inspector/conservation officer	129000	0.052	watson-davis
693	Transport planner	123000	0.091	hudson-inc
694	Public librarian	115000	0.099	norman-harvey
695	Writer	172000	0.091	anderson-arias-morrow
696	Designer, fashion/clothing	81000	0.026	garcia-ray
697	Information systems manager	123000	0.100	arnold-berger-townsend
698	Art gallery manager	73000	0.054	perez-miller
699	Operational researcher	167000	0.020	ayala-buchanan
700	Solicitor	131000	0.034	wiggins-frederick-boyer
701	Intelligence analyst	148000	0	sellers-bryant
702	Naval architect	126000	0	scott-smith
703	Dealer	175000	0	hall-mills
704	Multimedia programmer	154000	\N	owen-newton
705	Psychologist, occupational	190000	\N	robbins-marsh-martin
706	Leisure centre manager	135000	\N	edwards-lee-reese
707	Television production assistant	99000	\N	edwards-lee-reese
1009	Photographer	198000	0	davis-davis
708	Historic buildings inspector/conservation officer	135000	\N	rivas-llc
709	Sports development officer	102000	\N	scott-smith
710	Investment banker, corporate	131000	\N	ingram-ferguson-rubio
711	Conservation officer, historic buildings	168000	\N	robbins-marsh-martin
712	Physicist, medical	190000	\N	humphrey-llc
713	Press sub	100000	\N	erickson-inc
714	Engineer, civil (contracting)	\N	0.018	moore-plc
715	Therapist, music	103000	0.087	reynolds-greene
716	Water engineer	\N	0.028	mejia-scott-ryan
717	Engineer, energy	\N	0.048	arnold-berger-townsend
718	Plant breeder/geneticist	\N	0.081	thomas-sons
719	Oceanographer	\N	0.097	anderson-arias-morrow
720	Clinical cytogeneticist	152000	0.027	mitchell-brown
721	Nature conservation officer	82000	0.093	watson-davis
722	Insurance underwriter	\N	0.008	hall-davis
723	Chief of Staff	110000	0.016	scott-smith
724	Surveyor, insurance	\N	0.066	foster-rice
725	Surveyor, building control	\N	\N	reynolds-greene
726	Trade mark attorney	\N	\N	mueller-moore
727	Glass blower/designer	126000	0.099	anderson-arias-morrow
728	Geochemist	130000	0.004	smith-llc
729	Scientist, research (physical sciences)	117000	0.090	ayala-buchanan
730	Historic buildings inspector/conservation officer	65000	0.075	mejia-scott-ryan
731	Surveyor, insurance	130000	0.009	martinez-daniels
732	Contractor	89000	0.065	mueller-moore
733	Hydrologist	50000	0.097	wiggins-frederick-boyer
734	Aeronautical engineer	156000	0.055	perez-miller
735	Freight forwarder	183000	0.093	burton-ltd
736	Engineer, materials	140000	0.057	mitchell-brown
737	Product designer	184000	0.090	gillespie-smith
738	Editor, film/video	199000	0.070	bauer-gallagher
739	Fashion designer	131000	0.080	taylor-yu-lee
740	Legal secretary	155000	0.080	pugh-ltd
741	Financial risk analyst	72000	0.001	scott-smith
742	Regulatory affairs officer	96000	0.061	logan-miller
743	Ranger/warden	86000	0.095	ayala-buchanan
744	Farm manager	138000	0.085	stone-stewart
745	Primary school teacher	142000	0.036	moore-plc
746	Quality manager	138000	0.002	russo-gillespie-conrad
747	Radio producer	99000	0.038	mitchell-brown
748	Music therapist	100000	0.058	taylor-yu-lee
749	Farm manager	68000	0.049	morgan-sullivan
750	Camera operator	51000	0.066	jackson-davila-conley
751	Engineer, technical sales	167000	0.077	ingram-ferguson-rubio
752	Ranger/warden	145000	0.046	jackson-davila-conley
753	Lawyer	162000	0.072	hall-mills
754	Estate manager/land agent	94000	0.008	jackson-davila-conley
755	Orthoptist	129000	0.062	willis-henson-miller
756	Recycling officer	57000	0.098	carr-wells-jones
757	Scientist, research (life sciences)	157000	0.057	ayala-buchanan
758	Armed forces technical officer	136000	0.012	scott-smith
759	Public relations officer	112000	0.087	weber-hernandez
760	Set designer	132000	0.055	russo-gillespie-conrad
761	Accountant, chartered certified	86000	0.070	boyd-evans
762	Special effects artist	101000	0.023	willis-henson-miller
763	Glass blower/designer	60000	0.095	mueller-moore
764	Print production planner	197000	0.095	humphrey-llc
765	Psychologist, counselling	180000	0.008	perez-miller
766	Meteorologist	81000	0.037	sellers-bryant
767	Therapist, drama	200000	0.095	hall-mills
768	Engineer, technical sales	157000	0.083	baker-santos
769	Scientist, audiological	61000	0.095	foster-rice
770	Dietitian	198000	0	ayala-buchanan
771	Electrical engineer	157000	\N	jackson-davila-conley
772	Agricultural consultant	67000	\N	moore-plc
773	Geochemist	104000	\N	hudson-inc
774	Geologist, engineering	116000	\N	jackson-davila-conley
775	Clinical biochemist	92000	\N	norman-harvey
776	Probation officer	128000	\N	foster-rice
777	Chief Executive Officer	83000	\N	miller-woods-hernandez
778	Surveyor, building	144000	0.007	salas-group
779	Engineer, water	165000	0.010	ingram-ferguson-rubio
780	Psychologist, counselling	111000	0.059	taylor-yu-lee
781	Astronomer	55000	0.074	martinez-daniels
782	Medical physicist	110000	0.015	mitchell-brown
783	Chief Technology Officer	64000	0.067	robbins-marsh-martin
784	Arboriculturist	191000	0.062	salas-group
785	Conservation officer, nature	108000	0.006	jackson-davila-conley
786	Psychologist, sport and exercise	172000	0.061	ayala-buchanan
787	Designer, furniture	149000	0.041	mueller-moore
788	Chartered loss adjuster	72000	0.084	davis-davis
789	Producer, radio	168000	0.010	salas-group
790	Operational investment banker	200000	0.022	smith-llc
791	Surveyor, quantity	72000	0.071	mejia-scott-ryan
792	Ship broker	177000	0	hall-davis
793	Bookseller	164000	0	reynolds-greene
794	Medical sales representative	196000	0	hall-mills
795	Copy	103000	0	foster-rice
796	Engineer, broadcasting (operations)	86000	0	baker-santos
797	Fashion designer	137000	0	reynolds-greene
798	Learning disability nurse	66000	\N	ayala-buchanan
799	Research scientist (medical)	175000	\N	norman-harvey
800	Accommodation manager	126000	\N	mejia-scott-ryan
801	Conservator, furniture	110000	0	watson-davis
802	Information officer	200000	0	hall-mills
803	Consulting civil engineer	60000	0	sellers-bryant
804	Early years teacher	55000	0	perez-miller
805	Intelligence analyst	77000	0	garner-michael
806	Surveyor, building	144000	0	russo-gillespie-conrad
807	Technical brewer	157000	0	anderson-arias-morrow
808	Control and instrumentation engineer	171000	0	salas-group
809	Photographer	198000	0	davis-davis
810	Multimedia programmer	192000	0	graham-herring-lane
811	English as a foreign language teacher	111000	0	russo-gillespie-conrad
812	Passenger transport manager	70000	0	rivas-llc
813	Psychologist, clinical	172000	0	hudson-inc
814	Financial planner	115000	0	taylor-yu-lee
815	Scientist, forensic	50000	0	foster-rice
816	Occupational therapist	183000	0	garcia-ray
817	Ophthalmologist	135000	0	hall-mills
818	Embryologist, clinical	138000	0	anderson-arias-morrow
819	Marine scientist	54000	0	scott-smith
820	Tourist information centre manager	88000	0	foster-rice
821	Interior and spatial designer	177000	0	gillespie-smith
822	Surveyor, rural practice	193000	0	weber-hernandez
823	Colour technologist	81000	0	burton-ltd
824	Technical brewer	77000	0	thomas-sons
825	Pharmacist, hospital	194000	0	boyd-evans
826	Medical sales representative	125000	0	jackson-davila-conley
827	Energy engineer	62000	0	norman-harvey
828	Research officer, government	167000	0	mejia-scott-ryan
829	Barrister	130000	0	stone-stewart
830	Loss adjuster, chartered	76000	0	bauer-gallagher
831	Database administrator	79000	0	willis-henson-miller
832	IT consultant	59000	0	gillespie-smith
833	Museum/gallery conservator	82000	0	mejia-scott-ryan
834	Engineering geologist	170000	0	garcia-ray
835	Television production assistant	125000	0	logan-miller
836	Accountant, chartered certified	175000	0	stone-stewart
837	Merchant navy officer	106000	0	mitchell-brown
838	Medical physicist	84000	0	perez-miller
839	Podiatrist	68000	\N	reynolds-greene
840	Nurse, children's	162000	\N	humphrey-llc
841	Teacher, music	127000	\N	ingram-ferguson-rubio
842	Occupational hygienist	79000	\N	reynolds-greene
843	Research officer, political party	134000	\N	garner-michael
844	Therapist, occupational	82000	\N	mejia-scott-ryan
845	Teacher, secondary school	127000	\N	sellers-bryant
846	Scientist, product/process development	106000	\N	scott-smith
847	Astronomer	143000	\N	watson-davis
848	Counsellor	\N	0	owen-newton
849	Financial controller	\N	0	sellers-bryant
850	Advertising account executive	\N	0	thomas-sons
851	Buyer, industrial	\N	\N	reynolds-greene
852	Interpreter	55000	0	hudson-inc
853	Best boy	\N	0	jackson-sons
854	Freight forwarder	183000	0	hudson-inc
855	Designer, jewellery	\N	0	weber-hernandez
856	Tree surgeon	\N	0.001	hall-davis
857	Management consultant	183000	0	edwards-lee-reese
858	Ergonomist	160000	0	bauer-gallagher
859	Psychologist, forensic	176000	0	boyd-evans
860	Architectural technologist	57000	0	owen-newton
861	Patent attorney	143000	0	foster-rice
862	Art gallery manager	\N	0.085	anderson-arias-morrow
863	Engineer, chemical	81000	0	russo-gillespie-conrad
864	Speech and language therapist	159000	0	gillespie-smith
865	Orthoptist	200000	0	perez-miller
866	Camera operator	130000	0	arnold-berger-townsend
867	Field trials officer	137000	0	davis-davis
868	Transport planner	\N	\N	reynolds-greene
869	Bonds trader	\N	\N	mitchell-brown
870	Editor, magazine features	118000	0.002	foster-rice
871	Applications developer	84000	0.091	sellers-bryant
872	Clothing/textile technologist	171000	0.041	smith-llc
873	Secretary/administrator	172000	0.096	jackson-sons
874	Field seismologist	62000	0.064	martinez-daniels
875	Engineer, materials	185000	0.081	garner-michael
876	Race relations officer	97000	0.065	bauer-gallagher
877	Engineering geologist	89000	0.043	ayala-buchanan
878	Aeronautical engineer	135000	0.078	norman-harvey
879	Development worker, community	192000	0.047	weber-hernandez
880	Speech and language therapist	154000	0.014	humphrey-llc
881	Health promotion specialist	72000	0.010	burton-ltd
882	Careers adviser	57000	0.051	carr-wells-jones
883	Surveyor, minerals	98000	0.037	carr-wells-jones
884	Forest/woodland manager	156000	0.030	carr-wells-jones
885	Haematologist	63000	0.062	ayala-buchanan
886	Advertising account executive	130000	0.064	thomas-sons
887	Ship broker	124000	0.045	davis-davis
888	Fisheries officer	67000	0.062	hall-davis
889	Air cabin crew	105000	0.077	ingram-ferguson-rubio
890	Financial trader	153000	0.012	garner-michael
891	Paramedic	122000	0.047	baker-santos
892	Historic buildings inspector/conservation officer	129000	0.052	watson-davis
893	Transport planner	123000	0.091	hudson-inc
894	Public librarian	115000	0.099	norman-harvey
895	Writer	172000	0.091	anderson-arias-morrow
896	Designer, fashion/clothing	81000	0.026	garcia-ray
897	Information systems manager	123000	0.100	arnold-berger-townsend
898	Art gallery manager	73000	0.054	perez-miller
899	Operational researcher	167000	0.020	ayala-buchanan
900	Solicitor	131000	0.034	wiggins-frederick-boyer
901	Intelligence analyst	148000	0	sellers-bryant
902	Naval architect	126000	0	scott-smith
903	Dealer	175000	0	hall-mills
904	Multimedia programmer	154000	\N	owen-newton
905	Psychologist, occupational	190000	\N	robbins-marsh-martin
906	Leisure centre manager	135000	\N	edwards-lee-reese
907	Television production assistant	99000	\N	edwards-lee-reese
908	Historic buildings inspector/conservation officer	135000	\N	rivas-llc
909	Sports development officer	102000	\N	scott-smith
910	Investment banker, corporate	131000	\N	ingram-ferguson-rubio
911	Conservation officer, historic buildings	168000	\N	robbins-marsh-martin
912	Physicist, medical	190000	\N	humphrey-llc
913	Press sub	100000	\N	erickson-inc
914	Engineer, civil (contracting)	\N	0.018	moore-plc
915	Therapist, music	103000	0.087	reynolds-greene
916	Water engineer	\N	0.028	mejia-scott-ryan
917	Engineer, energy	\N	0.048	arnold-berger-townsend
918	Plant breeder/geneticist	\N	0.081	thomas-sons
919	Oceanographer	\N	0.097	anderson-arias-morrow
920	Clinical cytogeneticist	152000	0.027	mitchell-brown
921	Nature conservation officer	82000	0.093	watson-davis
922	Insurance underwriter	\N	0.008	hall-davis
923	Chief of Staff	110000	0.016	scott-smith
924	Surveyor, insurance	\N	0.066	foster-rice
925	Surveyor, building control	\N	\N	reynolds-greene
926	Trade mark attorney	\N	\N	mueller-moore
927	Glass blower/designer	126000	0.099	anderson-arias-morrow
928	Geochemist	130000	0.004	smith-llc
929	Scientist, research (physical sciences)	117000	0.090	ayala-buchanan
930	Historic buildings inspector/conservation officer	65000	0.075	mejia-scott-ryan
931	Surveyor, insurance	130000	0.009	martinez-daniels
932	Contractor	89000	0.065	mueller-moore
933	Hydrologist	50000	0.097	wiggins-frederick-boyer
934	Aeronautical engineer	156000	0.055	perez-miller
935	Freight forwarder	183000	0.093	burton-ltd
936	Engineer, materials	140000	0.057	mitchell-brown
937	Product designer	184000	0.090	gillespie-smith
938	Editor, film/video	199000	0.070	bauer-gallagher
939	Fashion designer	131000	0.080	taylor-yu-lee
940	Legal secretary	155000	0.080	pugh-ltd
941	Financial risk analyst	72000	0.001	scott-smith
942	Regulatory affairs officer	96000	0.061	logan-miller
943	Ranger/warden	86000	0.095	ayala-buchanan
944	Farm manager	138000	0.085	stone-stewart
945	Primary school teacher	142000	0.036	moore-plc
946	Quality manager	138000	0.002	russo-gillespie-conrad
947	Radio producer	99000	0.038	mitchell-brown
948	Music therapist	100000	0.058	taylor-yu-lee
949	Farm manager	68000	0.049	morgan-sullivan
950	Camera operator	51000	0.066	jackson-davila-conley
951	Engineer, technical sales	167000	0.077	ingram-ferguson-rubio
952	Ranger/warden	145000	0.046	jackson-davila-conley
953	Lawyer	162000	0.072	hall-mills
954	Estate manager/land agent	94000	0.008	jackson-davila-conley
955	Orthoptist	129000	0.062	willis-henson-miller
956	Recycling officer	57000	0.098	carr-wells-jones
957	Scientist, research (life sciences)	157000	0.057	ayala-buchanan
958	Armed forces technical officer	136000	0.012	scott-smith
959	Public relations officer	112000	0.087	weber-hernandez
960	Set designer	132000	0.055	russo-gillespie-conrad
961	Accountant, chartered certified	86000	0.070	boyd-evans
962	Special effects artist	101000	0.023	willis-henson-miller
963	Glass blower/designer	60000	0.095	mueller-moore
964	Print production planner	197000	0.095	humphrey-llc
965	Psychologist, counselling	180000	0.008	perez-miller
966	Meteorologist	81000	0.037	sellers-bryant
967	Therapist, drama	200000	0.095	hall-mills
968	Engineer, technical sales	157000	0.083	baker-santos
969	Scientist, audiological	61000	0.095	foster-rice
970	Dietitian	198000	0	ayala-buchanan
971	Electrical engineer	157000	\N	jackson-davila-conley
972	Agricultural consultant	67000	\N	moore-plc
973	Geochemist	104000	\N	hudson-inc
974	Geologist, engineering	116000	\N	jackson-davila-conley
975	Clinical biochemist	92000	\N	norman-harvey
976	Probation officer	128000	\N	foster-rice
977	Chief Executive Officer	83000	\N	miller-woods-hernandez
978	Surveyor, building	144000	0.007	salas-group
979	Engineer, water	165000	0.010	ingram-ferguson-rubio
980	Psychologist, counselling	111000	0.059	taylor-yu-lee
981	Astronomer	55000	0.074	martinez-daniels
982	Medical physicist	110000	0.015	mitchell-brown
983	Chief Technology Officer	64000	0.067	robbins-marsh-martin
984	Arboriculturist	191000	0.062	salas-group
985	Conservation officer, nature	108000	0.006	jackson-davila-conley
986	Psychologist, sport and exercise	172000	0.061	ayala-buchanan
987	Designer, furniture	149000	0.041	mueller-moore
988	Chartered loss adjuster	72000	0.084	davis-davis
989	Producer, radio	168000	0.010	salas-group
990	Operational investment banker	200000	0.022	smith-llc
991	Surveyor, quantity	72000	0.071	mejia-scott-ryan
992	Ship broker	177000	0	hall-davis
993	Bookseller	164000	0	reynolds-greene
994	Medical sales representative	196000	0	hall-mills
995	Copy	103000	0	foster-rice
996	Engineer, broadcasting (operations)	86000	0	baker-santos
997	Fashion designer	137000	0	reynolds-greene
998	Learning disability nurse	66000	\N	ayala-buchanan
999	Research scientist (medical)	175000	\N	norman-harvey
1000	Accommodation manager	126000	\N	mejia-scott-ryan
1001	Conservator, furniture	110000	0	watson-davis
1002	Information officer	200000	0	hall-mills
1003	Consulting civil engineer	60000	0	sellers-bryant
1004	Early years teacher	55000	0	perez-miller
1005	Intelligence analyst	77000	0	garner-michael
1006	Surveyor, building	144000	0	russo-gillespie-conrad
1007	Technical brewer	157000	0	anderson-arias-morrow
1008	Control and instrumentation engineer	171000	0	salas-group
1010	Multimedia programmer	192000	0	graham-herring-lane
1011	English as a foreign language teacher	111000	0	russo-gillespie-conrad
1012	Passenger transport manager	70000	0	rivas-llc
1013	Psychologist, clinical	172000	0	hudson-inc
1014	Financial planner	115000	0	taylor-yu-lee
1015	Scientist, forensic	50000	0	foster-rice
1016	Occupational therapist	183000	0	garcia-ray
1017	Ophthalmologist	135000	0	hall-mills
1018	Embryologist, clinical	138000	0	anderson-arias-morrow
1019	Marine scientist	54000	0	scott-smith
1020	Tourist information centre manager	88000	0	foster-rice
1021	Interior and spatial designer	177000	0	gillespie-smith
1022	Surveyor, rural practice	193000	0	weber-hernandez
1023	Colour technologist	81000	0	burton-ltd
1024	Technical brewer	77000	0	thomas-sons
1025	Pharmacist, hospital	194000	0	boyd-evans
1026	Medical sales representative	125000	0	jackson-davila-conley
1027	Energy engineer	62000	0	norman-harvey
1028	Research officer, government	167000	0	mejia-scott-ryan
1029	Barrister	130000	0	stone-stewart
1030	Loss adjuster, chartered	76000	0	bauer-gallagher
1031	Database administrator	79000	0	willis-henson-miller
1032	IT consultant	59000	0	gillespie-smith
1033	Museum/gallery conservator	82000	0	mejia-scott-ryan
1034	Engineering geologist	170000	0	garcia-ray
1035	Television production assistant	125000	0	logan-miller
1036	Accountant, chartered certified	175000	0	stone-stewart
1037	Merchant navy officer	106000	0	mitchell-brown
1038	Medical physicist	84000	0	perez-miller
1039	Podiatrist	68000	\N	reynolds-greene
1040	Nurse, children's	162000	\N	humphrey-llc
1041	Teacher, music	127000	\N	ingram-ferguson-rubio
1042	Occupational hygienist	79000	\N	reynolds-greene
1043	Research officer, political party	134000	\N	garner-michael
1044	Therapist, occupational	82000	\N	mejia-scott-ryan
1045	Teacher, secondary school	127000	\N	sellers-bryant
1046	Scientist, product/process development	106000	\N	scott-smith
1047	Astronomer	143000	\N	watson-davis
1048	Counsellor	\N	0	owen-newton
1049	Financial controller	\N	0	sellers-bryant
1050	Advertising account executive	\N	0	thomas-sons
1051	Buyer, industrial	\N	\N	reynolds-greene
1052	Interpreter	55000	0	hudson-inc
1053	Best boy	\N	0	jackson-sons
1054	Freight forwarder	183000	0	hudson-inc
1055	Designer, jewellery	\N	0	weber-hernandez
1056	Tree surgeon	\N	0.001	hall-davis
1057	Management consultant	183000	0	edwards-lee-reese
1058	Ergonomist	160000	0	bauer-gallagher
1059	Psychologist, forensic	176000	0	boyd-evans
1060	Architectural technologist	57000	0	owen-newton
1061	Patent attorney	143000	0	foster-rice
1062	Art gallery manager	\N	0.085	anderson-arias-morrow
1063	Engineer, chemical	81000	0	russo-gillespie-conrad
1064	Speech and language therapist	159000	0	gillespie-smith
1065	Orthoptist	200000	0	perez-miller
1066	Camera operator	130000	0	arnold-berger-townsend
1067	Field trials officer	137000	0	davis-davis
1068	Transport planner	\N	\N	reynolds-greene
1069	Bonds trader	\N	\N	mitchell-brown
1070	Editor, magazine features	118000	0.002	foster-rice
1071	Applications developer	84000	0.091	sellers-bryant
1072	Clothing/textile technologist	171000	0.041	smith-llc
1073	Secretary/administrator	172000	0.096	jackson-sons
1074	Field seismologist	62000	0.064	martinez-daniels
1075	Engineer, materials	185000	0.081	garner-michael
1076	Race relations officer	97000	0.065	bauer-gallagher
1077	Engineering geologist	89000	0.043	ayala-buchanan
1078	Aeronautical engineer	135000	0.078	norman-harvey
1079	Development worker, community	192000	0.047	weber-hernandez
1080	Speech and language therapist	154000	0.014	humphrey-llc
1081	Health promotion specialist	72000	0.010	burton-ltd
1082	Careers adviser	57000	0.051	carr-wells-jones
1083	Surveyor, minerals	98000	0.037	carr-wells-jones
1084	Forest/woodland manager	156000	0.030	carr-wells-jones
1085	Haematologist	63000	0.062	ayala-buchanan
1086	Advertising account executive	130000	0.064	thomas-sons
1087	Ship broker	124000	0.045	davis-davis
1088	Fisheries officer	67000	0.062	hall-davis
1089	Air cabin crew	105000	0.077	ingram-ferguson-rubio
1090	Financial trader	153000	0.012	garner-michael
1091	Paramedic	122000	0.047	baker-santos
1092	Historic buildings inspector/conservation officer	129000	0.052	watson-davis
1093	Transport planner	123000	0.091	hudson-inc
1094	Public librarian	115000	0.099	norman-harvey
1095	Writer	172000	0.091	anderson-arias-morrow
1096	Designer, fashion/clothing	81000	0.026	garcia-ray
1097	Information systems manager	123000	0.100	arnold-berger-townsend
1098	Art gallery manager	73000	0.054	perez-miller
1099	Operational researcher	167000	0.020	ayala-buchanan
1100	Solicitor	131000	0.034	wiggins-frederick-boyer
1101	Intelligence analyst	148000	0	sellers-bryant
1102	Naval architect	126000	0	scott-smith
1103	Dealer	175000	0	hall-mills
1104	Multimedia programmer	154000	\N	owen-newton
1105	Psychologist, occupational	190000	\N	robbins-marsh-martin
1106	Leisure centre manager	135000	\N	edwards-lee-reese
1107	Television production assistant	99000	\N	edwards-lee-reese
1108	Historic buildings inspector/conservation officer	135000	\N	rivas-llc
1109	Sports development officer	102000	\N	scott-smith
1110	Investment banker, corporate	131000	\N	ingram-ferguson-rubio
1111	Conservation officer, historic buildings	168000	\N	robbins-marsh-martin
1112	Physicist, medical	190000	\N	humphrey-llc
1113	Press sub	100000	\N	erickson-inc
1114	Engineer, civil (contracting)	\N	0.018	moore-plc
1115	Therapist, music	103000	0.087	reynolds-greene
1116	Water engineer	\N	0.028	mejia-scott-ryan
1117	Engineer, energy	\N	0.048	arnold-berger-townsend
1118	Plant breeder/geneticist	\N	0.081	thomas-sons
1119	Oceanographer	\N	0.097	anderson-arias-morrow
1120	Clinical cytogeneticist	152000	0.027	mitchell-brown
1121	Nature conservation officer	82000	0.093	watson-davis
1122	Insurance underwriter	\N	0.008	hall-davis
1123	Chief of Staff	110000	0.016	scott-smith
1124	Surveyor, insurance	\N	0.066	foster-rice
1125	Surveyor, building control	\N	\N	reynolds-greene
1126	Trade mark attorney	\N	\N	mueller-moore
1127	Glass blower/designer	126000	0.099	anderson-arias-morrow
1128	Geochemist	130000	0.004	smith-llc
1129	Scientist, research (physical sciences)	117000	0.090	ayala-buchanan
1130	Historic buildings inspector/conservation officer	65000	0.075	mejia-scott-ryan
1131	Surveyor, insurance	130000	0.009	martinez-daniels
1132	Contractor	89000	0.065	mueller-moore
1133	Hydrologist	50000	0.097	wiggins-frederick-boyer
1134	Aeronautical engineer	156000	0.055	perez-miller
1135	Freight forwarder	183000	0.093	burton-ltd
1136	Engineer, materials	140000	0.057	mitchell-brown
1137	Product designer	184000	0.090	gillespie-smith
1138	Editor, film/video	199000	0.070	bauer-gallagher
1139	Fashion designer	131000	0.080	taylor-yu-lee
1140	Legal secretary	155000	0.080	pugh-ltd
1141	Financial risk analyst	72000	0.001	scott-smith
1142	Regulatory affairs officer	96000	0.061	logan-miller
1143	Ranger/warden	86000	0.095	ayala-buchanan
1144	Farm manager	138000	0.085	stone-stewart
1145	Primary school teacher	142000	0.036	moore-plc
1146	Quality manager	138000	0.002	russo-gillespie-conrad
1147	Radio producer	99000	0.038	mitchell-brown
1148	Music therapist	100000	0.058	taylor-yu-lee
1149	Farm manager	68000	0.049	morgan-sullivan
1150	Camera operator	51000	0.066	jackson-davila-conley
1151	Engineer, technical sales	167000	0.077	ingram-ferguson-rubio
1152	Ranger/warden	145000	0.046	jackson-davila-conley
1153	Lawyer	162000	0.072	hall-mills
1154	Estate manager/land agent	94000	0.008	jackson-davila-conley
1155	Orthoptist	129000	0.062	willis-henson-miller
1156	Recycling officer	57000	0.098	carr-wells-jones
1157	Scientist, research (life sciences)	157000	0.057	ayala-buchanan
1158	Armed forces technical officer	136000	0.012	scott-smith
1159	Public relations officer	112000	0.087	weber-hernandez
1160	Set designer	132000	0.055	russo-gillespie-conrad
1161	Accountant, chartered certified	86000	0.070	boyd-evans
1162	Special effects artist	101000	0.023	willis-henson-miller
1163	Glass blower/designer	60000	0.095	mueller-moore
1164	Print production planner	197000	0.095	humphrey-llc
1165	Psychologist, counselling	180000	0.008	perez-miller
1166	Meteorologist	81000	0.037	sellers-bryant
1167	Therapist, drama	200000	0.095	hall-mills
1168	Engineer, technical sales	157000	0.083	baker-santos
1169	Scientist, audiological	61000	0.095	foster-rice
1170	Dietitian	198000	0	ayala-buchanan
1171	Electrical engineer	157000	\N	jackson-davila-conley
1172	Agricultural consultant	67000	\N	moore-plc
1173	Geochemist	104000	\N	hudson-inc
1174	Geologist, engineering	116000	\N	jackson-davila-conley
1175	Clinical biochemist	92000	\N	norman-harvey
1176	Probation officer	128000	\N	foster-rice
1177	Chief Executive Officer	83000	\N	miller-woods-hernandez
1178	Surveyor, building	144000	0.007	salas-group
1179	Engineer, water	165000	0.010	ingram-ferguson-rubio
1180	Psychologist, counselling	111000	0.059	taylor-yu-lee
1181	Astronomer	55000	0.074	martinez-daniels
1182	Medical physicist	110000	0.015	mitchell-brown
1183	Chief Technology Officer	64000	0.067	robbins-marsh-martin
1184	Arboriculturist	191000	0.062	salas-group
1185	Conservation officer, nature	108000	0.006	jackson-davila-conley
1186	Psychologist, sport and exercise	172000	0.061	ayala-buchanan
1187	Designer, furniture	149000	0.041	mueller-moore
1188	Chartered loss adjuster	72000	0.084	davis-davis
1189	Producer, radio	168000	0.010	salas-group
1190	Operational investment banker	200000	0.022	smith-llc
1191	Surveyor, quantity	72000	0.071	mejia-scott-ryan
1192	Ship broker	177000	0	hall-davis
1193	Bookseller	164000	0	reynolds-greene
1194	Medical sales representative	196000	0	hall-mills
1195	Copy	103000	0	foster-rice
1196	Engineer, broadcasting (operations)	86000	0	baker-santos
1197	Fashion designer	137000	0	reynolds-greene
1198	Learning disability nurse	66000	\N	ayala-buchanan
1199	Research scientist (medical)	175000	\N	norman-harvey
1200	Accommodation manager	126000	\N	mejia-scott-ryan
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."users" ("username", "password", "first_name", "last_name", "email", "is_admin") FROM stdin;
testadmin	$2b$12$AZH7virni5jlTTiGgEg4zu3lSvAw68qVEfSIOjJ3RqtbJbdW/Oi5q	Test	Admin!	joel@joelburton.com	t
codell247	$2b$12$aqVkGXrnx6PtKxpfNmlTHeS/vemZ44v4ObN64Lb2.a4wIwq13Suki	Clay	O'Dell	new@email.com	f
newuser	$2b$12$vBxG/kzpPHoTYYiaX7a5lez/0O5cJzuQh7jSbnoTc5cNYZhFTZV3q	New	User	newuser@email.com	f
aaa	$2b$12$P98mlgcbX4g8XcqebqxCZusoza/FVJ0pkRTOA6r03cHB3UI5a00RG	Aaaron	Aaaron	aaaron@email.com	f
aaaaa	$2b$12$Yx.l3atb0DnTKlcVZZljE.17GLa8TO94bthsChq5dnH5Iq8PRfA1y	Aaron	Aron	aron@email.com	f
rwiggums	$2b$12$kNJRC2.DRFWcRSwLMqx2VOLXGffVbESmPzofpzg6qmFkjbS.30ypi	Ralphy	Wiggums	rwiggums@email.com	f
testuser	$2b$12$AZH7virni5jlTTiGgEg4zu3lSvAw68qVEfSIOjJ3RqtbJbdW/Oi5q	Test	User	joel@joelburton.com	f
\.


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."jobs_id_seq"', 1200, true);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."applications"
    ADD CONSTRAINT "applications_pkey" PRIMARY KEY ("username", "job_id");


--
-- Name: companies companies_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."companies"
    ADD CONSTRAINT "companies_name_key" UNIQUE ("name");


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."companies"
    ADD CONSTRAINT "companies_pkey" PRIMARY KEY ("handle");


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."jobs"
    ADD CONSTRAINT "jobs_pkey" PRIMARY KEY ("id");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("username");


--
-- Name: applications applications_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."applications"
    ADD CONSTRAINT "applications_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "public"."jobs"("id") ON DELETE CASCADE;


--
-- Name: applications applications_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."applications"
    ADD CONSTRAINT "applications_username_fkey" FOREIGN KEY ("username") REFERENCES "public"."users"("username") ON DELETE CASCADE;


--
-- Name: jobs jobs_company_handle_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."jobs"
    ADD CONSTRAINT "jobs_company_handle_fkey" FOREIGN KEY ("company_handle") REFERENCES "public"."companies"("handle") ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


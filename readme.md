DSI & DFG Scholars Program, Implementation Details
==================================================

## General Outline

1. Issue faculty call (first week of August or December)
   1. Optional: hold faculty information session mid-month
2. Faculty call ends; decide which projects to fund (+3-4 weeks)
   1. Create project pages on site
   2. Contact faculty about decision
   3. Create student application form
3. Circulate student application form (+1 week)
   1. Optional: hold student information session mid-month
4. Student applications due (+2-3 weeks)
   1. Circulate applications to faculty
5. Faculty/student interviews and selection (+4 weeks)
6. Stipend information due (+1 week)

## Faculty Call

1. Create an application form
2. [Draft](scripts/faculty_call_template.R) an announcement and send it to Jonathan

## Funding Decision

1. Make a decision on which projects to fund
   1. Close the submission form
   2. (Optional) Duplicate the submission sheet
   3. Modify the sheet and at least add columns
      * Decision - 0/1 for approved for funding
      * Program - best outcome for project, one of "DSI" for DSI Scholars, "DFG" for Data For Good, "CC" for campus connections, "Stats" for statistics department referrals, or "None" for projects to include for bookkeeping but not emailing
      * Email greeting - "Dear XXX,"
   4. Modify the sheet, adding any desired rows (for example, externally sourced Data For Good projects)
2. Create basic project pages
   1. Download the sheet as a csv
      * Do not check this file into the repository
   2. Run the page creation [script](scripts/project_page_skeleton.R)
3. Clone and update the student application form ([previous term's](https://docs.google.com/forms/d/1M-SVYlR1dKw3plAoJ1rxspTBRunMR-4QutycMEa7jAo/edit))
   * Because the language between spring/summer and fall changes, it can be useful to also refer to last [spring/summer's](https://docs.google.com/forms/d/1xYos2eQwoEoiYzYjiHi7U4ll9RSSmQ2P4KaKZwZ032g/edit?usp=drive_web)
4. Email faculty regarding decisions by running the email [script](scripts/faculty_submission_response.R)


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

## Sending Emails

Gmail drafts are created using the [gmailr](https://github.com/r-lib/gmailr) package for R. This requires configuring Gmail itself to permit API access and downloading a set of credentials files to the local compute. Steps for this can be found [here](https://github.com/r-lib/gmailr#setup). Note that the credentials file should not be checked into the repository. By default, this file is expected to sit in the `site-source` folder (see below).

## Maintaining the Website

The website is comprised of two repositories, [`site-source`](https://github.com/CU-DSI-Scholars/site-source) and [`DSI-scholars`](https://github.com/CU-DSI-Scholars/DSI-scholars). The first contains the content used to build the second, which is the website itself. In order to to get started, check out both repositories so that they sit in the same root directory. For example:

```
mkdir ~/Documents/CU-DSI-Scholars
cd ~/Documents/CU-DSI-Scholars
git clone https://github.com/CU-DSI-Scholars/site-source
git clone https://github.com/CU-DSI-Scholars/DSI-scholars
```

The website itself is built from `site-source` using the [blogdown](https://github.com/rstudio/blogdown) package. The general workflow is:

1. Modify `site-source` in some way and check in the change into the repository:
   1. Change directory to the site source by executing `cd ~/Documents/CU-DSI-Scholars/site-source`
   2. Evaluate the changes by executing `git status`
   3. Add any updated files by using `git add -u`
   4. Add any new files by using `git add FILE_NAME`
   5. Commit the changes by using `git commit -m 'COMMIT_MESSAGE'`
   6. Push the changes `git push`
2. Load `site-source.Rproj` in Rstudio or start a base R session and set the working directory to `PATH/TO/site-source`
3. Run `blogdown::build_site()` from within R; this will update 
4. Check in the changes to the `DSI-scholars` repository using `git` status/add/commit/push steps from above

## Structure of the Repository

The following paths and files in `site-source` are important:

* `config.toml` - contains overall settings for the site including the url for the "Apply Now" button; change this to the new student application form as necessary
* `content/page` - static pages, currently used for FAQs and overview of DSI programs
* `content/post` - individual blog "posts", in particular the project pages
* `static` - anything in this folder gets verbatim copied to the website; it is currently used to stash images (not needed at all) and to host pdfs/docs that are specific to individual projects

### Static URLs

In addition, four files will always be reachable through specific URLs by using HTTP redirects. As of writing, these are:

* [content/page/pi_faq_2021_spring_summer.md](content/page/pi_faq_2021_spring_summer.md) - the alias line in this file means that it can always be reached at https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_faq/
* [content/post/2020-12-09-call-for-faculty-participation-dsi-scholars-spring-summer-2021.md](content/post/2020-12-09-call-for-faculty-participation-dsi-scholars-spring-summer-2021.md) is aliased to https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_call/
* [content/page/faq_2021_spring-summer.md](content/page/faq_2021_spring-summer.md) is aliased to https://cu-dsi-scholars.github.io/DSI-scholars/static/student_faq/
* [content/post/2021-01-05-call-for-student-applications-dsi-dfg-scholars-spring-summer-2021.md](content/post/2021-01-05-call-for-student-applications-dsi-dfg-scholars-spring-summer-2021.md) is aliased to https://cu-dsi-scholars.github.io/DSI-scholars/static/student_call/

When a new FAQ or faculty call are released, or if additional static URLs are desired, these files will have to be edited to remove their alias blocks and those blocks added elsewhere.

## Clip Art

Currently, clip art is hosted on the free image hosting site [Cloudinary](https://cloudinary.com/). It is not necessary to use this, but the site does have some advantages. The structure of a Cloudinary link has some useful information:

```
https://res.cloudinary.com/vdoriecu/image/upload/c_thumb,w_200,g_face/v1599765419/social_network_bskhfi.png`
https://res.cloudinary.com/USERNAME/image/upload/TRANSFORMATION/FILEID/FILENAME.png`
```

For the most part, when a new piece of clip art is uploaded it is sufficient to copy an old URL, if necessary change the user name, and change just the file id and file name component. This allows you to re-use the existing transformation, most of which are necessary to turn in the image into a thumbnail of the appropriate size. You an optionally adjust that on Cloudinary itself.

## URL Shortening

URL shortening is done through [bit.ly](bit.ly). It is only truly necessary for the application forms, as Google forms does not allow HTML (maybe you can copy/paste, never tried).

## Faculty Call

1. Create and update an application form by cloning the previous [one](https://docs.google.com/forms/d/1804fmD_dkfSvNY3MGkIf2F3oQZzHuFWLbdSHi1Qc73Y/edit)
   * Banner image is created by modifying [opencall_faculty2.xcf](static/img/opencall_faculty2.xcf) using [GIMP](https://www.gimp.org/)
   * It can be helpful to also look at the call from the [year previous](https://docs.google.com/forms/d/1G2oDkj4_6B8pHeyyowdCaB3OycboLoqNM4KXqFl99Ys/edit?usp=drive_web), to see if any term-specific language needs to be included
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
   * See the step below
4. Email faculty regarding decisions by running the email [script](scripts/faculty_submission_response.R)

Once the emails have been sent, update the [tags](https://cu-dsi-scholars.github.io/DSI-scholars/tags/) and clip art for projects.

## Student Application Form and Call

1. Clone and update the previous student application [information page](content/post/2020-09-09-call-for-student-applications-dsi-dfg-scholars-fall-2020.md).
2. Clone and update the previous [application form](https://docs.google.com/forms/d/1M-SVYlR1dKw3plAoJ1rxspTBRunMR-4QutycMEa7jAo/edit).
   * Once a new form has been created, update the `Apply Now` link on the website by editing [config.toml](config.toml)
3. Clone and update the previous student [FAQ](content/page/faq_2020_fall.md).
4. Schedule an online information session (previous [slides](https://docs.google.com/presentation/d/11KPHFM94AcjEuTAZRP7qDmFmQ9UOYkK2EYHZY3bemyU/edit))
5. Update, execute, and send the [student announcement](scripts/student_call_template.R) to Jonathan and Tian

## "Opening" Projects

In sending responses to faculty who were not approved for matching funds and who did not have a student already selected, faculty have the option of having their projects posted as unpaid internships. By default, the [project_page_skeleton.R](scripts/project_page_skeleton.R) script creates pages for these but they are lised as "Closed". To open them:

1. Change the category lines to "Open" in the project's `content/post` markdown file, re-build the website with `blogdown`, and add/commit/push the changes
2. Add the project title to the application form
3. Contact faculty, sending them links to the project page and application form and letting them know of the student deadline

## Tracking Students

For now, unfortunately students need to be tracked in two places: one for [payment](https://docs.google.com/spreadsheets/d/1HZanMFHPHIF7nVmIxa52A2JjbHYJyrWp4aGGZyYwTBY/edit#gid=0) info and one for program [oversight](https://docs.google.com/spreadsheets/d/1_wQZX-PCAHGvhRKO_ldlvFIy0P2Pc5BPbOtKunLsMKg/edit#gid=0). The payment sheet should be cloned each term. In each instance, add rows to record every student and all of the faculty who participate. 

## Notifying Faculty

This section relies on a Google script. It has a number of areas in which it could be improved, and consequently requires some additional work and checking to make sure that everything is OK.

### Generating Submission Response Data

1. Stop the student application form from accepting submissions.
   * Edit the closed-survey response to point students to the current DSI project [doc](https://docs.google.com/document/d/1wRTuqScmE88TadHpozLLHUUj3dW0L3mT_iiG5tIX8J0/edit?usp=sharing)
2. Make a copy of the faculty submission [sheet](https://docs.google.com/spreadsheets/d/1wm63Hb7Dne0HVHjM42hZXD59xT8-Gse79YYqfrY5RtI/edit#gid=1087149307) from the **current** term and rename it something like "For Script".
   1. Modify the sheet to contain only the projects listed on the application form, **in the same order** that they appear there
   2. Make sure that the sheet has the following columns:
      * Greeting - How to greet the person in email
      * Funded - 1 if DSI will be offering a stipend to the students selected for this project, 0 otheriwse
      * Program - DSI or DFG
3. Make a blank sheet in the student applications folder and call it something like "Student Application Script Results"
4. Make a copy of the student submission response [script](https://script.google.com/d/1XkQBMpzhcRTRR8plhy56IsZ7jBJYvR9NCCGpzQQUs9cAXHeFIvSbMBMS/edit?usp=sharing) from a **previous** term and move it to the correct folder.
   1. Modify this script to point the above two sheets and the student form results; the IDs can be found as long character strings in the sheet URLs
      1. `studentsSheetID` should point to the student application form
      2. `projectsSheetID` should point to the faculty submission copy from step 1.
      3. `resultsSheetID` should point to the blank sheet from step 2. 
   2. Edit the rest of the script:
      1. Strings that refer to different terms/years all need to be updated; if they are folder/file names, make sure they match what is in the drive
      2. The constants defining column numbers in lines 47 to 52 should be the matching columns from the _faculty submission copy_
      3. The constant `LAST_QUESTION_COLUMN` is the number of the last column in the student application sheet before the project selection begins. It is currently `i`, or 9.
      4. `NUM_PROJECTS` should be the actual number of projects that are in the application form, not the nubmer of rows in the faculty submission sheet
5. Run the Google script from step 4
   * Double check the result by manually scanning the student application form sheet for a few random selected students or projects
   * There should be the correct number of projects and each faculty should get the correct material

### Sending Results to Faculty

1. Download a copy of the results sheet from step 3 in the previous section as a csv.
2. Run the faculty application review [script](scripts/student_application_review.R) to create email drafts
   * `application_results_file` in this script should point to the csv from step 1.
3. Edit the sharing options for the student resume folder on Google drive to make sure that all faculty have _read_ access.
   * The script should give them write access to their own project folders, however if they used a non-gmail email address the sharing settings may need to be set manually.


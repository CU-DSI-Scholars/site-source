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
mkdir ~/Documents/dsi_scholars
cd ~/Documents/dsi_scholars
git clone https://github.com/CU-DSI-Scholars/site-source
git clone https://github.com/CU-DSI-Scholars/DSI-scholars
```

The website itself is built from `site-source` using the [blogdown](https://github.com/rstudio/blogdown) package. The general workflow is:

1. Modify `site-source` in some way.
   1. Check in the change into the repository (`git add` new files; `git commit -m '` commit message `'`; `git push`)
2. Load `site-source.Rproj` in Rstudio or start a base R session and set the working directory to `PATH/TO/site-source`
3. Run `blogdown::build_site()` from within R; this will update 
4. Check in the changes to the `DSI-scholars` repository using `git` add/commit/push

## Structure of the Repository

The following paths and files in `site-source` are important:

* `config.toml` - contains overall settings for the site including the url for the "Apply Now" button; change this to the new student application form as necessary
* `content/page` - static pages, currently used for FAQs and overview of DSI programs
* `content/post` - individual blog "posts", in particular the project pages
* `static` - anything in this folder gets verbatim copied to the website; it is currently used to stash images (not needed at all) and to host pdfs/docs that are specific to individual projects

### Static URLs

In addition, two files will always be reachable through specific URLs by using HTTP redirects. As of writing, these are:

* `content/post/pi_faq_2021_spring_summer.md` - the alias line in this file means that it can always be reached at [https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_faq/](/static/pi_faq)
* `content/page/2020-12-09-call-for-faculty-participation-dsi-scholars-spring-summer-2021.md` is aliased to [https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_call/](/static/pi_call)

When a new FAQ or faculty call are released, or if additional static URLs are desired, these files will have to be edited to remove their alias blocks and those blocks added elsewhere.

## Clip Art

Currently, clip art is hosted on the free image hosting site [Cloudinary](https://cloudinary.com/). It is not necessary to use this, but the site does have some advantages. The structure of a Cloudinary link has some useful information:

* `https://res.cloudinary.com/vdoriecu/image/upload/c_thumb,w_200,g_face/v1599765419/social_network_bskhfi.png`
* `https://res.cloudinary.com/USERNAME/image/upload/TRANSFORMATION/FILEID/FILENAME.png`

For the most part, when a new piece of clip art is uploaded it is sufficient to copy an old URL, if necessary change the user name, and change just the file id and file name component. This allows you to re-use the existing transformation, most of which are necessary to turn in the image into a thumbnail of the appropriate size. You an optionally adjust that on Cloudinary itself.

## URL Shortening

URL shortening is done through [bit.ly](bit.ly). It is only truly necessary for the application forms, as Google forms does not allow HTML (maybe you can copy/paste, never tried).

## Faculty Call

1. Create and update an application form by cloning the previous [one](https://docs.google.com/forms/d/1804fmD_dkfSvNY3MGkIf2F3oQZzHuFWLbdSHi1Qc73Y/edit)
   * Banner image is created by modifying [static/img/opencall_faculty2.xcf] using [GIMP](https://www.gimp.org/)
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

1. Clone and update the previous student application [information page](page/2020-09-09-call-for-student-applications-dsi-dfg-scholars-fall-2020.md).
2. Clone and update the previous [application form](https://docs.google.com/forms/d/1M-SVYlR1dKw3plAoJ1rxspTBRunMR-4QutycMEa7jAo/edit).
3. Schedule an online information session (previous [slides](https://docs.google.com/presentation/d/11KPHFM94AcjEuTAZRP7qDmFmQ9UOYkK2EYHZY3bemyU/edit))
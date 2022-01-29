# This file creates a draft of the call for faculty participation. In the past,
# it has been forwarded to Jonathan and/or Tian to be circulated among the
# faculty. With the addition of some DSI communication staff, it will likely
# need to modified before it can be sent out so it should be prepared a few days
# before you would like it to be sent.

### VARIABLES TO UPDATE #####
# Everything from here to VARIABLES END will likely need to be changed.

# URL to banner. In previous years we used a modified DSI Scholars logo with the
# submission date added, but the communications team has removed that and just
# used the base version.
call_banner_url <- 
  "https://cu-dsi-scholars.github.io/DSI-scholars/img/opencall_students_spring2022.png"

student_call_url <-
  "https://cu-dsi-scholars.github.io/DSI-scholars/static/student_call"
student_faq_url <-
  "https://cu-dsi-scholars.github.io/DSI-scholars/static/student_faq"

info_session_url <-
  "https://columbiauniversity.zoom.us/j/96315428405"

info_session_time <-
  "from previous years"

apply_now_img_url <-
  "/Users/ipekensari/Documents/GitHub/site-source/static/img/opencall_students_spring2022.png"

year <- 2022
term <- "Spring/Summer"

application_deadline <- as.Date("2022-02-12")
application_deadline_short <- format(application_deadline, "%m/%d/%Y")
application_deadline_long <- toupper(format(application_deadline, "%B %d, %Y"))
application_deadline_bold <- toupper(application_deadline_long)

# Where the students can apply.
application_url <-
  "https://docs.google.com/forms/d/e/1FAIpQLSf8u16CFmcCR_6kgdCUwkN8SJg-VFR9EfRJjDCt2AgDGNngkQ/viewform?usp=sf_link"


# Credentials file created from gmail; set to where the file can be found.
# Info on creating it can be found at https://github.com/r-lib/gmailr#setup
credentials_file <- file.path("gmail_credentials.json")

# Configure as desired.
email_to <- "Ipek Ensari <ie2145@columbia.edu>"
email_from <- "Ipek Ensari <ie2145@columbia.edu>"

email_title <- glue("
  Data Science Institute {term} Scholars Programs | Application Deadline {application_deadline_short}")

### VARIABLES END ###

if (!require(gmailr, quietly = TRUE)) {
  remotes::install_github("r-lib/gmailr")
  library(gmailr, quietly = TRUE)
}
library(glue, quietly = TRUE)

email_body <- glue("
  <center>
  <a href=\"{application_url}\">
  <img src=\"{call_banner_url}\" width=\"479\" height=\"346\">
  </a>
  <h1 style=\"color:#0072CE;\">DSI Scholars Program</h1>
  <h2>Call for Student Applications | {term} {year} Cohort</h2>
  <h3 style=\"color:#FF0000\">DEADLINE TO APPLY: {application_deadline_bold}</h3>
  </center>
  <p>The <a href=\"http://datascience.columbia.edu/\">Data Science Institute\\
  </a> is pleased to announce that the Data Science Institute (DSI) and Data \\
  For Good Scholars Programs for <a href=\"{student_call_url}\">{term} {year}\\
  </a> are open for applications.</p>
  <p>The goal of the DSI Scholars Program is to engage Columbia's \\
  undergraduate and master students in data science research with Columbia \\
  faculty through a research internship. The program connects students with \\
  research projects across Columbia and provides student researchers with \\
  additional learning experience and networking opportunities. Through unique \\
  enrichment activities, this program aims to foster a learning and \\
  collaborative community in data science at Columbia.</p>
  <p>The Data For Good Scholars program connects student volunteers to \\
  organizations and individuals working for the social good whose projects \\
  have developed a need for data science expertise. As \"real world\" \\
  problems with real world data, these projects are excellent opportunities \\
  for students to learn how data science is practiced outside of the \\
  university setting and to learn how to work effectively with people for \\
  whom data science sits outside of their subject area.</p>
  <p>Please give yourself enough time to read the project descriptions, and read the \\
  <a href=\"{student_faq_url}\">FAQ</a> to familiarize yourself with the program logistics.\\
  For your application, choose the <span style=\"background-color:#FFFF00\";\">TOP five \\
  projects of which you are most interested, eligible and qualified.</span> Please use the \\
  submission system and do not email project PIs directly to submit your application.</p> 
  <p> For questions, you can email <a href=\"mailto:dsi-scholars@columbia.edu\">\\
  dsi-scholars@columbia.edu</a>, see our <a href=\"{student_faq_url}\">FAQ</a>, \\
  or <a href=\"{info_session_url}\">review</a> the information session \\
  materials from previous semesters.</p>
  <center>
  <p><strong>The Data Science Institute encourages women and \\
  underrepresented minorities to apply to these programs.</strong></p>
  <h3>Applications are due by {application_deadline_long}.</h3>
  <p><a href=\"{application_url}\"><img src=\"{apply_now_img_url}\"></a></p>
  </center>")

if (!require(gmailr, quietly = TRUE)) {
  remotes::install_github("r-lib/gmailr")
  require(gmailr, quietly = TRUE)
}

gm_auth_configure(path = credentials_file)

email <- gm_mime(to = email_to,
                 from = email_from,
                 subject = email_title) %>%
  gm_html_body(email_body, content_type = "text/html", charset = "utf-8")

gm_create_draft(email)


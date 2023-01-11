# This file creates a draft of the call for faculty participation. In the past,
# it has been forwarded to DSI admin team (Radhika, Jessica, John, communications team etc.) to be circulated among the
# faculty. With the addition of some DSI communication staff, it will likely
# need to modified before it can be sent out so it should be prepared a few days
# before you would like it to be sent.

### VARIABLES TO UPDATE #####
# Everything from here to VARIABLES END will likely need to be changed.

# URL to banner. In previous years we used a modified DSI Scholars logo with the
# submission date added, but the communications team has removed that and just
# used the base version.
call_banner_url <- 
  "https://github.com/CU-DSI-Scholars/site-source/blob/main/static/img/opencall_faculty_ss2023_banner.png?raw=true"

year <- 2023
year_bootcamp  <- 2023
year_town_hall <- 2023
term <- "Spring/Summer"
year_term_description <- "Spring/Summer 2023 sessions"

num_projects_last_year <- 30
num_applications_last_year <- 200

application_deadline <- "February 9th, 2023"

# Where faculty can apply.
application_url <-
  "https://docs.google.com/forms/d/e/1FAIpQLSexk3F7EcVWWLsueTuTbLdlLiMdckE-HkKd6HiPNpNdjfjNYg/viewform?usp=sf_link"

# If you are hosting your own online information sessions, modify this text
# accordingly. Right now it refers to the one from August.
info_session <- paste0(
  "A video recording from a previous online information session can be found ",
  "<a href=\"https://columbia.hosted.panopto.com/Panopto/Pages/Viewer.aspx?id=f0b73385-07e1-4c23-8f7b-ac2200f91b94\">",
  "here</a>, and slides from the same event can be found ",
  "<a href=\"https://docs.google.com/presentation/d/1aE19WTanf2I37brBsvsYpVG353Or7kRzP2ZoofAfrRU/edit?usp=sharing\">",
  "here</a>. ")

# Credentials file created from gmail; set to where the file can be found.
# Info on creating it can be found at https://github.com/r-lib/gmailr#setup
credentials_file <- file.path("gmail_credentials.json")
  
# Configure as desired.
email_to <- "Ipek Ensari <ie2145@columbia.edu>"
email_from <- "Ipek Ensari <ie2145@columbia.edu>"

email_title <- "DSI Scholars Program Project Submissions due February 9th, 2023"

### VARIABLES END ###

if (!require(gmailr, quietly = TRUE)) {
  remotes::install_github("r-lib/gmailr")
  library(gmailr, quietly = TRUE)
}
library(glue, quietly = TRUE)

email_body <- glue("
  <center>
  <a href=\"https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_call\">
  <img src=\"{call_banner_url}\" width=\"600px\"/></a>
  <h1 style=\"color:#0072CE;\">DSI Scholars Program</h1>
  <h2>Call for Faculty Participation | {term} {year} Cohort</h2>
  <h2 style=\"color::#FF0000\">DEADLINE TO APPLY: {application_deadline}</h2>
  </center>
  <p>The Data Science Institute is calling for faculty submissions of \\
  research projects for the {year_term_description} of the Data Science \\
  Institute (DSI) Scholars Program. The goal of the DSI Scholars Program is \\
  to engage undergraduate and master students to work with Columbia faculty, \\
  through the creation of data science research internships. Last year, we \\
  worked with {num_projects_last_year} projects and received more than \\
  {num_applications_last_year} unique applications from Columbia Students. \\
  The program's unique enrichment activities foster a learning and \\
  collaborative community in data science at Columbia. Apply \\
  <a href=\"{application_url}\">here</a>, and find more details \\
  <a href=\"https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_call\">\\
  here</a>.</p>
  <ul>
  <li><b>Funding support</b>: For selected projects, the DSI will provide \\
    matching funds of up to $2,500 per project for internship-supporting \\
    stipends. Approximately 10 such stipend funds will be awarded. This fund \\
    is expected to be a fraction of a full stipend that is appropriate for \\
    the time and effort required by the research project. The DSI Scholars \\
    program recommends that the PI/lab engage DSI scholars approximately \\
    8 hours a week during the academic semester and consider a full-time \\
    or part-time research internship during summer. Allocation of funds will \\
    be made via a first-come-first-serve need-based process, with efforts to \\
    balance allocation across disciplines, to prioritize new \\
    PIs/projects and new student scholars, and support novel interdisciplinary research.\\
    For more details on how projects are selected and information about whether your project \\
    might be appropriate for the Scholars Program (versus another DSI program), please see our PI FAQs. </li>
  <li><b>Administrative support</b>: The DSI will collect faculty-submitted \\
    internship positions and create an umbrella application page to solicit \\
    student applications. The collected applications for each position will \\
    be compiled and sent to the hosting faculty/center/lab for review. The \\
    faculty/center/lab will then review, identify and notify the Scholars for \\
    their own projects. Funded projects will receive additional support \\
    through the coordination of stipends with Student Financial services.
  <li><b>Intellectual support</b> via various DSI Scholars enrichment activities: \\
  The DSI education committee will organize various enrichment activities for the \\
  DSI Scholars Program, including speaker series, mini workshops, and peer research \\
  presentation meetups. These activities are contingent upon student interest and \\
  participation. In addition, all DSI Scholars (receiving matching funds or not) \\
  are invited to present their research during a DSI poster session at DSI Town Hall \\
  in the Fall semester.
    </ul>
  </ul>
  <p>Questions? Get full details <a \\
  href=\"https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_call\">here\\
  </a> or see our PI <a\\
  href=\"https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_faq/\">FAQ\\
  </a>! {info_session} You can also contact us at <a\\
  href=\"mailto:dsi-scholars@columbia.edu\">dsi-scholars@columbia.edu</a>.\\
  </p>")

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


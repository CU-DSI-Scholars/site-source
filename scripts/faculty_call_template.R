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
  "https://lh5.googleusercontent.com/LP--18iPxIK4nbMmqFyhr1LgI-8H1LQsTpzNlAHn-kACSzVslk45NM8nbq3MjIpjqrpWs3p0puCGLwWER9qgWTvHdhz2x0qrDTboqP67d2Omb1OlQcnbQpApzy3EFQ=w1872"

year <- 2021
year_bootcamp  <- 2021
year_town_hall <- 2021
term <- "Spring/Summer"
year_term_description <- "spring and/or summer 2021 sessions"

num_projects_last_year <- 42
num_applications_last_year <- 730

application_deadline <- "JANUARY 1, 2021"

# Where faculty can apply.
application_url <-
  "https://docs.google.com/forms/d/e/1FAIpQLScXsKgdf08Mv-8Q1mX23TUW-btopOZwq1Sj5YvpH2tVEEXmoA/viewform"

# If you are hosting your own online information sessions, modify this text
# accordingly. Right now it refers to the one from August.
info_session <- paste0(
  "A video recording from a fall online information session can be found ",
  "<a href=\"https://columbia.hosted.panopto.com/Panopto/Pages/Viewer.aspx?id=f0b73385-07e1-4c23-8f7b-ac2200f91b94\">",
  "here</a>, and slides from the same event can be found ",
  "<a href=\"https://docs.google.com/presentation/d/1aE19WTanf2I37brBsvsYpVG353Or7kRzP2ZoofAfrRU/edit?usp=sharing\">",
  "here</a>. ")

# Credentials file created from gmail; set to where the file can be found.
credentials_file <- file.path("gmail_credentials.json")
  
# Configure as desired.
email_to <- "Vincent Dorie <vjd2106@columbia.edu>"
email_from <- "Vincent Dorie <vjd2106@columbia.edu>"

email_title <- "Jan. 1 Deadline for DSI Scholars Program Project Submissions"

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
    5-8 hours a week during the academic semester and consider a full-time \\
    or part-time research internship during summer. Allocation of funds will \\
    be made via a first-come-first-serve need-based process, with efforts to \\
    balance allocation across disciplines, to prioritize new \\
    PIs/labs/projects, and support novel interdisciplinary research.</li>
  <li><b>Administrative support</b>: The DSI will collect faculty-submitted \\
    internship positions and create an umbrella application page to solicit \\
    student applications. The collected applications for each position will \\
    be compiled and sent to the hosting faculty/center/lab for review. The \\
    faculty/center/lab will then review, identify and notify the Scholars for \\
    their own projects. Funded projects will receive additional support \\
    through the coordination of stipends with Student Financial services.
  <li><b>Intellectual support</b> via the DSI Scholars enrichment activities: \\
  The DSI education committee will organize the following enrichment \\
  activities for the DSI Scholars Program.
    <ul>
    <li>Bootcamps on Data Science Research Skills - During the first weeks of \\
    summer {year_bootcamp} we will run bootcamps on data science research \\
    skills. All students who have been selected for a DSI Scholars project \\
    (receiving matching funds or not) are especially encouraged to attend, \\
    with additional seats available for other interested applicants.</li>
    <li>Scholars in Data Science meetup series - Throughout this series, we \\
    will provide Scholars opportunities to learn about data science research \\
    outside their own project and a community of peer student researchers. \\
    Each session will be led by a data scientist at Columbia and will consist \\
    of a 45-minute seminar talk and a 45-minute hands-on activity.</li>
    <li>Annual Research Poster Session: All DSI Scholars (receiving matching \\
    funds or not) will be invited to present their research during a DSI \\
    poster session at DSI Town Hall in the fall {year_town_hall} semester.</li>
    </ul>
  </ul>
  <p>Questions? Get full details <a \\
  href=\"https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_call\">here\\
  </a> or see our PI <a\\
  href=\"https://cu-dsi-scholars.github.io/DSI-scholars/page/pi_faq/\">FAQ\\
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


email.title <- "Data Science Institute | Scholars Program | Call for Faculty Participation"
email.body <- 
"<center><a href=\"https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_call\"><img src=\"https://lh3.googleusercontent.com/7oFx1Xs8Qm2ozJLytetw9J0yV5YC3fXkmfVxe_rDWGUD5Myk-Ke_zYnymBx4XzrEfEjFXtOAv8K5jFfGscUKALpzxLE2lKIexlzUGFU7OMwqJ0zIStrA2V4EG8U9Ww=w1872\" width=\"600px\"/></a>
<h1 style=\"color:#0072CE;\">
DSI Scholars Program</h1>
<h2>Call for Faculty Participation<br/>
Spring/Summer 2021 Cohort</h2></center>
<p>The Data Science Institute is calling for faculty submissions of research projects for the spring and/or summer 2021 sessions of the Data Science Institute (DSI) Scholars Program. The goal of the DSI Scholars Program is to engage undergraduate and master students to work with Columbia faculty, through the creation of data science research internships. Last year, we worked with 42 projects and received more than 730 unique applications from Columbia Students. The program's unique enrichment activities foster a learning and collaborative community in data science at Columbia. Apply <a href=\"https://docs.google.com/forms/d/e/1FAIpQLScXsKgdf08Mv-8Q1mX23TUW-btopOZwq1Sj5YvpH2tVEEXmoA/viewform\">here</a>, and find more details <a href=\"https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_call\">here</a>.</p>

<ul>
<li><b>Funding support</b>: For selected projects, the DSI will provide matching funds of up to $2,500 per project for internship-supporting stipends. Approximately 10 such stipend funds will be awarded. This fund is expected to be a fraction of a full stipend that is appropriate for the time and effort required by the research project. The DSI Scholars program recommends that the PI/lab engage DSI scholars approximately 5-8 hours a week during the academic semester and consider a full-time or part-time research internship during summer. Allocation of funds will be made via a first-come-first-serve need-based process, with efforts to balance allocation across disciplines, to prioritize new PIs/labs/projects, and support novel interdisciplinary research.</li>
<li><b>Administrative support</b>: The DSI will collect faculty-submitted internship positions and create an umbrella application page to solicit student applications. The collected applications for each position will be compiled and sent to the hosting faculty/center/lab for review. The faculty/center/lab will then review, identify and notify the Scholars for their own projects. Funded projects will receive additional support through the coordination of stipends with Student Financial services.
<li><b>Intellectual support</b> via the DSI Scholars enrichment activities: The DSI education committee will organize the following enrichment activities for the DSI Scholars Program.
<ul>
<li>Bootcamps on Data Science Research Skills - During the first weeks of summer 2021, we will run bootcamps on data science research skills. All students who have been selected for a DSI Scholars project (receiving matching funds or not) are especially encouraged to attend, with additional seats available for other interested applicants.</li>
<li>Scholars in Data Science meetup series - Throughout this series, we will provide Scholars opportunities to learn about data science research outside their own project and a community of peer student researchers. Each session will be led by a data scientist at Columbia and will consist of a 45-minute seminar talk and a 45-minute hands-on activity.</li>
<li>Annual Research Poster Session: All DSI Scholars (receiving matching funds or not) will be invited to present their research during a DSI poster session at DSI Town Hall in the fall 2021 semester.</li>
</ul>
</ul>
<p>Questions? Get full details <a href=\"https://cu-dsi-scholars.github.io/DSI-scholars/static/pi_call\">here</a> or see our PI <a href=\"https://cu-dsi-scholars.github.io/DSI-scholars/page/pi_faq/\">FAQ</a>! A video recording from a fall online information session can be found <a href=\"https://columbia.hosted.panopto.com/Panopto/Pages/Viewer.aspx?id=f0b73385-07e1-4c23-8f7b-ac2200f91b94\">here</a>, and slides from the same event can be found <a href=\"https://docs.google.com/presentation/d/1aE19WTanf2I37brBsvsYpVG353Or7kRzP2ZoofAfrRU/edit?usp=sharing\">here</a>. You can also contact us at <a href=\"mailto:dsi-scholars@columbia.edu\">dsi-scholars@columbia.edu</a>.</p>"

credentials.file <- file.path(
  "/Users/vdorie/Documents/Data Science/Scholars/dsischolarsemailcodes/DSIScholarsEmails",
  "credentials.json")

if (!require(gmailr, quietly = TRUE)) {
  remotes::install_github("r-lib/gmailr")
  require(gmailr, quietly = TRUE)
}

gm_auth_configure(path = credentials.file)

email <- gm_mime(to = "Vincent Dorie <vjd2106@columbia.edu>",
                 from = "Vincent Dorie <vjd2106@columbia.edu>",
                 subject = email.title) %>%
                 gm_html_body(email.body, content_type = "text/html", charset = "utf-8")

gm_create_draft(email)


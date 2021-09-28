# Sends information to faculty about their applications. Requires the output sheet of the 
# Google script.

if (!require(gmailr, quietly = TRUE)) {
  remotes::install_github("r-lib/gmailr")
  library(gmailr, quietly = TRUE)
}

library(glue, quietly = TRUE)
library(magrittr, quietly = TRUE)

### VARIABLES TO UPDATE #####
# Everything from here to VARIABLES END will likely need to be changed.

# Credentials file created from gmail; set to where the file can be found.
# Info on creating it can be found at https://github.com/r-lib/gmailr#setup
credentials_file <- "gmail_credentials.json"

# Configure as desired.
email_from <- "Ipek Ensari <ie2145@columbia.edu>"
email_replyto <- "dsi-scholars@columbia.edu"
email_cc <- "jrs2139@columbia.edu "

# applications results file is downloaded csv from script form referenced above.
data_dir  <- "data"
application_results_file <- "applicationinfo_fall_2021.csv"

project_term <- "Fall"
project_year <- "2021"

notification_date <- "October 7th, 2021"

stipend_term <- "Fall"
next_stipend_term <- "Spring"
stipend_submission_date <- "October 11th, 2021"
stipend_filing_estimate <- "October 15th, 2021"

subject_dsi <- glue("[DSI-Scholars { project_term } {project_year }] Applications For Your Review")
subject_dfg <- glue("[DFG-Scholars { project_term } {project_year }] Applications For Your Review")

header_dsi <- glue("DSI Scholars Program { project_term } {project_year }")
header_dfg <- glue("DFG Scholars Program { project_term } {project_year }")

email_signature <- glue("
<p>All the best,<br/>Ipek</p>
<p style='margin-bottom:1cm;'></p>
<p>
--<br/>
Ipek Ensari<br/>
Associate Research Scientist<br/>
Director DSI & DFG Scholar Programs<br/>
Data Science Institute at Columbia University<br/>
Northwest Corner #1401, 550 W 120th St, New York, NY 10027<br/>
ie2145@columbia.edu | 646-745-8498</p>")

# If TRUE, prints emails to console instead of creating them as drafts.
test_only <- FALSE

### VARIABLES END ###

application_info <- read.csv(file.path(data_dir, application_results_file))

gm_auth_configure(path = credentials_file)

for (i in seq_len(nrow(application_info))) {
  with(application_info[i,], {
    is_dfg <- program %in% "DFG"
    
    body <- glue("
<h4>{ if (is_dfg) header_dfg else header_dsi }</h4>
<hr/>
<h3>Applications ready for review for { if (is_dfg) \"\" else \"Professor\" } {name}</h3>
<p>Dear { greeting },</p>
<p>I hope this email finds you well. We have received { app.num } applications for your project \\
'{ project }' in the { if (is_dfg) \"DFG\" else \"DSI\" } Scholars program for \\
{ project_term } { project_year }. You can review these applications in <a href='{ url }'>\\
this</a> google drive folder.</p>")
    
    body %<>% glue("
<p>There are two files in your folder. One has a spreadsheet summarizing all the \\
applications. The other is a google doc with one page for each applicant. In the \\
application form, some students provided one reference. You can reach out to schedule \\
interviews and obtain more information as you see fit. If you notice any processing \\
errors such as wrong files, please let us know as soon as possible and we will do our \\
best to address the issue. This folder was shared with the email used for submission - \\
if any other accounts need access to the application materials we will be happy to \\
arrange that for you.</p>")

    # Folder instructions
    if (is_dfg) {
      body %<>% glue("
<p>During the review process, please consider both a student's existing skill set and \\
their future public service potential. We encourage project owners to consider students \\
that may have less experience but are motivated to learn.</p>")
    } else {
      body %<>% glue("
<p>During the review process, please consider both a student's existing skill set and \\
their future research potential. We encourage faculty advisors to consider students that \\
may have less experience but are motivated to learn, especially those from outside of \\
data science.</p>")
    }
    
    # Student notification instructions
    if (is_dfg) {
      body %<>% glue("
<p>Please select the student(s) you would like to work with and notify them. \\
Students are expecting to hear from project owners by \\
<em>{ notification_date }</em>.")
    } else {
      body %<>% glue("
<p>Please select the student(s) you would like to work with and notify them directly. \\
Students are expecting to hear from faculty by <em>{ notification_date }</em>.")
    }
    body %<>% glue("
Every student applied to up to 5 projects and it is possible that they are selected for \\
multiple projects. As a result, you may need to keep a short wait list.</p>")

    # Matching fund instructions
    if (funded == 1) {
      if (is_dfg) {
        body %<>% glue("
<p>DFG coordinating funds will be arranged as a stipend for one of your selected scholars. \\
We are happy to work with you on selecting a student for this role, and on selecting team \\
members in general. Please let us know how we can help out.</p>")
      } else {
"<p>DSI Scholars matching funds, if applicable, will be arranged as a stipend for your DSI \\
Scholar. Once a match has been made, please inform us of the result. The deadline for \\
arranging a stipend for your scholar for the { stipend_term } semester will be \\
<em> { stipend_submission_date }</em>. Further instructions on arranging the payment will \\
be given out around { notification_date }. If you miss this deadline or would prefer to \\
wait, a stipend can be issued for the next term instead <em>unless the scholar is \\
graduating soon</em>.</p>"
      }
    }
    
    # Signoff
    if (is_dfg) {
      body %<>% glue("
<p>Thank you again for providing a positive data science experience to our students. We look forward to working with you and your student volunteers.</p>")
    } else {
      if (funded == 1) {
        body %<>% glue("
<p>Thank you again for providing this valuable research opportunity to our students. We look forward to working with you and your student researchers.</p>")
      } else {
        body %<>% glue("
<p>Thank you again for providing this valuable research opportunity to our students.</p>")
      }
    }
    
    body %<>% glue(email_signature)
        
    subject <- if (is_dfg) subject_dfg else subject_dsi
    
    if (test_only) {
      print(body)
      return(invisible(NULL))
    }
    
    email <- gm_mime(to = as.character(email),
                     from = email_from,
                     replyto = email_replyto,
                     cc = email_cc,
                     subject = subject) %>%
                     gm_html_body(body, content_type = "text/html", charset = "utf-8")
    gm_create_draft(email)
  })
}



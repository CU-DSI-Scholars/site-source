# Generates form emails to give faculty instructions on how to get
# their scholars paid.
if (!require(gmailr, quietly = TRUE)) {
  remotes::install_github("r-lib/gmailr")
  require(gmailr, quietly = TRUE)
}
library(glue, warn.conflicts = FALSE)

### VARIABLES TO UPDATE #####
# Everything from here to VARIABLES END will likely need to be changed.

# Credentials file created from gmail; set to where the file can be found.
# Info on creating it can be found at https://github.com/r-lib/gmailr#setup
credentials_file <- "gmail_credentials.json"

# Configure as desired.
email_from <- "Ipek Ensari <ie2145@columbia.edu>"
email_from_display <- "Ipek Ensari"
email_replyto <- "dsi-scholars@columbia.edu"
email_cc <- "vjd2106@columbia.edu"

email_subject <- "[DSI-Scholars Spring-Summer 2021] Instructions for Scholar Payment"

# Projects file is downloaded csv from faculty submission form referenced above.
data_dir  <- "data"
data_file <- "committments_spring-summer_2021.csv"

email_signature <- glue("
<p>All the best,<br/>Ipek</p>
<p style='margin-bottom:1cm;'></p>
<p>
--<br/>
Ipek Ensari<br/>
Associate Research Scientist<br/>
Co-Director DSI & DFG Scholar Programs<br/>
Data Science Institute at Columbia University<br/>
Northwest Corner #1401, 550 W 120th St, New York, NY 10027<br/>
ie2145@columbia.edu | 646-745-8498</p>")

### VARIABLES END ###

projects <- read.csv(file.path(data_dir, data_file))

emailBody <- "<p>Dear { Greeting },</p>

<p>Thank you for participating in the DSI Scholars program and submitting your scholar selection. In order to arrange payment* for your student(s), a list of information that we will need from you can be found below; please fill that out and respond to this email. In addition, please also confirm that the student(s) with which you intend to work on the project \"{ Project.Title }\" are:</p>

<ul>
  <li>Student name(s): { Student.Last.Name..First.Names }/li>
  <li>Student UNI(s): { Student.UNI }</li>
</ul>

<p>Information to supply:</p>
<ol>
  <li>Amount you will contribute, <b>per student**</b>:</li>
  <li>Name of department administrator:</li>
  <li>Department administrator email:</li>
</ol>

<p>Please let me know if you have any questions on the payment process.</p>

{ email_signature }

<p>* In order to minimize the administrative overhead for faculty and their departments, the DSI will support your project by arranging for a stipend to be issued to your student(s). Matching funds will be provided by adding to an amount charged to a chart string which your department administrator should be able to supply. If you have already arranged to pay your student as an employee, matching funds can also be issued by providing a pay-stub.<br/>
** This amount times the number of students is what will be charged to your account. <b>Total</b> contributions will be matched up to $2500. If you have more than one student and wish to pay them different amounts, please specify so above.</p>"

projects <- subset(projects, trimws(Data.For.Good.Designation) == "No" & trimws(Paid.Unpaid) == "Paid")

for (i in seq_along(projects)) projects[[i]] <- trimws(projects[[i]])

# NOTE: This does not handle projects with more than one student selected.
# It would be possible to combine them automatically, but for now they are
# handled manually.

gm_auth_configure(path = "credentials.json")

for (i in seq_len(nrow(projects))) {
  if (projects[i,"Student.UNI"] == "") next

  with(projects[i,], {
    email_text <- glue(emailBody)
    
    email <- gm_mime(to = Email.,
                     from = email_from,
                     cc = email_cc,
                     subject =  email_subject) %>%
                     gm_html_body(email_text, content_type = "text/html", charset = "utf-8")
    gm_create_draft(email)
  })
}


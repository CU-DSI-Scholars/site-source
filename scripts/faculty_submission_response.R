# Generates form emails to reply to faculty based on what was decided for
# submissions.

# Requires the faculty submission sheet to be downloaded into a csv
# that sheet should be modified to include the columns
#   Decision       - 0 or 1 if selected for matching fund
#   Email greeting - first or nickname
#   Program        - Destination for submission, one of DSI, DFG, CC, Stats,
#                    or None. 'None' projects are useful for not-emailing
#                    someone.

### VARIABLES TO UPDATE #####
# Everything from here to VARIABLES END will likely need to be changed.

# Credentials file created from gmail; set to where the file can be found.
# Info on creating it can be found at https://github.com/r-lib/gmailr#setup
credentials_file <- "gmail_credentials.json"

# Configure as desired.
email_from <- "Vincent Dorie <vjd2106@columbia.edu>"
email_from_display <- "Vincent Dorie"
email_replyto <- "dsi-scholars@columbia.edu"
email_cc <- "tian.zheng@columbia.edu"

# When sending a project to Campus Connections, manually forward their
# submission first. This will currently cc Violet in this email, in addition
# to that forward.
campus_connections_cc <- "zy2286@columbia.edu"

# Projects file is downloaded csv from faculty submission form referenced above.
data_dir  <- "data"
data_file <- "project_info_spring_summer_2021.csv"

project_term <- "Spring-Summer"
project_year <- "2021"

student_application_url <-
  "https://docs.google.com/forms/d/e/1FAIpQLSf94woxvAgbRqxBMUHZs_1H0Bn6dxaiHdIEk6kQTe4DvCH0ow/viewform?usp=sf_link"

library(glue, quietly = TRUE)

email_signature <- glue("
  <p>All the best,<br/>\\
  Vincent<br/>\\
  <br/>\\
  --<br/>\\
  Vincent Dorie<br/>\\
  Adjunct Research Scientist<br/>\\
  Co-Director DSI & DFG Scholar Programs<br/>\\
  Data Science Institute at Columbia University<br/>\\
  475 Riverside Drive, Interchurch 320L, New York, NY 10027<br/>\\
  vjd2106@columbia.edu | 646-745-8498</p>")

# These are auto-generated when the project pages are created and are relative
# to the date which they are posted under. It should only need updating if
# the files are generated in one month, but the emails are sent in another.
url_prefix <- format(Sys.Date(), "%Y/%m")
#url_prefix <- "2021/01" # If necessary to set manually, uncomment this.

# If TRUE, prints emails to console instead of creating them as drafts.
test_only <- FALSE

### VARIABLES END ###

if (!require(gmailr, quietly = TRUE)) {
  remotes::install_github("r-lib/gmailr")
  library(gmailr, quietly = TRUE)
}
library(dplyr, quietly = TRUE)
library(magrittr, quietly = TRUE)

projects <- read.csv(file.path(data_dir, data_file))

projects %<>%
  mutate(funding = Are.you.applying.for.DSI.need.based..matching.stipend.funding..up.to..2500..) %>%
  mutate(funding = case_when(grepl("unpaid", funding)      ~ "unpaid",
                             grepl("own funding", funding) ~ "self",
                             TRUE ~ "matching"),
         student_selected = Do.you.have.a.student.selected.for.this.position.already. == "Yes")    

subject_prefix <- glue("[DSI-Scholars {project_term} {project_year}]")

gm_auth_configure(path = credentials_file)

for (i in seq_len(nrow(projects))) {
  with(projects[i,], {
    if (Program %in% "None") return(invisible(NULL))
    
    cc <- email_cc
    
    body <- glue("
      <p>Dear {Email.greeting},</p>
      <p>Thank you for submitting your project '{Project.title}' to the DSI \\
      Scholars program for {project_term} {project_year}. ")
    
    include_application_link <- FALSE
    # Projects that applied for a matching fund and were not selected.
    if (Decision == 0 && !(Program %in% "DFG") && !(funding %in% "unpaid")) {
      subject <- glue(subject_prefix, " Project Submission")
      
      body %<>% glue("
        Unfortunately, we received more proposals than we have available \\
        funds and are unable to offer yours financial support. ")
      
      if (Program == "CC") {
        body %<>% glue("
          We think your project would be best able to find support through \\
          the Data Science Institute's Campus Connections program. We have \\
          forwarded your proposal to our colleagues who should be in touch \\
          shortly, and will help you recruit talent.</p>")
        cc %<>% glue(", {campus_connections_cc}")
      } else if (Program == "Stats") {
        body %<>% glue("
          We think your project would be best able to find support through \\
          the Statistics Department consulting program. We have forwarded \\
          your proposal to our colleagues who should be in touch shortly, and \\
          will help provide you with expertise.</p>")
      } else {
        if (student_selected) {
          body %<>% glue("
            However, we are still able to offer educational support, so if \\
            you would like to continue with your selected student researcher \\
            and have them be able to participate in the intellectual \\
            activities organized by the DSI Scholars program (boot camp, \\
            weekly meetups, and fall poster session), please reply to this \\
            email with their contact information. If you wish to recruit \\
            additional students, we will be happy to include your project in \\
            our call for student applications.</p>")
        } else {
          body %<>% glue("
            If you are interested in making your project available as an \\
            unpaid research internship, please respond to this email and we \\
            will include it in our call for student applications.</p>")
        }
      }
      
      body %<>% glue("
        <p>We are deeply grateful to you for taking the time to apply and \\
        this program wouldn't exist without faculty mentors such as yourself.\\
        </p>")
    } else {
      # All other projects
      title <- trimws(Project.title)
      if (endsWith(title, "."))
        title <- trimws(substr(title, 1, nchar(title) - 1))
      
      title_lowercase <- gsub("--", "-", gsub("[:,'?()]", "", gsub("[ /]", "-", tolower(title)))
      
      url <- glue("https://cu-dsi-scholars.github.io/DSI-scholars/{url_prefix}/project-{title_lowercase}")
      
      if (Program %in% "DSI") {
        subject <- glue(subject_prefix, " Project Confirmation")
        if (funding %in% "matching")
          subject <- glue(subject, " and Stipend Fund")
        
        if (funding %in% "matching") {
          body %<>% glue("
            We are pleased to inform you that we are able to offer you a \\
            matching fund of up to $2,500 that can be used towards a stipend \\
            for research interns who will work on your project. ")
          if (student_selected) {
            body %<>% glue("
              In order to provide a matching fund for your selected scholar, \\
              please send information with their name and UNI to \\
              dsi-scholars@columbia.edu. Instructions on arranging payment \\
              will follow in the coming weeks. If you wish to recruit \\
              additional students, we will be happy to include your project \\
              in our call for student applications.</p>")
          } else {
            body %<>% glue("
              We have created a <a href='{url}'>page</a> for your project \\
              based on the information provided in your submission that will \\
              be shared with prospective students. The tags and clipart will \\
              be modified to suit your project accordingly. Please double \\
              check carefully all the information on the page and notify us \\
              if you'd like to make any changes.</p>")
            include_application_link <- TRUE
          }
        } else {
          if (student_selected)
            stop("unexpected condition: student selected for internship not ",
                 "requesting matching fund")
          body %<>% glue("
            We have created a <a href='{url}'>page</a> for your project based \\
            on the information provided in your submission that will be \\
            shared with prospective students. The tags and clipart will be \\
            modified to suit your project accordingly. Please double check \\
            carefully all the information on the page and notify us if you'd \\
            like to make any changes.</p>")
          include_application_link <- TRUE
        }
      } else if (Program %in% "DFG") {
        subject <- glue(subject_prefix, "Project Submission")
        body %<>% glue(body, "
          We found your project to be very exciting and would like to know if \\
          you would be interested in participating in our Data For Good \\
          program. Rather than having a single student in a research \\
          internship, Data For Good projects recruit teams of volunteers who \\
          work together. Although there is some turnover, these volunteers \\
          tend to be highly motivated and experienced. To support project \\
          coordination, the DSI provides a small stipend to one student. If \\
          this sounds appealing, please let me know. If you prefer to have \\
          your project continue as a research internship in the DSI Scholars \\
          program, we are happy to do that as well.</p>")
      }
    }
    if (include_application_link)
      body %<>% glue("\n
        <p>We have prepared an umbrella student application \\
        <a href='{student_application_url}'>website</a> for all DSI Scholars \\
        projects that are open for application. Your project is listed on the \\
        application form. Applications to your project will be collected and \\
        passed on to you for review on October 1st, along with instructions \\
        on selecting a student.")
    body %<>% glue("\n", email_signature)
    
    if (test_only) {
      print(body)
      return(invisible(NULL))
    }
    
    email <- gm_mime(to = as.character(Email.Address),
                     from = email_from,
                     replyto = email_replyto,
                     cc = email_cc,
                     subject = subject) %>%
                     gm_html_body(paste0(body, collapse = "\n"), content_type = "text/html", charset = "utf-8")
    gm_create_draft(email)
  })
}


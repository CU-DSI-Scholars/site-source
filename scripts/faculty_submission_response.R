# generates form emails to reply to faculty

# requires the faculty submission sheet to be downloaded into a csv
# that sheet should be modified to include the columns
#   Decision       - 0 or 1 if selected for matching fund
#   Email-greeting - first or nickname

## VARIABLES TO UPDATE ####
# everything from here to VARIABLES END will have to be updated each term

# credientials file created from gmail
# set to where the file can be found
credentials.file <- file.path(
  "/Users/vdorie/Documents/Data Science/Scholars/dsischolarsemailcodes/DSIScholarsEmails",
  "credentials.json")


# configure as desired
email.from <- "Vincent Dorie <vjd2106@columbia.edu>"
email.from.display <- "Vincent Dorie"
email.replyto <- "dsi-scholars@columbia.edu"
email.cc <- "tian.zheng@columbia.edu"

# projects.file is downloaded csv from faculty submission form referenced above
projects.file <- file.path(
  "~/Documents/Data Science/Scholars/dsischolarsemailcodes/DSIScholarsEmails",
  "projectinfo_spring_2020.csv")

project.term <- "Spring-Summer"
project.year <- "2020"

url.prefix <- "2021/01"

# VARIABLES END

if (!require(gmailr, quietly = TRUE)) {
  remotes::install_github("r-lib/gmailr")
  require(gmailr, quietly = TRUE)
}

gm_auth_configure(path = credentials.file)


projects <- read.csv(projects.file, stringsAsFactors = FALSE)
projects$self.funded <- startsWith(projects$Are.you.applying.for.DSI.need.based.stipend.funding..up.to..2500.., "No")
        
subject.prefix <- paste0("[DSI-Scholars ", project.term, " ", project.year, "]")

for (i in seq_len(nrow(projects))) {
  with(projects[i,], {
    lines <- paste0("<p>Dear ", Email.greeting, ",</p>")
    studentAlreadySelected <- Do.you.have.a.student.selected.for.this.position.already. == "Yes"
    if (Decision == 0 && is.na(self.funded)) {
      subject <- paste0(subject.prefix, " Project Submission")
      
      lines <- c(lines,
        paste0("<p>Thank you for submitting your project '", Project.title, "' to the DSI Scholars program Spring-Summer 2020. ",
                "Unfortunately, we received more proposals than we have available funds and are unable to offer yours financial support. ",
                if (studentAlreadySelected)
                  "However, we are still able to offer enrichment activities, so if you would like to continue with your selected student researcher and have them be able to participate in the intellectual activities organized by the DSI Scholars program, (boot camp, weekly meetups and fall poster session), please have them <a href='https://forms.gle/KoMWKrPtqNkobSPdA'>register</a> with the DSI Scholars Program. " else
                "If you are interested in making your project available as an unpaid research opportunity, please respond to this email and we will include it in our call for student applications. As an alternative, we also encourage you to submit your project to the Data Science Institute's <a href='https://datascience.columbia.edu/connections'>Campus Connections</a> program. ",
                "We are deeply grateful to you for taking the time to apply and this program wouldn't exist without faculty mentors such as yourself.</p>"),
        "<p>If you have any questions, please don't hesitate to reach out to us at dsi-scholars@columbia.edu.</p>")
    } else {
      subject <- paste0(subject.pre, " Project Confirmation")
      if (!self.funded)
         subject <- paste0(subject, " and Stipend Fund")
      
      title.lower <- gsub(":|,|'|\\?", "", gsub(" ", "-", tolower(Project.title)))
      url <- paste0("https://cu-dsi-scholars.github.io/DSI-scholars/", url.prefix, "/project-", title.lower)
      lines <- c(lines,
        paste0("<p>Thank you for submitting your project '", Project.title, "' to the DSI Scholars program Spring-Summer 2020. ",
               if (!self.funded) "We are pleased to inform you that we will be able to offer you a matching fund of up to $2,500 that will be used towards a stipend for one research intern who will work on your project. " else "",
               "All approved projects have been posted online at https://cu-dsi-scholars.github.io/DSI-scholars/.</p>"),
        paste0("<p>We have created a <a href='", url, "'>page</a> for your project based on information provided in your submission. The tags and clipart will be modified to suit your project accordingly. Please double check carefully all the information there and notify us if you'd like to make any changes. ",
               if (!studentAlreadySelected) "We plan to send an announcement about these projects this weekend. Changes can also be made after the announcement but we'd like to minimize the chance of any misunderstanding or confusion about your project." else "",
               "</p>"))
      
       if (studentAlreadySelected)
         lines <- c(lines,
           "<p>In your project submission, you have indicated that you have selected a student for your project. In order to provide a matching fund for this student, please send information with their name and UNI to dsi-scholars@columbia.edu. Furthermore, you can invite your selected student researcher to <a href='https://forms.gle/KoMWKrPtqNkobSPdA'>register</a> with the DSI Scholars Program. Your student researcher will then be able to participate in the intellectual activities organized by the DSI Scholars program (boot camp, weekly meetups and fall poster session).</p>")
       else
         lines <- c(lines,
           "<p>We have prepared an umbrella student application <a href='https://forms.gle/FirneensvXgZGE6HA'>website</a> for all DSI scholars projects that are open for application. Your project is listed on the application form. Applications to your project will be collected and passed on to you for review on February 1st, along with instructions on selecting a student.</p>")
     lines <- c(lines,
       "<p>Thank you for providing research experience to our students and we look forward to working with you and your student researchers.</p>")
    }
    lines <- c(lines, "<p>All the best,<br/>Vincent<br/><br/>--<br/>Vincent Dorie<br/> Associate Research Scientist, Data Science Institute<br/>Columbia University</p>")
    #print(lines)
    
    email <- gm_mime(to = as.character(Email.Address),
                     from = email.from,
                     replyto = email.replyto,
                     cc = email.cc,
                     subject = subject) %>%
                     gm_html_body(paste0(lines, collapse = "\n"), content_type = "text/html", charset = "utf-8")
    gm_create_draft(email)
  })
}


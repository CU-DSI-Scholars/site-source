# Creates project pages using a marked up version of the faculty submission form.

### VARIABLES TO UPDATE #####
data_dir  <- "data"
data_file <- "for_script.csv"
projects <- read.csv(file.path(data_dir, data_file))

output_path <- "content/post"

# logical TRUE/FALSE for whether or not to overwrite existing files
overwrite_existing <- TRUE

project_year <- "2022"
project_term <- c("Spring/Summer")

library(dplyr, quietly = FALSE)

projects %<>%
  mutate(funding = Are.you.applying.for.DSI.need.based..matching.stipend.funding..up.to..2500..) %>%
  mutate(funding = case_when(grepl("unpaid", funding)      ~ "unpaid",
                             grepl("own funding", funding) ~ "self",
                             TRUE ~ "matching"),
         student_selected = Do.you.have.a.student.selected.for.this.position.already. == "Yes",
         project_closed = student_selected | (Program %in% "DSI" & funding %in% "matching" & Decision == 0))

start_date_column <- colnames(projects)[startsWith(colnames(projects), "Earliest.starting.date.of.the.project.")]
semester_hours_column <- colnames(projects)[endsWith(colnames(projects), ".academic.semester")]
projects$Program <- as.character(projects$Program)

#rename the column names as needed----
projects$Student.Eligibility <- as.character(projects$Student.Eligibility)
projects$Required.skill.sets <- projects$Required.data.or.other.related.skill.sets.for.the.project..e.g...fluency.in.R.Python..experience.working.with.data.from.sensors.longitudinal.data.etc..methods.for.NLP.text.sentiment.analysis..
projects$project_description <- projects$Please.provide.a.brief..300.words.or.less..description.of.your.project..e.g...background.purpose..type.of.tasks.that.might.be.required.to.fulfill.study.aims..type.of.data.you.are.working.with..end.goal..any.other.details.that.might.be.relevant...
projects$Can.work.be.done.on.this.project.for.course.credit. <- projects$Can.work.be.done.on.this.project.for.course.credit..Please.note.that.since.this.option.requires.the.selected.scholar.to.register.for.Independent.Study.Research.

### VARIABLES END ###

for (i in seq_len(nrow(projects))) {
  with(projects[i,], {
    if (!(Program %in% c("DSI", "DFG"))) return(invisible(NULL))
    if (Program %in% "DSI" && student_selected && Decision == 0)
      return(invisible(NULL))
    
    title <- trimws(Project.title)
    if (endsWith(title, "."))
      title <- trimws(substr(title, 1, nchar(title) - 1))
    
    title_lowercase <- gsub("--", "-", gsub("[:,'?()]", "", gsub("[ /]", "-", tolower(title))))
    
    if (Program %in% "DFG") {
      title_lowercase <- paste0("dfg-", title_lowercase)
      title <- paste0("Data For Good: ", title)
    }
    
    outfile_name <- file.path(output_path, paste0(Sys.Date(), "-project-", title_lowercase, ".md"))
    if (file.exists(outfile_name) && !overwrite_existing)
      return(invisible(NULL))
    
    outfile <- file(outfile_name, open = "w")
    
    if (!exists("Project.timeline")) {
      duration <- 1L
    } else {
      duration <- which(sapply(project_term, function(term) grepl(term, Project.timeline)))
      if (Project.timeline == "Flexible")
        duration <- seq_along(project_term)
    }
    
    lines <- c("---",
               paste0("title: '", title, "'"),
               paste0("date: '", Sys.Date(), "'"),
               paste0("slug: project-", title_lowercase))
    
    categories <- 
      paste0(paste("  -", if (project_closed) "Closed" else "Open", project_term[duration], project_year), collapse = "\n")
    if (exists("Project.timeline") && grepl("Flexible", Project.timeline))
      categories <- paste(categories, "\n  -", if (project_closed) "Closed" else "Open", "Flexible Timeline")
    lines <- c(lines, paste0("categories:\n", categories))
    tags <-
      paste0(paste("  -", project_term[duration], project_year), collapse = "\n")
    if (Program %in% "DFG")
      tags <- paste0(tags, "  - Data For Good")
    
    lines <- c(lines, paste0("tags:\n", tags),
               "thumbnailImagePosition: left",
               "thumbnailImage: /Users/ipekensari/Documents/GitHub/site-source/static/img/construction.png",
               "---")
    lines <- c(lines,
      if (grepl("\n", project_description)) sub("\n", "\n\n<!--more-->\n\n", project_description) else paste0(project_description, "\n\n<!--more-->"))
    lines <- c(lines, "")
    
    if (Program %in% "DFG") {
      lines <- c(lines, "{{< alert info >}}\nThis is a volunteer opportunity for students to use their skills for the social good.\n{{< /alert >}}")
    } else {
      if (student_selected) {
        lines <- c(lines,
                   "{{< alert info >}}\nThis is project is NOT accepting applications.\n{{< /alert >}}")
      } else if (funding %in% "unpaid" || (funding %in% "matching" && Decision == 0)) {
        lines <- c(lines,
                   "{{< alert success >}}\nThis is an UNPAID research project.\n{{< /alert >}}")
      } else if (funding %in% "matching" && Decision == 1) {
        lines <- c(lines,
                   "{{< alert success >}}\nThis project is eligible for a matching fund stipend from the Data Science Institute. This is not a guarantee of payment, and the total amount is subject to available funding.\n{{< /alert >}}")
      } else if (funding %in% "self") {
        lines <- c(lines,
                   "{{< alert success >}}\nSelected candidate(s) can receive a stipend directly from the faculty advisor. This is not a guarantee of payment, and the total amount is subject to available funding.\n{{< /alert >}}")

      }
    }
    lines <- c(lines, "",
               "## Faculty Advisor",
               paste0("+ Professor: [", Faculty..Name., "](", Faculty.Center.Lab.website, ")"),
               paste0("+ Center/Lab: ", Department.Center.Name)
               )
    if (trimws(Center.Lab.Office.Location) != "")
      lines <- c(lines, paste0("+ Location: ", Center.Lab.Office.Location))
    if (trimws(Faculty.Center.Lab.research.profile..1.2.sentences.) != "")
      lines <- c(lines, paste0("+ ", trimws(Faculty.Center.Lab.research.profile..1.2.sentences.)))
    
    lines <- c(lines,
               "",
               "## Project Timeline",
               paste0("+ Earliest starting date: ", get(start_date_column)),
               paste0("+ End date: ", End.Date.of.Project))
    
    if (exists(semester_hours_column) && !is.na(hours_semester <- get(semester_hours_column)) && nzchar(hours_semester))
      lines <- c(lines, paste0("+ Number of hours per week of research expected during ", project_term[1L], " ", project_year, ": ~", hours_semester))
    hours_summer <- if (exists("Number.of.hours.per.week.of.work.required.for.the.project.during.the.summer"))
      Number.of.hours.per.week.of.work.required.for.the.project.during.the.summer else NA
    if (!is.na(hours_summer) && hours_summer != "")
      lines <- c(lines, paste0("+ Number of hours per week of research expected during Summer ", project_year, ": ~", hours_summer))
    
    lines <- c(lines,
               "",
               "## Candidate requirements",
               paste0("+ Skill sets: ", if (grepl("\n", Required.skill.sets)) paste0("\n  ", gsub("\n", "\n  ", Required.skill.sets)) else Required.skill.sets))
    studentYears <- c("Freshman", "Sophomore", "Junior", "Senior", "Master's")
    allowedYears <- sapply(strsplit(Student.Eligibility, ";")[[1]], trimws, USE.NAMES = FALSE)
    
    lines <- c(lines,
               paste0("+ Student eligibility: ", tolower(paste0(ifelse(studentYears %in% allowedYears, studentYears, paste0("~~", studentYears, "~~")), collapse = ", "))),
               paste0("+ International students on F1 or J1 visa: ",
                      if (Are.International.students.on.F1.or.J1.visa.eligible. == "Yes") "**eligible**" else "**NOT** eligible"))
    
    for_credit <- Can.work.be.done.on.this.project.for.course.credit.
    if (for_credit != "")
      lines <- c(lines, paste0("+ Academic Credit Possible: ", trimws(for_credit)))
    
    if (!is.na(Special.Requirements) && trimws(Special.Requirements) != "")
      lines <- c(lines, paste0("+ Additional comments: ", trimws(Special.Requirements)))
    lines <- c(lines, "")
  
    writeLines(lines, outfile)
    close(outfile)
  })
}



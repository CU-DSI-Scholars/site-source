projects <- read.csv("~/Documents/Data Science/Scholars/dsischolarsemailcodes/DSIScholarsEmails/projectinfo_spring_2020.csv", stringsAsFactors = FALSE)

repository <- "/Users/vdorie/Repositories/dsischolars/site-source/content/post"

for (i in seq_len(nrow(projects))) {
  with(projects[i,], {
    title.lower <- gsub(":|,|'|\\?", "", gsub(" ", "-", tolower(Project.title)))
    if (endsWith(title.lower, ".")) title.lower <- sub("\\.$", "", title.lower)
    fileName <- paste0(Sys.Date(), "-project-", title.lower, ".md")
    
    outfile <- file(file.path(repository, fileName), open = "w")
    if (file.exists(outfile)) next
   
    duration <- switch(Timing.of.project,
                       "Spring 2020 (March - May)" = 1L,
                       "Summer 2020 (June - August)" = 2L,
                       c(1L, 2L))
    
    lines <- c("---",
               paste0("title: '", Project.title, "'"),
               paste0("date: '", Sys.Date(), "'"),
               paste0("slug: project-", title.lower),
               "categories:", paste0(c("  - Project Spring 2020", "  - Project Summer 2020")[duration], collapse = "\n"),
               "tags:", paste0(c("  - Spring 2020", "  - Summer 2020")[duration], collapse = "\n"),
               "thumbnailImagePosition: left",
               "thumbnailImage: https://res.cloudinary.com/vdoriecu/image/upload/c_thumb,w_200,g_face/v1579110178/construction_c6dqbd.png",
               "---")
    lines <- c(lines,
      if (grepl("\n", Brief.project.description..200.words.or.less.)) sub("\n", "\n\n<!--more-->\n\n", Brief.project.description..200.words.or.less.) else paste0(Brief.project.description..200.words.or.less., "\n\n<!--more-->"))
    lines <- c(lines, "")
    
    if (Do.you.have.a.student.selected.for.this.position.already. == "Yes") {
      lines <- c(lines,
                 "{{< alert info >}}\nThis is project is NOT accepting applications.\n{{< /alert >}}")
    } else if (Are.you.applying.for.DSI.need.based.stipend.funding..up.to..2500.. == 
        "No, this will be an unpaid research project (for course credit or an unpaid learning experience).") {
      lines <- c(lines,
                 "{{< alert success >}}\nThis is an UNPAID research project.\n{{< /alert >}}")
    } else if (Are.you.applying.for.DSI.need.based.stipend.funding..up.to..2500.. == "Yes, I do not have enough funds for a full stipend.") {
      lines <- c(lines,
                 "{{< alert success >}}\nOne selected candidate will receive a stipend via the DSI Scholars program. Amount is subject to available funding.\n{{< /alert >}}")
      } else {
        lines <- c(lines,
                   "{{< alert success >}}\nSelected candidate(s) will receive a stipend directly from the faculty advisor. Amount is subject to available funding.\n{{< /alert >}}")
    }
    lines <- c(lines, "",
               "## Faculty Advisor",
               paste0("+ Professor: [", Faculty..Name., "](", Faculty.Center.Lab.website, ")"),
               paste0("+ Department/School: ", Department.School))
    if (trimws(Center.Lab.Office.Location) != "")
      lines <- c(lines, paste0("+ Location: ", Center.Lab.Office.Location))
    if (trimws(Faculty.Center.Lab.research.profile..1.2.sentences.) != "")
      lines <- c(lines, paste0("+ ", Faculty.Center.Lab.research.profile..1.2.sentences.))
    lines <- c(lines,
               "",
               "## Project Timeline",
               paste0("+ Earliest starting date: ", Earliest.starting.date.of.the.project..After.3.1.2020.),
               paste0("+ End date: ", End.Date.of.Project))
    hours <- Number.of.hours.per.week.of.work.required.during.the.project..academic.semester.Spring.
    if (!is.na(hours) && hours != "")
      lines <- c(lines, paste0("+ Number of hours per week of research expected during Spring 2020: ~", hours))
    hours <- Number.of.hours.per.week.of.work.required.during.the.project..Summer.
    if (!is.na(hours) && hours != "")
      lines <- c(lines, paste0("+ Number of hours per week of research expected during Summer 2020: ~", hours))
    lines <- c(lines,
               "",
               "## Candidate requirements",
               paste0("+ Skill sets: ", if (grepl("\n", Required.skill.sets)) paste0("\n  ", gsub("\n", "\n  ", Required.skill.sets)) else Required.skill.sets))
    studentYears <- c("Freshman", "Sophomore", "Junior", "Senior", "Master's")
    allowedYears <- sapply(strsplit(Student.Eligibility, ",")[[1]], trimws, USE.NAMES = FALSE)
    
    lines <- c(lines,
               paste0("+ Student eligibility: ", tolower(paste0(ifelse(studentYears %in% allowedYears, studentYears, paste0("~~", studentYears, "~~")), collapse = ", "))),
               paste0("+ International students on F1 or J1 visa: ",
                      if (Are.International.students.on.F1.or.J1.visa.eligible. == "Yes") "**eligible**" else "**NOT** eligible"))
  
    if (trimws(Special.Requirements) != "")
      lines <- c(lines, paste0("+ Additional comments: ", trimws(Special.Requirements)))
    lines <- c(lines, "")
  
    writeLines(lines, outfile)
    close(outfile)
  })
}


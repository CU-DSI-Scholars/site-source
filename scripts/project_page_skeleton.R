projects <- read.csv("~/Documents/Data Science/Scholars/dsischolarsemailcodes/DSIScholarsEmails/projectinfo_fall_2020.csv", stringsAsFactors = FALSE)

projects <- within(projects, {
  funding <- projects$Are.you.applying.for.DSI.need.based.stipend.funding..up.to..2500..
  funding <- ifelse(grepl("unpaid", funding), "unpaid", ifelse(grepl("own funding", funding), "self", "matching"))
  
  student_selected <- Do.you.have.a.student.selected.for.this.position.already. == "Yes"
})


repository <- "/Users/vdorie/Repositories/dsischolars/site-source/content/post"

for (i in seq_len(nrow(projects))) {
  with(projects[i,], {
    if (!(Program %in% c("DSI", "DFG"))) return(invisible(NULL))
    if (Program %in% "DSI" && student_selected && Decision == 0)
      return(invisible(NULL))
    
    title.lower <- gsub("--", "-", trimws(gsub(":|,|'|\\?", "", gsub(" ", "-", tolower(Project.title)))))
    if (endsWith(title.lower, ".")) title.lower <- sub("\\.$", "", title.lower)
    
    title <- Project.title
    
    if (Program %in% "DFG") {
      title.lower <- paste0("dfg-", title.lower)
      title <- paste0("Data For Good: ", title)
    }
    
    fileName <- paste0(Sys.Date(), "-project-", title.lower, ".md")
    
    outfileName <- file.path(repository, fileName)
    #if (file.exists(outfileName)) return(invisible(NULL))
    outfile <- file(outfileName, open = "w")
   
    lines <- c("---",
               paste0("title: '", title, "'"),
               paste0("date: '", Sys.Date(), "'"),
               paste0("slug: project-", title.lower),
               paste0("categories:\n  - ", if (!student_selected) "Open" else "Closed", " Projects Fall 2020"),
               paste0("tags:\n  - Fall 2020", if (Program %in% "DFG") "\n  - Data For Good" else ""),
               "thumbnailImagePosition: left",
               "thumbnailImage: https://res.cloudinary.com/vdoriecu/image/upload/c_thumb,w_200,g_face/v1579110178/construction_c6dqbd.png",
               "---")
    lines <- c(lines,
      if (grepl("\n", Brief.project.description..200.words.or.less.)) sub("\n", "\n\n<!--more-->\n\n", Brief.project.description..200.words.or.less.) else paste0(Brief.project.description..200.words.or.less., "\n\n<!--more-->"))
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
                   "{{< alert success >}}\nThis project is eligible for a matching fund stipend from the Data Science Institute. This not a guarantee of payment, and the total amount is subject to available funding.\n{{< /alert >}}")
      } else if (funding %in% "self") {
        lines <- c(lines,
                   "{{< alert success >}}\nSelected candidate(s) may receive a stipend directly from the faculty advisor. This not a guarantee of payment, and the total amount is subject to available funding.\n{{< /alert >}}")

      }
    }
    lines <- c(lines, "",
               "## Faculty Advisor",
               paste0("+ Professor: [", Faculty..Name., "](", Faculty.Center.Lab.website, ")"),
               paste0("+ Department/School: ", Department.School))
    if (trimws(Center.Lab.Office.Location) != "")
      lines <- c(lines, paste0("+ Location: ", Center.Lab.Office.Location))
    if (trimws(Faculty.Center.Lab.research.profile..1.2.sentences.) != "")
      lines <- c(lines, paste0("+ ", trimws(Faculty.Center.Lab.research.profile..1.2.sentences.)))
    lines <- c(lines,
               "",
               "## Project Timeline",
               paste0("+ Earliest starting date: ", Earliest.starting.date.of.the.project..After.10.1.2020.),
               paste0("+ End date: ", End.Date.of.Project))
    
    hours <- Number.of.hours.per.week.of.work.required.for.the.project.during.the.semester
    if (!is.na(hours) && hours != "")
      lines <- c(lines, paste0("+ Number of hours per week of research expected during Fall 2020: ~", hours))
    
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


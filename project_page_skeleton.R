projects <- read.csv("/Users/vdorie/Downloads/DSI Scholars Program (2019-2020) Research Project Faculty_Lab_Center Submission Form (Responses) - Form Responses 1.csv", stringsAsFactors = FALSE)

repository <- "/Users/vdorie/Repositories/dsischolars/site-source/content/post"

for (i in seq_len(nrow(projects))) {
  with(projects[i,], {
    title.lower <- gsub(":", "", gsub(" ", "-", tolower(Project.title)))
    if (endsWith(title.lower, ".")) title.lower <- sub("\\.$", "", Project.title)
    fileName <- paste0(Sys.Date(), "-project-", title.lower, ".md")
    
    outfile <- file(file.path(repository, fileName), open = "w")
    
    lines <- c("---",
               paste0("title: '", Project.title, "'"),
               paste0("date: '", Sys.Date(), "'"),
               paste0("slug: project-", title.lower),
               "categories:",
               "  - Project Fall 2019",
               "tags:",
               " - Fall 2019",
               "thumbnailImagePosition: left",
               "thumbnailImage: //res.cloudinary.com/tz33cu/image/upload/c_thumb,w_200,g_face/v1547675604/2000px-Capsule__ge%CC%81lule.svg_spzxwr.png",
               "---")
    lines <- c(lines,
      if (grepl("\n", Brief.project.description..200.words.or.less.)) sub("\n", "\n\n<!--more-->\n\n", Brief.project.description..200.words.or.less.) else paste0(Brief.project.description..200.words.or.less., "\n\n<!--more-->"))
    lines <- c(lines, "")
    
    if (Are.you.applying.for.DSI.need.based.stipend.funding..up.to..2500.. == 
        "No, this will be an unpaid research project (for course credit or an unpaid learning experience).") {
      lines <- c(lines,
                 "{{< alert success >}}\nThis is an UNPAID research project.\n{{< /alert >}}")
    } else if (Are.you.applying.for.DSI.need.based.stipend.funding..up.to..2500.. == "Yes, I do not have enough funds for a full stipend.") {
      lines <- c(lines,
                 "{{< alert success >}}\nOne selected candidate will receive a stipend via the DSI Scholars program. Amount is subject to available funding.\n{{< /alert >}}")
      } else {
      lines <- c(lines,
               "Selected candidate(s) will receive a stipend directly from the faculty advisor. Amount is subject to available funding.")
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
               paste0("+ Earliest starting date: ", Earliest.starting.date.of.the.project..After.10.15.2019.),
               paste0("+ End date: 05/31/2019: ", End.Date.of.Project),
               paste0("+ Number of hours per week of research expected during Fall 2019: ~", Number.of.hours.per.week.of.work.required.during.the.project..academic.semesters.),
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
      lines <- c(lines, "+ Additional comments: ", trimws(Special.Requirements))
  
    writeLines(lines, outfile)
    close(outfile)
  })
}


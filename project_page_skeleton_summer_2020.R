projects <- read.csv("~/Documents/Data Science/Scholars/dsischolarsemailcodes/DSIScholarsEmails/projectinfo_summer_2020.csv", stringsAsFactors = FALSE)

repository <- "/Users/vdorie/Repositories/dsischolars/site-source/content/post"

trimNA <- function(x) if (is.na(x)) "" else trimws(x)

#for (i in seq_len(nrow(projects))) {
for (i in seq.int(1L, nrow(projects))) {
  with(projects[i,], {
    skip <- DSI.Scholars == "None"
    if (skip) return(invisible(NULL))
    
    title.lower <- trimNA(gsub(":|,|'|\\?", "", gsub(" ", "-", tolower(Project.title))))
    if (endsWith(title.lower, ".")) title.lower <- sub("\\.$", "", title.lower)
    
    fileName <- paste0(Sys.Date(), "-project-", title.lower, ".md")
    
    outfileName <- file.path(repository, fileName)
    if (file.exists(outfileName)) return(invisible(NULL))
    outfile <- file(outfileName, open = "w")
    
    lines <- c("---",
               paste0("title: '", Project.title, "'"),
               paste0("date: '", Sys.Date(), "'"),
               paste0("slug: project-", title.lower),
               "categories:", "  - Project Summer 2020",
               "tags:", "  - Summer 2020",
               "thumbnailImagePosition: left",
               "thumbnailImage: https://res.cloudinary.com/vdoriecu/image/upload/c_thumb,w_200,g_face/v1579110178/construction_c6dqbd.png",
               "---")
    
    description <- trimNA(Brief.description.of.the.project.content)
    
    lines <- c(lines,
      if (grepl("\n", description)) sub("\n", "\n\n<!--more-->\n\n", description) else paste0(description, "\n\n<!--more-->"))
    lines <- c(lines, "")
    
    outcome <- trimNA(Desired.outcome.from.Data.Science.Institute.talent)
    if (outcome != "")
      lines <- c(lines, "## Outcome", "", outcome, "")
    learning <- trimNA(Learning.Opportunity.for.DSI.talent.who.are.students)
    if (learning != "")
      lines <- c(lines, "## Learning opportunity", "", learning, "")
    
    self.funded <- grepl("yes", Paid.funded.opportunity., ignore.case = TRUE)
    dsi.funded  <- grepl("post funded", Scholars.post, ignore.case = TRUE)
    dfg         <- grepl("dfg", Scholars.post, ignore.case = TRUE)
    if (self.funded) {
      lines <- c(lines,
                   "{{< alert success >}}\nSelected candidate(s) may receive a stipend directly from the faculty advisor. Amount is subject to available funding.\n{{< /alert >}}")
    } else if (dsi.funded) {
      lines <- c(lines,
                 "{{< alert success >}}\nOne selected candidate may receive a stipend via the DSI Scholars program. Amount is subject to available funding.\n{{< /alert >}}")
    } else if (dfg) {
      lines <- c(lines,
                 "{{< alert success >}}
The Data For Good program is designed primarily for volunteers, however one candidate will be selected as a project coordinator and will receive a stipend via the Data For Good Scholars program. In addition to the responsibilities of a team member, the selected candidate will be responsible for keeping up-to-date notes on the project's status, writing an end-of-period report, and attending bi-weekly meetings with a DFG program director. The project coordinator should strive to keep the group of volunteers in sync with the needs of the project owner.
{{< /alert >}}")
    } else {
      lines <- c(lines, "{{< alert success >}}\nThis is an UNPAID research project.\n{{< /alert >}}")
    }
    
    lines <- c(lines, "",
               "## Faculty Advisor",
               paste0("+ Professor: ", if (trimNA(URL.to.Lab.Research) == "") Name else paste0("[", Name, "](", URL.to.Lab.Research, ")")),
               paste0("+ Department/School: ", School.Department))
    if (trimNA(Location) != "")
      lines <- c(lines, paste0("+ Location: ", Location))
    
    workload <- trimNA(Anticipated.workload.and.duration.of.this.project...e.g...5.hr.week.for.10.weeks.)
    duration <- trimNA(What.is.the.anticipated.project.research.timeline..and.how.much.time.effort.do.you.think.you.would.need.from.a.collaborator.)
    
    lines <- c(lines,
               "",
               "## Project Timeline",
               if (workload != "") paste0("+ Anticipated workload: ", workload) else NULL,
               if (duration != "") paste0("+ Duration: ", duration) else NULL)
    
    
    qualifications <- trimNA(Desired.technical.nontechnical.skills.)
    domain.knowledge <- trimNA(Required.domain.knowledge..if.necessary)
    
    sublist <- function(x) if (grepl("\n", x)) paste0("\n  ", gsub("\n", "\n  ", x)) else x
    
    lines <- c(lines, "")
    if (qualifications != "" || domain.knowledge != "") {
      lines <- c(lines, "## Candidate requirements",
                 if (qualifications != "") paste0("+ Skills required: ", sublist(qualifications)) else NULL,
                 if (domain.knowledge != "") paste0("+ Additional domain knowledge: ", sublist(domain.knowledge)) else NULL)
    }    
   
    studentYears <- c("Freshman", "Sophomore", "Junior", "Senior", "Master's")
    if (Minimum.level.of.expertise == "MS") allowedYears <- studentYears[5]
    else allowedYears <- studentYears
    # allowedYears <- sapply(strsplit(Student.Eligibility, ",")[[1]], trimNA, USE.NAMES = FALSE)
    
    lines <- c(lines,
               paste0("+ Student eligibility: ", tolower(paste0(ifelse(studentYears %in% allowedYears, studentYears, paste0("~~", studentYears, "~~")), collapse = ", "))))
  
    additional.reqs <- trimNA(Any.additional.requirements.for.talent.)
    if (additional.reqs != "")
      lines <- c(lines, paste0("+ Additional comments: ", additional.reqs))
    lines <- c(lines, "")
  
    writeLines(lines, outfile)
    close(outfile)
  })
}


# Problem Statement — The Open Source Audit
**Course:** Open Source Software (OSS NGMC)  
**Max Marks:** 100  
**Submission:** VITyarthi Portal

---

## Overview

You must conduct a structured audit of **one real open-source software project** and demonstrate practical Linux shell scripting skills. The project has two deliverables:

1. **A written report** (12–16 pages, 60 marks) covering origin, philosophy, Linux footprint, ecosystem, and comparison with proprietary alternatives.
2. **Five shell scripts** (40 marks, 8 marks each) that demonstrate Linux command-line and shell scripting skills.

---

## Chosen Software

**Git** (Version Control System) — License: GPL v2  
*Chosen because Linus Torvalds built Git when a proprietary tool failed him — a perfect narrative for an OSS audit.*

---

## Report Structure (60 Marks)

### Part A — Origin and Philosophy (Units 1 & 2) | 34 marks
- **A1** (12 marks): Origin story — the problem Git solved, why Torvalds built and open-sourced it
- **A2** (12 marks): License analysis — GPL v2, the four freedoms, copyleft mechanics
- **A3** (10 marks): Ethical reflection — arguments for/against mandatory open source, corporate use of free labor

### Part B — Linux Footprint (Unit 2) | 10 marks
- Installation method (apt/rpm), key directories, user/group, service management, update model

### Part C — FOSS Ecosystem (Units 3 & 4) | 8 marks
- Dependencies, what Git enabled (GitHub, GitLab, Gitea), LAMP connection, community governance

### Part D — Open Source vs Proprietary (Critical Analysis) | 8 marks
- Comparison table: Git vs. Perforce/BitKeeper across cost, security, support, freedom, control
- Two-paragraph verdict on real-world deployment

---

## Shell Scripts (40 Marks)

| # | Script Name | Key Concepts | Marks |
|---|-------------|-------------|-------|
| 1 | System Identity Report | variables, echo, command substitution `$()` | 8 |
| 2 | FOSS Package Inspector | if-else, case statement, rpm/dpkg, grep | 8 |
| 3 | Disk and Permission Auditor | for loop, df, ls -ld, awk/cut | 8 |
| 4 | Log File Analyzer | while-read loop, if-then, counters, `$1` args | 8 |
| 5 | Open Source Manifesto Generator | read input, string concat, file write, date | 8 |

Each script must:
- Run without errors on a real Linux system
- Include comments on every non-obvious line
- Use the correct shell constructs for the task
- Be submitted as a plain `.sh` file

---

## Submission Requirements

| Item | Details | Compulsory |
|------|---------|------------|
| GitHub Repo (Public) | Named `oss-audit-[rollnumber]`, contains all 5 `.sh` files + `README.md` | ✅ Yes |
| README.md | Student name, roll number, chosen software, script descriptions, run instructions, dependencies | ✅ Yes |
| Project Report PDF | 12–16 pages, your own words, uploaded on VITyarthi | ✅ Yes |

**Repository URL format:** `https://github.com/{github-username}/{repo-name}`  
Do NOT submit URLs containing `/tree/main/` or `/blob/`.

---

## Evaluation Rubric

### Report (60 marks)
| Component | Marks |
|-----------|-------|
| A1 — Origin story depth and original research | 12 |
| A2 — License analysis accuracy | 12 |
| A3 — Ethical reflection quality | 10 |
| B — Linux footprint + screenshots | 10 |
| C — Ecosystem and LAMP connection | 8 |
| D — OSS vs proprietary comparison | 8 |

### Scripts (40 marks — 8 each)
| Criterion | Marks |
|-----------|-------|
| Correctness — runs without errors | 4 |
| Concepts — right shell constructs used | 2 |
| Comments and documentation | 2 |

---

## Academic Integrity Warnings

- **Plagiarism detection** runs on all submissions. >40% similarity → disciplinary action.
- **AI generation detection** runs on the report. Flagged students face a mandatory viva.
- You MAY use AI to understand concepts or debug scripts. You may NOT use AI to write the report.
- Scripts copy-pasted without understanding → zero marks.

---

## Key References

- GNU Free Software Definition: https://gnu.org/philosophy/free-sw.html
- Open Source Initiative OSD: https://opensource.org/osd
- Eric S. Raymond — "The Cathedral and the Bazaar": https://catb.org/~esr/writings/cathedral-bazaar
- The Linux Command Line (free): https://linuxcommand.org
- GNU Bash Manual: https://gnu.org/software/bash/manual
- SPDX License List: https://spdx.org/licenses
- Git official site: https://git-scm.com

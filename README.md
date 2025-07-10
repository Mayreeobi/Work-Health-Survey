# Work-Health-Survey (SQL Project)

### Workplace Wellness & Burnout Analysis (End-to-End SQL Project | June 2025)
A comprehensive SQL-based analysis of workplace mental health, burnout, and work-life balance using data from a health survey conducted between June 1st – June 26th, 2025. This project explores respondent demographics, regional and gender-based burnout patterns, and weekday trends in employee wellness.

### Project Structure
- 📂 workhealth-survey-analysis
- │
- ├── 📄 README.md
- ├── 📄 WorkHealthSurvey_Analysis.sql      ←   SQL queries for all analyses
- ├── 📊 Dashboard                          ←   Tableau
- └── 📁 data/
    - └── workhealth_survey_sample.csv      ←    Dataset 
      
- 🔗  [SQL Script Here](https://github.com/Mayreeobi/Work-Health-Survey/blob/main/2025%20Work%20Health%20Survey.sql)
- 🔗  [Dataset on Kaggle](https://www.kaggle.com/datasets/kshitijsaini121/remote-work-of-health-impact-survey-june-2025/data)

### Objectives
- Analyze survey participation and demographic distribution
- Assess mental and physical health patterns
- Explore burnout rates by job roles, gender, and weekday
- Evaluate work-life balance and social isolation metrics
- Identify wellness trends across weekdays for time-based insights

### 🛠️ Tools Used
- SQL Server (Primary database engine)
- Power BI / Tableau (For dashboard development)
- Excel/CSV (For data import/export)

### 📦 Dataset Overview
| Column Name | Description |
|---|---|
| **Age** | Age of respondent |
| **Gender** | Gender identity |
| **Region** | Geographic region |
| **Industry** | Industry sector |
| **Job_Role** | Role/title in organization |
| **Work_Arrangement** | Onsite / Remote / Hybrid |
| **Hours_Per_Week** | Weekly work hours |
| **Mental_Health_Status** | Reported mental health condition |
| **Burnout_Level** | Burnout severity (Low, Medium, High) |
| **Work_Life_Balance_Score** | Subjective score (1–5) |
| **Physical_Health_Issues** | Reported physical health issues |
| **Social_Isolation_Score** | Subjective isolation score (1–5) |
| **Salary_Range** | Salary bracket |
| **Weekday** | Day of the week (derived from date) |

### 🔍 Key Analysis Sections using SQL
- ✅ Descriptive Stats: * Total respondent count * Age and gender distribution * Region-based participation
- 🧠 Health & Burnout Metrics: * Burnout levels by job role and gender * Distribution of mental and physical health issues * Average work-life balance and isolation scores
- 🗓️ Time-Based Trend Analysis: * Daily trends (June 1–26) in participation, burnout, and well-being * Weekday patterns (Monday to Sunday)


### 🚀 How to Use
1. Clone the repository: 
       -  [git clone](https://github.com/yourusername/workhealth-survey-analysis.git)
2. Import the dataset (workhealth_survey_sample.csv) into your SQL Server.
3. Run the SQL script: WorkHealthSurvey_Analysis.sql
4. Visualize insights using Tableau/Power BI (optional).



📄 License
This project is open-source and available under the MIT License.

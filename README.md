# 🎬 Netflix Content Analysis using SQL

## 📌 Project Overview

This project analyzes Netflix's global content catalog using SQL to uncover insights about content production, audience targeting, genre distribution, and platform growth.

Using a structured dataset of Netflix Movies and TV Shows, the analysis answers multiple business questions such as:

* Which countries produce the most Netflix content?
* What genres dominate the platform?
* How has Netflix's content library grown over time?
* What audience segments does Netflix primarily serve?
* Which directors could be strong candidates for long-term partnerships?

The goal of this project is to demonstrate **SQL-based data exploration, analytical thinking, and business insight generation**.

---

# 🗂 Dataset Description

The dataset contains metadata about Netflix titles.

| Column       | Description                              |
| ------------ | ---------------------------------------- |
| show_id      | Unique identifier for each title         |
| type         | Movie or TV Show                         |
| title        | Name of the content                      |
| director     | Director of the title                    |
| casts        | Actors appearing in the title            |
| country      | Country of production                    |
| date_added   | Date the title was added to Netflix      |
| release_year | Year the content was originally released |
| rating       | Audience maturity rating                 |
| duration     | Length of movie or number of seasons     |
| listed_in    | Genres/categories                        |
| description  | Short description of the title           |

---

# 🛠 Tools & Techniques Used

* SQL (PostgreSQL style queries)
* Common Table Expressions (CTEs)
* Window Functions
* Aggregations
* String Splitting & Data Transformation
* Ranking & Trend Analysis

---

# 📊 Business Questions & Insights

---

# 1️⃣ Country-wise Total Netflix Titles

### Question

Which countries produce the highest number of titles available on Netflix?

### Insight

This analysis identifies the countries that contribute the most content to Netflix's global catalog. Countries like the **United States and India dominate the platform**, reflecting their large entertainment industries and high production capacity.

---

# 2️⃣ Country Contribution by Release Year

### Question

How many titles were released each year from different countries?

### Insight

This analysis shows how content production from each country has evolved over time. It highlights **global expansion trends** and reveals how Netflix increasingly sources content from international markets.

---

# 3️⃣ Top Content Producing Country Each Year

### Question

Which country produced the highest number of Netflix titles in each year?

### Insight

This analysis identifies the **leading content-producing country for each year**. It helps track shifts in production leadership and highlights how Netflix’s catalog has diversified geographically over time.

---

# 4️⃣ Country-wise Movies vs TV Shows

### Question

What is the distribution of Movies and TV Shows across different countries?

### Insight

This query highlights how different countries specialize in content types. Some regions focus heavily on **movies**, while others produce a larger share of **TV series**, reflecting different industry structures.

---

# 5️⃣ Most Recent Release Year by Country

### Question

What is the most recent release year of Netflix titles for each country?

### Insight

This analysis identifies **countries that are currently active contributors** to Netflix's catalog and helps detect emerging production markets.

---

# 6️⃣ Emerging Content Markets

### Question

Which countries have produced fewer than 40 titles but still have recent Netflix releases?

### Insight

These countries represent **emerging content markets**. Although they currently contribute fewer titles, their recent activity suggests **growing participation in the global streaming industry**.

---

# 7️⃣ Most Common Rating for Movies and TV Shows

### Question

What is the most frequent audience rating for Movies and TV Shows?

### Insight

The analysis reveals that **TV-MA is the most common rating**, indicating that Netflix heavily focuses on **content for mature audiences**, including adult dramas, thrillers, and crime series.

---

# 8️⃣ Overall Netflix Library Snapshot

### Question

What does the Netflix library look like at a glance?

### Insight

This query provides a high-level overview of Netflix’s catalog including:

* Total number of titles
* Movies vs TV Shows distribution
* Number of countries represented
* Total unique directors
* Oldest and newest content

This gives a **quick snapshot of the platform’s scale and diversity**.

---

# 9️⃣ Year-on-Year Growth of Netflix Content

### Question

How has Netflix's content library grown over time?

### Insight

The results typically show **rapid growth after 2015**, reflecting Netflix’s aggressive investment in **original content and global expansion strategy**.

---

# 🔟 Genre Breakdown

### Question

Which genres dominate Netflix's platform?

### Insight

Genres such as **International Movies, Dramas, and Comedies** dominate the catalog, highlighting Netflix’s focus on globally appealing storytelling.

---

# 1️⃣1️⃣ Audience Rating Distribution

### Question

What audience segments is Netflix primarily serving?

### Insight

The analysis categorizes ratings into Kids, Family/Teens, and Adults. The results show that **adult-oriented content forms the largest portion of the library**, reinforcing Netflix’s positioning as a mature streaming platform.

---

# 1️⃣2️⃣ Audience Mismatch by Country

### Question

Are there countries where Netflix's adult content is disproportionately high?

### Insight

Countries where adult content exceeds **50% of the catalog** may face **higher subscriber churn if audiences prefer family-friendly content**. This insight can guide regional content commissioning strategies.

---

# 1️⃣3️⃣ Best Month to Release Content

### Question

Which months does Netflix add the most content?

### Insight

Months with the highest content additions tend to attract more viewer browsing activity. Releasing major titles during these months can **increase visibility and engagement**.

---

# 1️⃣4️⃣ TV Show Season Strategy

### Question

Do Netflix TV shows typically run for multiple seasons?

### Insight

If the majority of shows have only **one season**, it suggests a pattern of **fast cancellations**. Multi-season shows, while more expensive, can help build stronger viewer loyalty.

---

# 1️⃣5️⃣ Top Directors for Potential Partnerships

### Question

Which directors have the highest partnership potential with Netflix?

### Insight

Directors are evaluated using a scoring system based on:

* Number of titles
* Career longevity
* Genre diversity
* Country reach
* TV show involvement

This helps identify **high-value creators who could be ideal candidates for exclusive partnerships or production deals**.

---

# 1️⃣6️⃣ Genre Investment Efficiency

### Question

Which genres provide the most content output per year of investment?

### Insight

Genres with high **titles-per-year ratios** represent **high-return content categories**. These are classified as:

* Core Genres (high ROI)
* Growing Genres (worth scaling)
* Niche Genres (specialized content)

This analysis helps guide **content investment strategy**.

---

# 🚀 Key Skills Demonstrated

* SQL Data Analysis
* Business Intelligence
* Window Functions
* Data Cleaning & Transformation
* Analytical Problem Solving
* Insight Generation for Business Strategy

---

# 📈 Potential Future Improvements

* Interactive dashboards using **Power BI or Tableau**
* Content recommendation analysis
* Subscriber growth correlation with content releases
* Genre popularity forecasting using machine learning

---

⭐ If you found this project interesting, feel free to fork or contribute!

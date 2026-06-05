
# NUTRISCAN - Food Health Intelligence

> **Scan any packaged food. Get an instant A–F health rating.**
> Built by [Shreya Chauhan](https://www.linkedin.com/in/shreya-chauhan-04) 

<br>


## The Headline Finding

> **68.7% of products marketed as 'healthy', 'natural', or 'high protein' score C or below on independent nutrition criteria.**
>
> Out of 20,999 products with health claims - **14,431 fail** basic nutritional standards.

This is the problem NutriScan was built to solve.

---

## The Problem

Walk into any supermarket. Pick up a product that says **"Natural"**, **"High Protein"**, or **"Multigrain"** on the front.

Now flip it over and read the nutrition label.

Most people don't - and brands know this.

Nutrition labels are:
- Confusing (kJ vs kcal, % daily values, per serving vs per 100g)
- Deliberately designed to obscure bad ingredients
- Never compared against a simple, honest rating

There is no quick, trustworthy way for a consumer to know-  **at the moment they're standing in a store - whether a product is actually good for them.**

That's the gap NutriScan fills.

---

## The Solution

NutriScan scans a barcode (or searches a product name) and returns:

- An **A–F health grade** based on sugar, fat, saturated fat, sodium, protein and fibre
- A **protein level rating** — High / Moderate / Low (based on grams per 100 kcal, not just per 100g)
- A **full nutrition breakdown** with colour-coded bars
- **Allergen detection** across 11 major allergens
- A **"why this rating"** explanation

No logging. No calorie counting. Just scan and know.

---

## How the Scoring Works

NutriScan uses a **penalty-based scoring system** applied per 100g:

| Nutrient | Good | Moderate | High | Very High |
|---|---|---|---|---|
| Sugar | < 5g | 5–10g | 10–20g | > 20g |
| Saturated Fat | < 1.5g | 1.5–3g | 3–5g | > 5g |
| Total Fat | < 3g | 3–10g | 10–17.5g | > 17.5g |
| Sodium | < 120mg | 120–300mg | 300–400mg | > 400mg |

**Bonuses** reduce the penalty score for high protein (>10g) and high fibre (>3g).

| Final Score | Grade | Meaning |
|---|---|---|
| 0–9 | **A** | Excellent — eat freely |
| 10–21 | **B** | Good — mostly healthy |
| 22–37 | **C** | Fair — consume moderately |
| 38–54 | **D** | Poor — limit intake |
| 55–71 | **E** | Very Poor — occasional only |
| 72–100 | **F** | Avoid — high concern |

**Protein Level Definition:**
- 🟢 **High** = ≥ 10g protein per 100 kcal
- 🟡 **Moderate** = 5–9.9g protein per 100 kcal
- 🔴 **Low** = < 5g protein per 100 kcal

*This matters because a product can have 20g protein per 100g but 600 kcal - that's not a high-protein food. NutriScan corrects for this.*

---

## Key Findings from the Data

Analysis of **242,607 globally available packaged food products** (Open Food Facts, ODbL licence):

### Finding 1 — The Healthy Halo Effect
**68.7% of products with health claims score C or below.**
Brands use words like "natural", "protein", "organic", and "diet" on packaging — but the nutrition data tells a different story. Over two-thirds of these products fail independent NutriScan criteria.

### Finding 2 — The Market Is Dominated by Poor Products
| Grade | Products | % of Total |
|---|---|---|
| A | 30,927 | 12.7% |
| B | 18,594 | 7.7% |
| C | 26,214 | 10.8% |
| D | 24,711 | 10.2% |
| E | 39,384 | 16.2% |
| **F** | **102,777** | **42.4%** |

42.4% of all analysed products score F. Only 20.4% score A or B.

### Finding 3 — Sugar Is the Biggest Driver
Average sugar content rises 16x between Grade A and Grade E products:

| Grade | Avg Sugar | Avg Fat | Avg Protein |
|---|---|---|---|
| A | 1.8g | 1.6g | 7.1g |
| B | 5.2g | 1.9g | 3.9g |
| C | 7.0g | 4.4g | 5.5g |
| D | 5.0g | 8.5g | 10.1g |
| E | 28.9g | 6.8g | 5.4g |
| F | 20.2g | 24.3g | 8.7g |

### Finding 4 — Protein Alone Doesn't Mean Healthy
Grade D products average more protein (10.1g) than Grade C products (5.5g) — proving that single-nutrient marketing like "high protein" can mask poor overall nutrition. NutriScan's multi-factor scoring catches this.

### Finding 5 — The Data Gap Problem
No open, comprehensive Indian packaged food barcode database exists. GS1 India's DataKart is closed and B2B only. Open Food Facts has limited Indian coverage. **This data infrastructure gap is itself a core problem NutriScan addresses** — and a regulatory opportunity for FSSAI to mandate structured nutrition data at the product listing level.

---

## What I Built

### 1. Live Prototype
A working web app that queries the Open Food Facts API in real time.
Search by product name or barcode → instant A–F grade, protein level, nutrient breakdown, allergens.

### 2. Data Pipeline
- Source: Open Food Facts (242,607 products)
- Cleaned in Python (Google Colab): removed nulls, fixed units (kJ→kcal), removed impossible values, deduplicated
- Applied NutriScan scoring algorithm across entire dataset
- Detected allergens from ingredient text using pattern matching
- Flagged health claim products using 14 marketing keywords

### 3. SQL Analysis
8 queries across grade distribution, brand scorecards, healthy halo detection, protein analysis, and allergen prevalence — run in DB Browser for SQLite.

### 4. Tableau Dashboard
Three-page interactive dashboard: Market Overview, Healthy Halo Analysis, Product Explorer.


### 5. Product Requirements Document
Full PRD including problem statement, user personas, user journey, scoring framework, competitive analysis vs Yuka/HealthifyMe/MyFitnessPal, KPIs, and 4-phase product roadmap.


---

## Repository Structure

```
nutriscan/
├── index.html                      ← Live prototype (Open Food Facts API)
├── README.md                       ← This file
├── data/
│   ├── nutriscan_clean.csv.zip     ← Cleaned dataset (242,607 products)
│   ├── nutriscan_queries.sql       ← All 8 SQL analysis queries
│   └── data_notes.md              ← Data source, methodology & limitations
├── docs/
│   └── NutriScan_PRD_v2.pdf       ← Full Product Requirements Document
└── notebook/
    └── NutriScan_Cleaning.ipynb   ← Python data cleaning pipeline (Colab)
```

---

## Skills Demonstrated

| Area | What I did |
|---|---|
| **Product Thinking** | Identified the problem, defined user personas, wrote PRD, designed scoring framework, built 4-phase roadmap |
| **Data Analysis** | Cleaned 242,607-row dataset in Python, applied scoring algorithm, generated 5 key business insights |
| **SQL** | 8 queries covering distribution analysis, brand scorecards, healthy halo detection, correlation analysis |
| **Visualisation** | 3-page Tableau dashboard with interactive filters, published to Tableau Public |
| **Prototyping** | Working HTML app with live API integration, allergen detection, real-time grading |
| **Business Communication** | Translated data findings into a business case — market gap, regulatory insight, go-to-market implication |

---

## Product Roadmap

| Phase | Focus | Key Features |
|---|---|---|
| **Phase 1 — MVP** | Core scanning | Barcode scan, A–F grade, basic nutrients |
| **Phase 2 — Engagement** | Personalisation | Scan history, weekly health score, allergen profile |
| **Phase 3 — Intelligence** | AI layer | Alternative product suggestions, store-specific recommendations |
| **Phase 4 — Platform** | B2B | Brand analytics API, FSSAI data partnership, white-label for retailers |

---

## Competitive Landscape

| Feature | NutriScan | Yuka | MyFitnessPal | HealthifyMe |
|---|---|---|---|---|
| A–F instant grade | ✅ | ✅ colour score | ❌ | ❌ |
| Protein per 100 kcal | ✅ | ❌ | ❌ | ❌ |
| Allergen detection | ✅ | ✅ | ❌ | ❌ |
| Scan history | ✅ | ✅ | ✅ | ✅ |
| No account needed | ✅ | ❌ | ❌ | ❌ |
| Indian product focus | 🔄 | ❌ | ❌ | ✅ |
| Data error rate | Low (label-sourced) | Low | 23% (crowdsourced) | Unknown |

**NutriScan's unique angle:** Unlike MyFitnessPal (calorie logging) and HealthifyMe (home-cooked food), NutriScan is designed for the **point-of-purchase decision** — standing in a store, deciding in 5 seconds.

---

*Data source: Open Food Facts (world.openfoodfacts.org) — Open Database Licence (ODbL)*
*NutriScan is a portfolio project and is not affiliated with any food brand or regulatory body.*
No logging. No calorie counting. Just scan and know.


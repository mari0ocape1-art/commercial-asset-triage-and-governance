# Capital Conversion Dynamics: An Information-Theoretic and Dynamic Systems Framework for Bank Portfolio Governance

## Interactive Dashboard
👉 [**Click here to view the Interactive Dashboard on Tableau Public**](https://public.tableau.com/app/profile/mario.alberto.p.rez.ocampo/viz/CommercialAssetTriageandGovernance/LeadTriage)

---

## Project Overview
This repository delivers an executive, end-to-end analytics framework designed to model and optimize how customer attributes within a banking portfolio drive capital conversion. The core objective is to isolate high-affinity customer vectors toward financial asset adoption by transitioning from legacy demographic profiling to data-validated behavioral pillars.

The pipeline utilizes historical campaign records from the Bank of Portugal. Throughout the initial ingestion phase, strict analytical integrity was maintained to isolate and address statistical outliers, preserving distribution robustness. To bridge exploratory data analysis with institutional strategy, core business questions were established to optimize marketing allocation, solving key queries natively during the **Feature Engineering** phase.

Due to the heterogeneous and non-linear nature of the data, **Shannon's Mutual Information** theory was deployed as a primary information-theoretic filter. This probabilistic framework quantified feature interactions in units of information (bits), mapping non-linear synergies and systematically discarding socio-demographic noise that failed to yield a significant reduction in systemic uncertainty. 

Downstream data structures and the validity of the 13 advanced **SQL queries** were rigorously certified through **Non-Parametric Hypothesis Testing**. Leveraging these statistically validated feature weights, an automated propensity-scoring model was engineered within **Tableau**. This governance cockpit enables dynamic portfolio triage, ranking customer clusters by explicit conversion velocity and proving that historical relationship loyalty operates as a primary mathematical predictor for asset adoption.

---

## Repository Structure
The project workflow is structured into independent, modular environments to ensure institutional governance and scalability:
*   `data/`: Contains the baseline datasets utilized across the data pipeline (raw, cleaned, and final system outputs).
*   `notebooks/`: Houses `capital_conversion_dynamics.ipynb`, the core pipeline covering feature engineering, statistical filtering, Shannon information-theory metrics, and non-parametric hypothesis testing. *(Note: Relational SQL queries are fully integrated within this environment to enrich technical discussion and data-triage documentation).*
*   `sql/`: Stores `portfolio_governance_queries.sql`, a high-performance relational script containing 13 advanced business queries, analytical metrics, and window functions used for initial scenario validation.
*   `tableau/`: Stores the `.twbx` workbook containing the final corporate dashboard layout.

---

## Core Methodology & Analytical Phases
1. **Scenario Validation via Relational Triage (SQL):** Isolation of baseline metrics across 13 distinct business dimensions to measure initial operational conversion rates and identify resource misallocation gaps.
2. **Advanced Analytics & Information Theory (Python):** 
   * Implementation of **Feature Engineering** to craft custom indicators (e.g., `debt_index`, `previous_success`).
   * Evaluation of information density and non-linear feature relationships utilizing **Shannon's Information Theory** (Mutual Information).
   * Statistical validation of core performance gaps using **Non-Parametric Hypothesis Testing** to systematically filter out demographic noise from business signals.
3. **Data Visualization & Workforce Optimization (Tableau):** Development of a governance dashboard mapping capital conversion dynamics, resource saturation points, risk sensitivities, and call center behavioral thresholds.

---

## Key Insights & Strategic Conclusions

<details>
<summary><b>Operational Governance & Demographics</b></summary>

An exhaustive investigation into the bank's customer base reveals that traditional socio-demographic indicators operate heavily as structural background noise rather than conversion catalysts. Information-theoretic mapping proves that individual education levels, customer marital status, and raw continuous age ranges capture negligible mutual information, providing zero statistical variance in final product adoption. 

Enforcing telemarketing campaigns based on these legacy segments triggers acute resource misallocation; for instance, the sales force historically wasted 60.2% of its dialing budget chasing married profiles under false assumptions of financial maturity, despite single customers holding a 47% higher conversion efficiency edge. 

Similarly, cross-sectional mapping of professional backgrounds confirms that while a customer’s job acts as a temporary catalyst—with retirees and students executing maximum portfolio response due to lifestyle and schedule availability—corporate or standard employment profiles operate as sales inhibitors. 

Consequently, to maximize return on investment (ROI) and eradicate organizational bias, this architecture removes demographics from the scoring engine, replacing subjective profiling with strict, data-validated behavioral pillars.
</details>

<details>
<summary><b>Liquidity Thresholds, Debt Impacts, and Buffer Anomalies</b></summary>

Financial portfolio diagnostics isolate capital availability and liability exposure as the actual drivers of campaign success. Non-parametric distribution testing establishes that a customer's investment propensity scales exponentially once their cash holdings cross a strict stability threshold located at a median of €733.00, proving that an active financial cushion is the primary gate for product adoption. 

The accumulation of active debts, conversely, acts as a severe commercial depressant; relational tracking rejects standard credit assumptions by revealing that conversion performance collapses monotonically the moment a single active loan is absorbed, regardless of whether it stems from housing or personal credit lines. 

Crucially, this destructive impact of debt is not uniform across the population. Cross-tabulation modeling isolates a powerful asset wealth buffer effect: high-net-worth liquidity outliers holding cash balances above €5,000.00 remain highly receptive to long-term investment commitments despite holding active liabilities, whereas lower-capital records suffer an immediate destruction of their investment capacity under the slightest debt pressure. 

Furthermore, when evaluating systemic drivers, an active positive conversion history is mathematically proven to be an infinitely stronger predictor of system velocity than any traditional financial metric, as a prior successful relationship with the institution unlocks an immediate buy signal that overrides low asset balances.
</details>

<details>
<summary><b>Temporal Seasonality, Contact Intensity, and Cumulative Fatigue</b></summary>

Optimizing the call center's performance requires aligning dialing efforts with the precise physics of market fatigue and seasonal receptivity windows. Annual calendar tracking exposes a critical operational blind spot: the bank traditional routing misallocated 48.7% of its seasonal capacity strictly within the second quarter, saturating the market and forcing May to operate at a conversion bottom of 6.72%. 

In stark contrast, March emerged as a high-signal seasonal window with maximum conversion efficiency, although senior management must treat this peak as an orientation guideline subject to sample-size volatility before scaling capital. Regarding monthly timelines, the distribution of days serves solely as a tactical baseline for agent routing, as daily quincena variations display minimal statistical variance in buyer propensity. 

More critically, call center productivity is tightly bound to a strict contact intensity threshold. Consumer receptivity hits a terminal ceiling at the fourth monthly contact, after which any cumulative historical dialing stops being profitable and actively degrades bank performance. 

This operational blind spot accounted for 6,118 completely wasteful calls across the historical database, proving that excessive repetitive dialing destroys agent time and erodes customer goodwill, validating the automated suppression gates hardcoded into our governance framework.
</details>

<details>
<summary><b>Performance Synergies & Call Duration Boundaries</b></summary>

The ultimate profiling of business success is achieved by intersecting liquid balance scales directly with the historical loyalty vector, cementing a hyper-profitable pipeline that drives our automated triage cockpit to a 69.85% real conversion rate. Inside this optimized workflow, the relationship between agent time and performance follows strict, diminishing returns. 

The empirical data rejects the assumption that longer calls continuously maximize call center metrics; instead, it isolates an optimal productivity threshold where conversion probability stabilizes. 

Spending agent time past this equilibrium window yields zero statistical variance in product adoption, transforming potential sales into an operational drain. 

By enforcing this comprehensive analytical filter, the enterprise permanently replaces commercial intuition with an analytically robust, sensible, and production-ready system of asset governance.
</details>

---

---

## Data Source & Citation
The baseline data used in this framework originates from the institutional banking campaign repository hosted by the UCI Machine Learning Repository:
* **Dataset:** Bank Marketing (Portuguese Banking Institution).
* **Official Citation:** Moro, S., Rita, P., & Cortez, P. (2014). Bank Marketing [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5K306.

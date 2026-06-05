-- ==============================================================================
-- CAPITAL CONVERSION DYNAMICS: PORTFOLIO GOVERNANCE QUERIES
-- Scenario Validation via Structural Queries (SQL)
-- Methodology: Virtual Design and Construction (VDC) & Advanced Analytics
-- Database Engine: SQLite / ANSI SQL
-- ==============================================================================
-- DESCRIPTION:
-- With the dataset fully enriched through feature engineering, we load the database 
-- into a relational engine to isolate the core metrics of the system and interrogate 
-- our custom indicators. The metrics documented across the following 13 specific 
-- business questions represent a preliminary, exploratory baseline—to be treated 
-- strictly as descriptive baseline drafts and hypothetical tracking rather than 
-- definitive business insights. 
--
-- This relational phase maps the macro macroscopic behavior of the portfolio to 
-- assess initial call-center efficiency; however, the structural robustness and 
-- causal signal of these variables remain unverified until they are rigorously 
-- tested through Shannon's Information Theory and non-parametric statistical filters. 
-- Only the attributes that clear these downstream information density thresholds 
-- will be certified as validated pillars of signal, ensuring the final operational 
-- architecture systematically discards demographic noise.
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- SYSTEM INTEGRITY CHECK
-- Verification of total records loaded into the system (Table: bank)
-- ------------------------------------------------------------------------------
SELECT COUNT(*) AS total_registros
FROM bank;

-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 1
-- Question: How does financial liquidity affect the final campaign conversion rate?
--
-- Description:
-- To answer this question, we analyze the performance of the engineered account 
-- balance segments ('balance_group'). Our goal is to evaluate two core Key Performance 
-- Indicators (KPIs): the Conversion Rate (operational efficiency per segment) and 
-- the Total Conversion Share (volume contribution to global sales), isolating 
-- the most profitable customer groups for the bank.
-- ------------------------------------------------------------------------------
SELECT 
    balance_group, 
    COUNT(*) AS total_clients,
    SUM(y_converted) AS total_converted,
    ROUND(AVG(y_converted) * 100, 2) AS conversion_rate,
    RANK() OVER (ORDER BY AVG(y_converted) DESC) AS rank_exito,
    ROUND(SUM(y_converted) * 100.0 / SUM(SUM(y_converted)) OVER (), 2) || '%' AS share_total_converted
FROM bank
GROUP BY balance_group
ORDER BY conversion_rate DESC;

-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 2
-- Question: How does accumulated debt affect the success rate of the telemarketing campaign?
--
-- Description:
-- To answer this question, we analyze our custom metric 'debt_index', which adds 
-- up the customer's liabilities (housing loans, personal loans, and credit defaults). 
-- The goal is to measure the Conversion Rate across debt levels to quantify exactly 
-- how much financial liabilities lower a customer's ability to save.
-- ------------------------------------------------------------------------------
SELECT 
    debt_index,
    COUNT(*) AS total_customers,
    SUM(y_converted) AS total_converted,
    ROUND(AVG(y_converted) * 100, 2) AS conversion_rate,
    RANK() OVER (ORDER BY AVG(y_converted) DESC) AS priority_rank
FROM bank
GROUP BY debt_index
ORDER BY debt_index ASC;


-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 3
-- Question: Is a positive conversion history a stronger driver of success than traditional financial metrics?
--
-- Description:
-- To answer this question, we evaluate our custom metric 'previous_success', which 
-- tracks whether the customer subscribed to a product during the past marketing 
-- campaign. The goal is to calculate the Conversion Rate against the bank’s 
-- historical baseline 11.70% to quantify the exact sales multiplier generated 
-- by customer loyalty.
-- ------------------------------------------------------------------------------
SELECT 
    previous_success,
    COUNT(*) AS total_customers,
    SUM(y_converted) AS total_converted,
    ROUND(AVG(y_converted) * 100, 2) AS conversion_rate,
    -- Veces que el grupo supera la probabilidad base (0.117)
    ROUND(AVG(y_converted) / 0.117, 1) || 'x' AS conversion_multiplier
FROM bank
GROUP BY previous_success
ORDER BY conversion_rate DESC;

-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 4
-- Question: Are there specific seasonal windows where customers are naturally more receptive to commercial contact?
--
-- Description:
-- To answer this question, we analyze business seasonality by quarter using our 
-- custom variable 'quarter'. We evaluate the relationship between two critical metrics: 
-- the Conversion Rate (operational efficiency) and the Call Share (volume of calls 
-- deployed). This contrast directly exposes periods of operational saturation and 
-- misallocated resources across the bank's annual calendar.
-- ------------------------------------------------------------------------------
SELECT 
    quarter, 
    total_clients,
    ROUND(conversion_rate, 2) AS conversion_rate,
    ROUND(total_clients * 100.0 / SUM(total_clients) OVER(), 1) || '%' AS contact_share
FROM (
    SELECT quarter, 
           COUNT(*) AS total_clients,
           AVG(y_converted) * 100.0 AS conversion_rate
    FROM bank
    GROUP BY quarter
) sub
ORDER BY conversion_rate DESC;


-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 5
-- Question: Is there a specific demographic window where customers respond better to phone calls?
--
-- Description:
-- To answer this question, we evaluate sales performance across customer life 
-- cycles using our custom variable 'age_group'. We analyze the relationship between 
-- the Conversion Rate (demographic efficiency) and the Call Share (volume of calls 
-- deployed) to identify misallocations of marketing efforts across generations.
-- ------------------------------------------------------------------------------
SELECT 
    age_group, 
    total_clients,
    ROUND(conversion_rate, 2) AS conversion_rate,
    RANK() OVER (ORDER BY conversion_rate DESC) AS performance_rank,
    ROUND(total_clients * 100.0 / SUM(total_clients) OVER(), 1) || '%' AS contact_share
FROM (
    SELECT age_group, 
           COUNT(*) AS total_clients,
           AVG(y_converted) * 100.0 AS conversion_rate
    FROM bank
    GROUP BY age_group
) sub
ORDER BY conversion_rate DESC;

-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 6
-- Question: What is the maximum contact intensity threshold before repetitive dialing creates customer fatigue and lowers productivity?
--
-- Description:
-- To answer this question regarding the active marketing campaign, we evaluate our 
-- custom variable 'campaign_group', which segments call frequency. We analyze the 
-- relationship between the Conversion Rate and the Call Share to pinpoint the exact 
-- threshold of diminishing returns where excessive dialing oversaturates the customer 
-- and drains channel profitability.
-- ------------------------------------------------------------------------------
WITH campaign_stats AS (
    SELECT 
        campaign_group, 
        COUNT(*) AS total_clients,
        AVG(y_converted) * 100.0 AS conversion_rate
    FROM bank
    GROUP BY campaign_group
)
SELECT 
    campaign_group, 
    total_clients,
    ROUND(conversion_rate, 2) AS conversion_rate,
    RANK() OVER (ORDER BY conversion_rate DESC) AS performance_rank,
    ROUND(total_clients * 100.0 / SUM(total_clients) OVER(), 1) || '%' AS contact_share
FROM campaign_stats
ORDER BY conversion_rate DESC;


-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 7
-- Question: At what precise point does cumulative historical effort stop being profitable and start hurting overall bank productivity?
--
-- Description:
-- To answer this question, we evaluate our custom metric 'total_contacts', which 
-- unifies past and current calling efforts. We analyze the relationship between 
-- two performance metrics: the Marginal Conversion Rate (efficiency per precise 
-- call count) and the Running Conversion Rate. To ensure data stability, we apply 
-- a restrictive 'HAVING' clause filter to evaluate only scenarios with a 
-- representative sample volume (N > 30).
-- ------------------------------------------------------------------------------
WITH contact_stats AS (
    SELECT 
        total_contacts, 
        COUNT(*) AS total_clients,
        SUM(y_converted) AS successes
    FROM bank
    GROUP BY total_contacts
    HAVING COUNT(*) >= 30
)
SELECT 
    total_contacts,
    total_clients,
    ROUND(successes * 100.0 / total_clients, 2) AS conversion_rate,
    -- Tasa de conversión acumulada para detectar el punto de saturación
    ROUND(
        SUM(successes) OVER (ORDER BY total_contacts ASC) * 100.0 / 
        SUM(total_clients) OVER (ORDER BY total_contacts ASC), 
        2
    ) AS running_conversion_rate
FROM contact_stats
ORDER BY total_contacts ASC;

-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 8
-- Question: Does a customer's professional background act as a catalyst or an inhibitor for sales conversion?
--
-- Description:
-- To answer this question, we run a cross-comparison analysis using the original 
-- 'job' column. The goal is to evaluate the relationship between three performance 
-- metrics: the Conversion Rate, the Gap vs. the Bank's Average, and the Call Share. 
-- This analysis isolates which professional segments hold the highest commercial 
-- affinity and identifies misallocated resource gaps across occupations.
-- ------------------------------------------------------------------------------
WITH job_metrics AS (
    SELECT 
        job,
        COUNT(*) AS total_clients,
        AVG(y_converted) * 100.0 AS conversion_rate
    FROM bank
    GROUP BY job
),
global_benchmark AS (
    SELECT AVG(y_converted) * 100.0 AS avg_global FROM bank
)
SELECT 
    jm.job,
    jm.total_clients,
    ROUND(jm.conversion_rate, 2) AS conversion_rate,
    RANK() OVER (ORDER BY jm.conversion_rate DESC) AS performance_rank,
    -- Gap vs Avg: Puntos porcentuales de ventaja/desventaja sobre el promedio
    ROUND(jm.conversion_rate - gb.avg_global, 2) AS gap_vs_avg,
    ROUND(jm.total_clients * 100.0 / SUM(jm.total_clients) OVER(), 1) || '%' AS contact_share
FROM job_metrics jm
CROSS JOIN global_benchmark gb
ORDER BY performance_rank ASC;


-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 9
-- Question: Does education level serve as a factor that facilitates product adoption?
--
-- Description:
-- To answer this question, we analyze sales performance across the original 
-- 'education' column. The goal is to evaluate the relationship between three 
-- performance metrics: the Conversion Rate, the Gap vs. the Bank's Average, and 
-- the Call Share deployed to check if academic backgrounds act as a strong driver 
-- for product adoption.
-- ------------------------------------------------------------------------------
WITH edu_metrics AS (
    SELECT 
        education, 
        COUNT(*) AS total_clients,
        AVG(y_converted) * 100.0 AS conversion_rate
    FROM bank
    GROUP BY education
),
global_benchmark AS (
    SELECT AVG(y_converted) * 100.0 AS avg_global FROM bank
)
SELECT 
    em.education, 
    em.total_clients,
    ROUND(em.conversion_rate, 2) AS conversion_rate,
    RANK() OVER (ORDER BY em.conversion_rate DESC) AS performance_rank,
    -- Gap vs Avg: Diferencial de éxito respecto a la media del sistema
    ROUND(em.conversion_rate - gb.avg_global, 2) AS gap_vs_avg,
    ROUND(em.total_clients * 100.0 / SUM(em.total_clients) OVER(), 1) || '%' AS contact_share
FROM edu_metrics em
CROSS JOIN global_benchmark gb
ORDER BY performance_rank ASC;

-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 10
-- Question: Does the customer's marital status influence their decision to adopt new savings instruments?
--
-- Description:
-- To answer this question, we analyze sales performance across the original 
-- 'marital' column. The goal is to cross-compare traditional business assumptions 
-- against actual database conversion trends by evaluating the relationship between 
-- three performance metrics: the Conversion Rate, the Gap vs. the Bank's Average, 
-- and the Call Share (volume deployed).
-- ------------------------------------------------------------------------------
WITH marital_metrics AS (
    SELECT 
        marital, 
        COUNT(*) AS total_clients,
        AVG(y_converted) * 100.0 AS conversion_rate
    FROM bank
    GROUP BY marital
),
global_benchmark AS (
    SELECT AVG(y_converted) * 100.0 AS avg_global FROM bank
)
SELECT 
    mm.marital, 
    mm.total_clients,
    ROUND(mm.conversion_rate, 2) AS conversion_rate,
    RANK() OVER (ORDER BY mm.conversion_rate DESC) AS performance_rank,
    -- Gap vs Avg: Diferencial de éxito respecto a la media del banco
    ROUND(mm.conversion_rate - gb.avg_global, 2) AS gap_vs_avg,
    ROUND(mm.total_clients * 100.0 / SUM(mm.total_clients) OVER(), 1) || '%' AS contact_share
FROM marital_metrics mm
CROSS JOIN global_benchmark gb
ORDER BY performance_rank ASC;


-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 11
-- Question: Is it possible to profile business success by intersecting the most critical customer metrics?
--
-- Description:
-- To answer this question, we run a cross-tabulation analysis in SQL by 
-- intersecting the two most powerful dimensions identified in our previous queries: 
-- past customer loyalty ('previous_success') and active liabilities ('debt_index'). 
-- The goal is to evaluate the Conversion Rate across these combined profiles, 
-- verifying if intersecting financial distress with prior success creates an 
-- optimal prioritization rule for the campaign.
-- ------------------------------------------------------------------------------
WITH propensity_scoring AS (
    SELECT 
        y_converted,
        -- Asignación de Pesos Basada en Evidencia Estadística
        (CASE WHEN previous_success = 1 THEN 3 ELSE 0 END +
         CASE WHEN balance_group = 'Premium' THEN 2 ELSE 0 END +
         CASE WHEN debt_index = 0 THEN 2 ELSE 0 END +
         CASE WHEN age_group IN ('Young Adult', 'Senior') THEN 1 ELSE 0 END +
         CASE WHEN quarter = 'Q1' THEN 1 ELSE 0 END) AS total_score
    FROM bank
)
SELECT 
    total_score,
    COUNT(*) AS total_customers,
    SUM(y_converted) AS total_success,
    ROUND(AVG(y_converted) * 100, 2) AS conversion_rate,
    -- Lift Index: Multiplicador de eficiencia sobre la media (11.7%)
    ROUND(AVG(y_converted) / 0.117, 2) || 'x' AS lift_index
FROM propensity_scoring
GROUP BY total_score
ORDER BY total_score DESC;

-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 12
-- Question: Is there an optimal productivity threshold where the time spent by the agent maximizes call center performance?
--
-- Data Leakage Warning: 
-- The 'duration' column introduces a critical Data Leakage risk for predictive 
-- purposes since its value is only recorded *after* the call ends. In this section, 
-- it is included strictly to optimize workforce management and call-center 
-- operational productivity; it will be strictly excluded from all subsequent 
-- statistical validation phases.
--
-- Description:
-- To answer this question, we analyze the relationship between two operational 
-- metrics: the Conversion Rate and the Operational Efficiency Index (conversions 
-- per 1,000 seconds of call time).
-- ------------------------------------------------------------------------------
WITH duration_stats AS (
    SELECT 
        CASE 
            WHEN duration <= 60 THEN '0-1 min'
            WHEN duration <= 180 THEN '1-3 min'
            WHEN duration <= 300 THEN '3-5 min'
            WHEN duration <= 600 THEN '5-10 min'
            ELSE '10+ min'
        END AS duration_range,
        duration,
        y_converted
    FROM bank
)
SELECT 
    duration_range,
    COUNT(*) AS total_calls,
    SUM(y_converted) AS successes,
    ROUND(AVG(y_converted) * 100, 2) AS conversion_rate,
    -- Efficiency Index: Conversiones obtenidas por cada 1,000 segundos de labor
    ROUND(SUM(y_converted) * 1000.0 / SUM(duration), 3) AS efficiency_index
FROM duration_stats
GROUP BY duration_range
ORDER BY MIN(duration) ASC;


-- ------------------------------------------------------------------------------
-- BUSINESS QUERY 13
-- Question: Is the impact of debt uniform across the entire population, or is there a buffer effect depending on the customer's capital?
--
-- Description:
-- To answer this question, we perform a cross-tabulation analysis in SQL by 
-- intersecting our custom liquidity segments ('balance_group') with debt levels 
-- ('debt_index'). We evaluate the Conversion Rate across these combined segments 
-- and measure the net drop in efficiency caused by liabilities within each 
-- wealth tier. The goal is to isolate whether holding high capital acts as a 
-- buffer against active debts.
-- ------------------------------------------------------------------------------
WITH group_stats AS (
    SELECT 
        balance_group,
        debt_index,
        COUNT(*) AS total_customers,
        AVG(y_converted) * 100.0 AS conv_rate
    FROM bank
    GROUP BY balance_group, debt_index
)
SELECT 
    balance_group,
    debt_index,
    total_customers,
    ROUND(conv_rate, 2) AS conv_rate,
    -- Intra-group Delta: Desviación respecto al promedio del estrato de riqueza
    ROUND(conv_rate - AVG(conv_rate) OVER(PARTITION BY balance_group), 2) AS intra_group_delta
FROM group_stats
ORDER BY balance_group, debt_index;

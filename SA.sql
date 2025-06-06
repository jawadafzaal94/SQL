WITH MonthlySignups AS (
    SELECT 
        DATE_TRUNC('month', progress_state_updated_at) AS signup_month,
        COUNT(DISTINCT user_id) AS total_signups
    FROM onboarding_audit
    WHERE progress_state_current = 'signup'
    GROUP BY DATE_TRUNC('month', progress_state_updated_at)
),
StepCounts AS (
    SELECT 
        DATE_TRUNC('month', progress_state_updated_at) AS signup_month,
        progress_state_current AS step_name,
        COUNT(DISTINCT user_id) AS users
    FROM onboarding_audit
    WHERE progress_state_current IN ('signup', 'mobileLogin', 'financialAssessment', 'portfolioCreation', 'informationProvided', 'agreementSigned', 'firstDeposit')
    GROUP BY DATE_TRUNC('month', progress_state_updated_at), progress_state_current
)
SELECT 
    ms.signup_month,
    sc.step_name,
    sc.users,
    ms.total_signups,
    ROUND(sc.users * 100.0 / ms.total_signups, 2) AS conversion_percentage
FROM StepCounts sc
JOIN MonthlySignups ms 
  ON sc.signup_month = ms.signup_month
ORDER BY ms.signup_month, 
         FIELD(sc.step_name, 'signup', 'mobileLogin', 'financialAssessment', 'portfolioCreation', 'informationProvided', 'agreementSigned', 'firstDeposit')

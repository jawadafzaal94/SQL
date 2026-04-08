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
    WHERE progress_state_current IN (
        'signup',
        'mobileLogin',
        'financialAssessment',
        'portfolioCreation',
        'informationProvided',
        'agreementSigned',
        'firstDeposit'
    )
    GROUP BY 
        DATE_TRUNC('month', progress_state_updated_at),
        progress_state_current
)

SELECT 
    sc.signup_month,
    sc.step_name,
    sc.users,
    ms.total_signups,
    ROUND(sc.users * 100.0 / ms.total_signups, 2) AS conversion_percentage
FROM StepCounts sc
JOIN MonthlySignups ms 
  ON sc.signup_month = ms.signup_month

ORDER BY 
    sc.signup_month,
    CASE sc.step_name
        WHEN 'signup' THEN 1
        WHEN 'mobileLogin' THEN 2
        WHEN 'financialAssessment' THEN 3
        WHEN 'portfolioCreation' THEN 4
        WHEN 'informationProvided' THEN 5
        WHEN 'agreementSigned' THEN 6
        WHEN 'firstDeposit' THEN 7
    END;






---------------------------------------------
 2


WITH Base AS (
    SELECT 
        DATE_TRUNC('month', progress_state_updated_at) AS month,
        user_id,
        progress_state_current
    FROM onboarding_audit
),

FunnelCounts AS (
    SELECT
        month,

        COUNT(DISTINCT CASE WHEN progress_state_current = 'signup' THEN user_id END) AS signups,

        COUNT(DISTINCT CASE WHEN progress_state_current = 'mobileLogin' THEN user_id END) AS mobile_login,

        COUNT(DISTINCT CASE WHEN progress_state_current = 'financialAssessment' THEN user_id END) AS financial_assessment,

        COUNT(DISTINCT CASE WHEN progress_state_current = 'portfolioCreation' THEN user_id END) AS portfolio_creation,

        COUNT(DISTINCT CASE WHEN progress_state_current = 'informationProvided' THEN user_id END) AS information_provided,

        COUNT(DISTINCT CASE WHEN progress_state_current = 'agreementSigned' THEN user_id END) AS agreement_signed,

        COUNT(DISTINCT CASE WHEN progress_state_current = 'firstDeposit' THEN user_id END) AS first_deposit

    FROM Base
    GROUP BY month
)

SELECT
    month,
    signups,

    mobile_login,
    ROUND(mobile_login * 100.0 / signups, 2) AS mobile_login_conversion,

    financial_assessment,
    ROUND(financial_assessment * 100.0 / signups, 2) AS financial_assessment_conversion,

    portfolio_creation,
    ROUND(portfolio_creation * 100.0 / signups, 2) AS portfolio_creation_conversion,

    information_provided,
    ROUND(information_provided * 100.0 / signups, 2) AS information_provided_conversion,

    agreement_signed,
    ROUND(agreement_signed * 100.0 / signups, 2) AS agreement_signed_conversion,

    first_deposit,
    ROUND(first_deposit * 100.0 / signups, 2) AS first_deposit_conversion

FROM FunnelCounts
ORDER BY month;


------------

JAN & FEB 


WITH UserSignup AS (
    -- Step 1: Assign each user to a signup cohort
    SELECT 
        user_id,
        MIN(progress_state_updated_at) AS signup_date,
        DATE_TRUNC('month', MIN(progress_state_updated_at)) AS signup_month
    FROM onboarding_audit
    WHERE progress_state_current = 'signup'
    GROUP BY user_id
),

UserSteps AS (
    -- Step 2: Attach all user events to their signup cohort
    SELECT 
        us.signup_month,
        us.user_id,
        oa.progress_state_current,
        oa.progress_state_updated_at
    FROM onboarding_audit oa
    JOIN UserSignup us
        ON oa.user_id = us.user_id
),

StepCounts AS (
    -- Step 3: Count users at each step per cohort
    SELECT 
        signup_month,
        progress_state_current AS step_name,
        COUNT(DISTINCT user_id) AS users
    FROM UserSteps
    WHERE progress_state_current IN (
        'signup',
        'mobileLogin',
        'financialAssessment',
        'portfolioCreation',
        'informationProvided',
        'agreementSigned',
        'firstDeposit'
    )
    GROUP BY 
        signup_month,
        progress_state_current
),

MonthlySignups AS (
    -- Step 4: Total users per cohort (baseline)
    SELECT 
        signup_month,
        COUNT(DISTINCT user_id) AS total_signups
    FROM UserSignup
    GROUP BY signup_month
)

-- Final output
SELECT 
    sc.signup_month,
    sc.step_name,
    sc.users,
    ms.total_signups,
    ROUND(sc.users * 100.0 / ms.total_signups, 2) AS conversion_percentage
FROM StepCounts sc
JOIN MonthlySignups ms
    ON sc.signup_month = ms.signup_month

ORDER BY 
    sc.signup_month,
    CASE sc.step_name
        WHEN 'signup' THEN 1
        WHEN 'mobileLogin' THEN 2
        WHEN 'financialAssessment' THEN 3
        WHEN 'portfolioCreation' THEN 4
        WHEN 'informationProvided' THEN 5
        WHEN 'agreementSigned' THEN 6
        WHEN 'firstDeposit' THEN 7
    END;









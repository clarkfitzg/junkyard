net_present_value = function(monthly_payment
    , discount_rate = 2.25 # Current discount rate for Federal Reserve
    , years_loan = 30
    , periods = years_loan * 12
){
    # multiplier for monthly value
    d = 1 + discount_rate / (100*12)
    m = 1 / d
    powers = seq(periods)
    m = m^powers

    monthly_values = m * monthly_payment
    sum(monthly_values)
}


# Scenario 1:   3.49% VA loan
npv1 = net_present_value(1673.64)

# Scenario 2:   4.0% conventional loan
npv2 = net_present_value(1763.14)

npv2 - npv1


# Variation: Larger discount rate
npv1b = net_present_value(1673.64, discount_rate = 2.75)

# Scenario 2:   4.0% conventional loan
npv2b = net_present_value(1763.14, discount_rate = 2.75)

npv2b - npv1b



############################################################

# 15 year loans

nasb_15_1.75 = net_present_value(1781, years_loan = 15)


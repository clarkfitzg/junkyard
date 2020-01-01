net_present_value = function(monthly_payment
    , discount_rate = 2.25 # Current discount rate for Federal Reserve
    , years_loan = 30
    , periods = years_loan * 12
    , fees = 0
){
    # multiplier for monthly value
    d = 1 + discount_rate / (100*12)
    m = 1 / d
    powers = seq(periods)
    m = m^powers

    monthly_values = m * monthly_payment
    sum(monthly_values) + fees
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
# 127.5k down, 262.5k loan
# Those are not the numbers I originally entered... 
# So the website is designed to deceive, to make the loan look more appealing.
# Complete bullshit.

nasb_15 = net_present_value(1845, years_loan = 15)
nasb_15_0.89 = net_present_value(1813, years_loan = 15, fees = 2336)
nasb_15_1.75 = net_present_value(1781, years_loan = 15, fees = 4594)

nasb_15 


############################################################

# 15 year loans
# 125k down, 275k loan
# In contrast, Stephanie made the loan *higher*, to cover realistic closing costs, which makes the loan look worse in comparison.


# 2420
steph1 = net_present_value(1949, years_loan = 15, fees = 687)
steph1b = net_present_value(1932, years_loan = 15, fees = 1375)
steph2 = net_present_value(1915.68, years_loan = 15, fees = 2000)

# 1.25
# Disproportionate fee compared to others.
steph3 = net_present_value(1899, years_loan = 15, fees = 3437)

s = c(steph1, steph1b, steph2, steph3)
s2 = rev(s)

plot(s)

diff(s)

# Shows that the fees are worth it assuming we're in the house for at least 3 or 4 years.
((2000 - 687) / (1949 - 1916)) / 12

((2000 - 0) / (1949 + 17 - 1916)) / 12

# The 3.0 rate takes 7 years to break even, which is much worse compared to the others.
((3437 - 2000) / (1916 - 1899)) / 12

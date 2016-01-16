# Simulating results found in ASA psych research paper

race = rep(c('asian', 'white', 'african', 'hispanic'), each=500)
n = length(race)
gpa = numeric(n)
gpa[race == 'asian'] = 3.11
gpa[race == 'white'] = 3.31
gpa[race == 'african'] = 2.91
gpa[race == 'hispanic'] = 3.01
noise = rnorm(n, sd=0.5)
gpa = gpa + noise

fit1 = lm(gpa ~ race)

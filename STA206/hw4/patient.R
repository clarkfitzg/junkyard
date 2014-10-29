library(Matrix)

patient = read.table('patient.txt')
names(patient) = c('sat', 'age', 'severity', 'anxiety')
fit = lm(sat ~ age + severity + anxiety, data=patient)
fit = lm(sat ~ age + severity + anxiety, data=scale(patient))

fit3 = lm(sat ~ age + severity + anxiety + age:severity + I(age^2), data=patient)

r1 = lm(sat ~ age, data=patient)
r2 = lm(severity ~ age, data=patient)
e1 = residuals(r1)
e2 = residuals(r2)
cor(e1, e2) ** 2

hist(patient$age)
plot(patient)
boxplot(scale(patient))
summary(patient)

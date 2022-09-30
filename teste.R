library(ggplot2)

View(iris)

ToothGrowth$dose <- as.factor(ToothGrowth$dose)
mtcars$cyl <- as.factor(mtcars$cyl)
head(ToothGrowth)

# Box plot
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) +geom_boxplot()
print(p)
# scatter plot
p2 <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()
print(p2)

?ggplot2

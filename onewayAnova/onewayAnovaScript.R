## read data 

## preview data

mydata <- read.table("onewayanova.txt", h=T)
head(mydata)
summary(mydata)

## Question is is there a difference in length between the
## three species

# Assumption 1: All samples are independent, and collected
# in >2 independent categorical groups (if just 2 groups, would 
# need to do a t-test)

# Label groups and set as categorical factors

mydata$Group <- as.factor(mydata$Group)
mydata$Group <- factor(mydata$Group,labels = c("Wall lizard", 
                                              "Viviparous lizard",
                                              "Snake-eyed lizard"))

class(mydata$Group)

## Assumption 2: Dependent variable is continuous

## Assumption 3: Normal distribution of each group, no major outliers
## if not the case, must run a different test

group1 <- subset(mydata, Group == "Wall lizard")
group2 <- subset(mydata, Group == "Viviparous lizard")
group3 <- subset(mydata, Group == 'Snake-eyed lizard')

qqnorm(group1$Length)
qqline(group1$Length)

qqnorm(group2$Length)
qqline(group2$Length)

qqnorm(group3$Length)
qqline(group3$Length)

## Assumption 4: Homogeneity of Variance
bartlett.test(Length ~ Group, data = mydata)
# since p-value > 0.05 we fail to reject the null hypothesis
# and can assume that we have equality of variance.

##################################################

# One way ANOVA - Test if the means of the k populations are equal

model1 <- lm(Length ~ Group, data = mydata)
anova(model1)
## given a p-value that is much smaller that 0.05, we can reject
## the null hypothesis and conclude that there is a statistically
## significant difference in length between the species.,

## however, we do not know which species is longer or smaller than the others

## post-hoc test TUKEYHSD - test which of the groups have different means
TukeyHSD(aov(model1))
## What we can conclude based on the output from the post hoc test
## is that the Vivi lizard's size is different than the other 2 and 
## the snake eyed and wall lizards are teh same size.

#########################################

# Data visualization
library(ggplot2)

ggplot(data=mydata, aes(x = Group, y = Length)) +
  geom_boxplot(fill= "grey80", color = "black") +
  scale_x_discrete() +
  xlab("Treatment Group") +
  ylab("Length (cm)")

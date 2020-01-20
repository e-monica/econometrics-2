/*
For Econometrics Assignment # 2: On Bivariate and Multiple Regression
Last modified by: Monica Elgawly
Last modified on: Friday, March 16, 2018
**************************************************************************************************************

**************************************************************************************************************
2a)*/

clear all
cd "/Users/monicaelgawly/Downloads/metrics"

*loads the stata data file named for various heights
use "bwght.dta"

*gen command creates a dummy variable equating 1 to a mother who smokes at least a cig/day 0 otherwise

*gen anycig=1
*replace anycig=0 if cigs==0

*tab command for (anycig=1)/(total number of moms sampled) 
 *gen anycig=cig=1
 *gen anycig=cig>0
 /*Ref on StataYouTube channel: Data management: 
 How to create a new variable that is 
 calculated from other variables*/
tab anycig;

*187 women smoked during pregnancy = 15.85%  ??
**************************************************************************************************************

**************************************************************************************************************
*b)

*regression used to view total number of sample points
reg bwght anycig

/* ^B0 is the average weight of babies born to mothers who did not smoke during pregnancy. 
^B1 is the additional average weight of babies born to mothers who smoked during pregnancy. 
Children with moms who smoked during pregnancy weighed less on average than children with 
non-smoking moms. We can reject the null hypothesis at the significance level of 0.05: the 
t-statistic = (-8.92-0)/1.589 equals |-5.61|>1.96 and the p-value equals 0<0.05.*/

/*Note to self: p<0.05 significant, p<0.01 high significance, p>0.05 not significance
From p<0.01 we can think of how a high significance shows a strange outcome, in which case the p-value
is so small it forces us to come to terms with a false null hypothesis. In formal terms, this is called
rejecting the null hypothesis. All other values can then be determined from this understanding

Therefore, the effect of smoking any number of cigarettes can be seen as detrimental and impactful on future
birthweight of a mother's future child during pregnancy.*/
**************************************************************************************************************

**************************************************************************************************************
/*c) The regression shows that smoking an additional cigarette reduces infant birth weight by 0.51
ounces, on average. The t-statistic that corresponds to the statistical significance of this coefficient
is -5.46, with a p-value less than 0. Thus, we can reject the null: 
H0: add 1 cig has 0 impact on infant birthweight.*/

reg bwght anycig if anycig==1

reg bwght cigs

margins, dy/dx(*) 

/*Both of the last two commands show equally true that the marginal impact is -.509 on weight.
This translates to mean the baby is marginally likely to decrease in weight by half an ounce
when his mom smokes an additional cigarette a day during pregnancy.
This is a statistically significant outcome.
**************************************************************************************************************

**************************************************************************************************************
d) When a woman smokes no cigarettes, cigs = 0 and so the expected birthweight is ^bwghtX=0 = ^B0 =
120:18. For the child of a woman who smokes a pack per day, ^bwghtpack = ^B0 + ^B1(20) = 109:99. To
test the significance of this difference, notice that ^bwghtpack - ^bwght0 = ^B0 + ^B1(20) - ^B0 = ^B1(20).
Then the hypothesis test is H0 : 20 ^B1 = 0, which is equivalent to the hypothesis test H0 : ^ B1 = 0.
And we know from part (c) that ^B1 is significant. Thus, the difference of 10.19 ounces between
the expected birthweight of the infants born to non-smoking and pack-a-day women is statistically
significant.
**************************************************************************************************************

**************************************************************************************************************
e)
No, it's a case of omitted variable bias. One example of an omitted
variable is the mother’s income. If Corr(incomei; smokingi) < 0 and Corr(incomei; bwghti) > 0,
then ^B1 from the model: bwghti = B0 +B1cigsi +ui will have negative bias. 

If we think that the true effect of smoking on birthweight is negative, the negative bias on a negative 
number means that ^B1 will be too small (i.e., a larger negative number) compared to the true value B1. 

In other words, omitting the variable incomei from the model biases ^B1 away 
from zero toward finding a statistically significant effect.
**************************************************************************************************************

**************************************************************************************************************
f) 
Homoskedasticity assumes that the variance of the error terms (i.e. values of Yi) have the same
variance for every value of X. In this example, it is not clear whether homoskedasticity will hold.
On the one hand, infants born to women who do not smoke may exhibit higher variance in birthweights,
primarily driven by higher birthweights at the upper end of the distribution, compared
to women who do not smoke, which would suggest there is heteroskedasticity. On the other hand,
infants born to women who smoke may also exhibit high variance in birthweight if smoking reduces
birthweight by a lot at the lower end of the distribution, and so homoskedasticity might be a valid
assumption in this model.
In general though, the homoskedasticity assumption is very restrictive and unnecessary—we can
still achieve unbiased OLS estimates without homoskedasticity. And if we incorrectly assume homoskedasticity
and use the homoskedasticity formulas for the variances of B0 and B1, then we will
get incorrect standard errors and hypothesis tests. So it is usually safer to assume heteroskedasticity.
**************************************************************************************************************

**************************************************************************************************************
g) 
*/

reg bwght cigs, r;

/*There is very little difference between the standard errors—robust gives a standard error on ^B1 of
0.092, while estimating without the robust option gives a standard error of 0.093. Thus, it does not
seem that heterskedasticity is a problem in this data, although we also see that there is little cost
to using heteroskedasticity-robust standard errors, with the benefit that we are protected against
heteroskedasticity, just in case.*/
**************************************************************************************************************

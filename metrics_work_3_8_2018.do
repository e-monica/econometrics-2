/* 
For Econometrics Assignment # 2: On Bivariate and Multiple Regression

Last modified by: Monica Elgawly
Last modified on: Saturday, March 3, 2018

Notes:

*/

clear all
cd "/Users/monicaelgawly/Downloads/metrics"

*loads the stata data file named for various heights
use "bwght.dta"

*gen command creates a dummy variable equating 1 to a mother who smokes at least a cig/day 0 otherwise

gen anycig=1
replace anycig=0 if cigs==0

*tab command to determine what percentage of moms smoked during pregnancy
*in English, where (anycig=1)/(total number of moms sampled) 

reg bwght anycig

*regression used to view total number of sample points 

reg bwght anycig if anycig==1

reg bwght cigs

margins, dy/dx(*) 

*both of the last two commands show equally true that the marginal impact is -.509 on weight
*this translates to mean the baby is marginally likely to decrease in weight by half an ounce
*when his mother decides to smoke an additional cigarette a day during pregnancy
*** this is a statistically significant outcome 

summarize 

ttest anycig=0
reg bwght anycig if anycig==0
reg bwght cigs if anycig==0


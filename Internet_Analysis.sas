/* import data */
proc import datafile='/home/u61251187/sasuser.v94/Internet_Dataset.csv'
out=Internet replace dbms=csv;
run;

/*#Task 1: The team wants to analyze each variable of the data collected through data summarization to get a basic understanding of the dataset and to prepare for further analysis.*/
proc means data=Internet;
run;

/*Task 2: As mentioned earlier, a unique page view represents the number of sessions during which that page was viewed one or more times. A visit counts all instances, no matter how many times the same visitor may have been to your site. So the team needs to know whether the unique page view value depends on visits.*/
/* Correlation */
proc corr data = Internet;
var Uniquepageviews Visits;
run;

proc anova plots(maxpoints=none) data=Internet;
class Visits;
model Uniquepageviews=Visits;
means Visits/ alpha=0.05;
run;

/*Task 3: Find out the probable factors from the dataset, which could affect the exits. Exit Page Analysis is usually required to get an idea about why a user leaves the website for a session and moves on to another one. Please keep in mind that exits should not be confused with bounces.*/
ods graphics on / DISCRETEMAX=1400;
proc glm  data=Internet;
class Bounces Continent Sourcegroup Timeinpage Uniquepageviews Visits;
model Exits=Bounces Continent Sourcegroup Timeinpage Uniquepageviews Visits;
means Bounces Continent Sourcegroup Timeinpage Uniquepageviews Visits / alpha=0.05;
run;
ods graphics off;

/*Task 4: Every site wants to increase the time on page for a visitor. This increases the chances of the visitor understanding the site content better and hence there are more chances of a transaction taking place. Find the variables which possibly have an effect on the time on page.*/
ods graphics on / DISCRETEMAX=1400;
proc glm data=Internet;
class Bounces Continent Sourcegroup Exits Uniquepageviews Visits;
model Timeinpage=Bounces Continent Sourcegroup Exits Uniquepageviews Visits;
means Bounces Continent Sourcegroup Exits Uniquepageviews Visits / alpha=0.05;
run;
ods graphics off;

/*Task 5: A high bounce rate is a cause of alarm for websites which depend on visitor engagement. Help the team in determining the factors that are impacting the bounce.*/
ods graphics on / DISCRETEMAX=1400;
proc glm data=Internet;
class Continent Sourcegroup Exits Uniquepageviews Visits Timeinpage;
model BouncesNew=Continent Sourcegroup Exits Uniquepageviews Visits Timeinpage;
means Continent Sourcegroup Exits Uniquepageviews Visits Timeinpage / alpha=0.05;
run;
ods graphics off;


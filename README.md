# Department of Health & Human Services budget 2020-2022

![Dashboard](https://github.com/mccafj/DHHS_budget/blob/main/images/Dashboard%201.png)

After looking for a large data set that would be interesting to work with in SSMS, and would have geographical data that may translate well to a Tableau dashboard, I downloaded data on spending in the Department of Health & Human Services from __[usaspending.gov](https://www.usaspending.gov/download_center/custom_account_data)__.

I selected information on government spending on Health / Health care services for each of the last 3 years.  Below is an example of selected options for the year 2020:

![image](https://user-images.githubusercontent.com/110874108/220733168-ce82f6b7-30cb-40be-8f22-5b437c27cba4.png)

The relevant zip files are in the __[data folder](https://github.com/mccafj/DHHS_budget/tree/main/data)__.

SQL queries involved looking primarily at the Account Balances and the Account Breakdown by Award, including budget outlay and total awards by state & congressional district.  

California and Virgina led in terms of __[total awards by state](https://public.tableau.com/app/profile/jon.mccaffrey/viz/DHHSBudgetData2020-2022/Dashboard1)__:

![Sheet1](https://github.com/mccafj/DHHS_budget/blob/main/images/Sheet%201.png)

Breaking __[total awards down by congressional district](https://public.tableau.com/app/profile/jon.mccaffrey/viz/DHHSBudgetData2020-2022/Dashboard1)__, South Dakota and Alaska are better represented, but that's becuase the "district" appears to be the entire state.  If you zoom in on areas of VA right around Washington D.C., you'll see they received more awards than either of those states.  

![Sheet2](https://github.com/mccafj/DHHS_budget/blob/main/images/Sheet%202.png)

Looking at specific dollar __[amounts budgeted and outlayed by federal account](https://public.tableau.com/app/profile/jon.mccaffrey/viz/DHHSBudgetData2020-2022/Dashboard1)__ yields more information on recent priorities for government health spending, though I elected to remove total dollar amounts for emergency funding (which dwarfed all other spending) because the pandemic likely caused that to balloon, and I was more interested in health spending without respect to the pandemic.  Emergency funding can still be seen by adjusting filters in Tableau.  

![Sheet3](https://github.com/mccafj/DHHS_budget/blob/main/images/Sheet%203.png)

![Sheet4](https://github.com/mccafj/DHHS_budget/blob/main/images/Sheet%204.png)

Thanks for reading!  I enjoyed this SQL exercise, as it gave me more hands-on practice with joins, temp tables, CTEs, and views.

Any questions / comments, let me know
- Jon

jonmccaffrey524@gmail.com 

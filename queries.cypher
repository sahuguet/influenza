-- Find orgs that have some issues with Doj and who are lending money to people with influnce over DoJ.
MATCH (doj:`Government Organization` {name:"Department of Justice"})
MATCH (doj)-[r:`Regulatory Action`]->(org:`Private Sector Organization`)
MATCH (org)-[d:Debt]->(org2:`Private Sector Organization`)
MATCH (owner:`Person`)-[:Owner]->(org2)
WHERE (owner)-[:`Direct Report`|:`Runs`*]->(doj)
RETURN org, org2, owner

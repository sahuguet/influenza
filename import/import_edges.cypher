
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_gov_people.csv" AS row
MATCH (g:GovernmentOrg {name: row.FromName})
MATCH (p:Person {name: row.ToName})
MERGE (g)-[:EMPLOYS]->(p);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_gov_cos.csv" AS row
MATCH (g:GovernmentOrg {name: row.FromName})
MATCH (c:Company {name: row.ToName})
MERGE (g)-[:REGULATES]->(c);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_nonprofits_people.csv" AS row
MATCH (n:Nonprofit {name: row.FromName})
MATCH (p:Person {name: row.ToName})
MERGE (p)-[:PAYS]->(p);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_people_cabinet.csv" AS row
MATCH (p:Person {name: row.FromName})
MATCH (c:CabinetPosition {name: row.ToName})
MERGE (p)-[:NOMINEE]->(c);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_people_cos.csv" AS row
MATCH (p:Person {name: row.FromName})
MATCH (c:Company {name: row.ToName})
FOREACH (t in CASE when row.Edge="Owner" THEN [1] ELSE [] END |
         MERGE (p)-[:OWNS]->(c) )
FOREACH (t in CASE when row.Edge="Advised" THEN [1] ELSE [] END |
         MERGE (p)-[:ADVISES]->(c) );

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_people.csv" AS row
MATCH (p1:Person {name: row.FromName})
MATCH (p2:Person {name: row.ToName})
FOREACH (t in CASE when row.Edge="Campaign Contribution" THEN [1] ELSE [] END |
         MERGE (p1)-[:CONTRIBUTED]->(p2) )
FOREACH (t in CASE when row.Edge="Reports To" THEN [1] ELSE [] END |
         MERGE (p1)-[:REPORTS_TO]->(p2) )
FOREACH (t in CASE when row.Edge="Direct Report" THEN [1] ELSE [] END |
         MERGE (p1)-[:REPORTS_TO]->(p2) )
FOREACH (t in CASE when row.Edge="Nominated" THEN [1] ELSE [] END |
         MERGE (p1)-[:NOMINATED]->(p2) )
FOREACH (t in CASE when row.Edge="Married" THEN [1] ELSE [] END |
         MERGE (p1)-[:MARRIED]->(p2) );

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_people_nonprofits.csv" AS row
MATCH (p:Person {name: row.FromName})
MATCH (n:Nonprofit {name: row.ToName})
MERGE (p)-[:FOUNDED]->(n);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_people_gov.csv" AS row
MATCH (p:Person {name: row.FromName})
MATCH (g:GovernmentOrg {name: row.ToName})
FOREACH (t in CASE when row.Edge="Runs" THEN [1] ELSE [] END |
         MERGE (p)-[:RUNS]->(g) )
FOREACH (t in CASE when row.Edge="Member" THEN [1] ELSE [] END |
         MERGE (p)-[:MEMBER]->(g) )
FOREACH (t in CASE when row.Edge="Employed by" THEN [1] ELSE [] END |
         MERGE (p)-[:EMPLOYED_BY]->(g) );

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_people_committees.csv" AS row
MATCH (p:Person {name: row.FromName})
MATCH (c:Committee {name: row.ToName})
MERGE (p)-[:MEMBER]->(c);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_people_ambassador.csv" AS row
MATCH (p:Person {name: row.FromName})
MATCH (a:Ambassador {country: row.ToName})
MERGE (p)-[:MEMBER]->(c);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_political_people.csv" AS row
MATCH (o:PoliticalOrg {name: row.FromName})
MATCH (p:Person {name: row.ToName})
MERGE (o)-[:EMPLOYS]->(p);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_cos_people.csv" AS row
MATCH (c:Company {name: row.FromName})
MATCH (p:Person {name: row.ToName})
FOREACH (t in CASE when row.Edge="Campaign Contribution" THEN [1] ELSE [] END |
         MERGE (c)-[:CONTRIBUTED]->(p) )
FOREACH (t in CASE when row.Edge="PAC Contribution" THEN [1] ELSE [] END |
         MERGE (c)-[:CONTRIBUTED]->(p) )
FOREACH (t in CASE when row.Edge="Employs" THEN [1] ELSE [] END |
         MERGE (c)-[:EMPLOYS]->(p) )
FOREACH (t in CASE when row.Edge="Owned by" THEN [1] ELSE [] END |
         MERGE (c)-[:OWNED_BY]->(p) );

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_companies.csv" AS row
MATCH (c1:Company {name: row.FromName})
MATCH (c2:Company {name: row.ToName})
FOREACH (t in CASE when row.Edge="Debt" THEN [1] ELSE [] END |
         MERGE (c1)-[:DEBT]->(c2) )
FOREACH (t in CASE when row.Edge="Owns" THEN [1] ELSE [] END |
         MERGE (c1)-[:OWNS]->(c2) );

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_school_people.csv" AS row
MATCH (s:School {name: row.FromName})
MATCH (p:Person {name: row.ToName})
MERGE (s)-[:EMPLOYS]->(p);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/edges_committee_cabinet.csv" AS row
MATCH (c1:Committee {name: row.FromName})
MATCH (c2:CabinetPosition {name: row.ToName})
MERGE (c1)-[:CONFIRMS]->(c2);


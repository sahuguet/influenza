
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_ambassadors.csv" AS row
CREATE (:Ambassador {name: row.Description, country: row.Name});
CREATE CONSTRAINT ON (a:Ambassador) ASSERT a.name IS UNIQUE; // constraint creates implicit index
CREATE INDEX ON :Ambassador(country);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_cabinet_positions.csv" AS row
CREATE (:CabinetPosition {name: row.Name});
CREATE CONSTRAINT ON (c:CabinetPosition) ASSERT c.name IS UNIQUE;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_gov_orgs.csv" AS row
CREATE (:GovernmentOrg {name: row.Name, description: row.Description});
CREATE CONSTRAINT ON (g:GovernmentOrg) ASSERT g.name IS UNIQUE;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_committees.csv" AS row
CREATE (:Committee {name: row.Name, committeeType: row.Type, description: row.Description});
CREATE CONSTRAINT ON (n:Nonprofit) ASSERT n.name IS UNIQUE;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_nonprofits.csv" AS row
CREATE (:Nonprofit {name: row.Name});
CREATE CONSTRAINT ON (n:Nonprofit) ASSERT n.name IS UNIQUE;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_people.csv" AS row
CREATE (:Person {name: row.Name, governmentPosition: row.GovernmentPosition, privatePosition: row.PrivateSectorPosition, state: row.State });
CREATE CONSTRAINT ON (p:Person) ASSERT p.name IS UNIQUE;
CREATE INDEX ON :Person(state);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_political_orgs.csv" AS row
CREATE (:PoliticalOrg {name: row.Name});
CREATE CONSTRAINT ON (p:PoliticalOrg) ASSERT p.name IS UNIQUE;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_companies.csv" AS row
CREATE (:Company {name: row.Name});
CREATE CONSTRAINT ON (c:Company) ASSERT c.name IS UNIQUE;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_universities.csv" AS row
CREATE (:School {name: row.Name, schoolType: row.Type});
CREATE CONSTRAINT ON (s:School) ASSERT s.name IS UNIQUE;


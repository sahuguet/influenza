
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_cabinet_positions.csv" AS row
CREATE (:CabinetPosition {name: row.Name});

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_committees.csv" AS row
CREATE (:Committee {name: row.Name, committeeType: row.Type, description: row.Description});

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_gov_orgs.csv" AS row
CREATE (:GovernmentOrg {name: row.Name, description: row.Description});

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_people.csv" AS row
CREATE (:Person {name: row.Name, governmentPosition: row.GovernmentPosition, privatePosition: row.PrivateSectorPosition, state: row.State });

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_political_orgs.csv" AS row
CREATE (:PoliticalOrg {name: row.Name});

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_companies.csv" AS row
CREATE (:Company {name: row.Name});

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///tmp/nodes_universities.csv" AS row
CREATE (:School {name: row.Name, schoolType: row.Type});

// CREATE INDEX ON :CabinetPosition(name);
CREATE CONSTRAINT ON (c:CabinetPosition) ASSERT c.name IS UNIQUE;

// CREATE INDEX ON :Committee(name);
CREATE CONSTRAINT ON (c:Committee) ASSERT c.name IS UNIQUE;

// CREATE INDEX ON :GovernmentOrg(name);
CREATE CONSTRAINT ON (g:GovernmentOrg) ASSERT g.name IS UNIQUE;

// CREATE INDEX ON :Person(name);
CREATE INDEX ON :Person(state);
CREATE CONSTRAINT ON (p:Person) ASSERT p.name IS UNIQUE;

// CREATE INDEX ON :PoliticalOrg(name);
CREATE CONSTRAINT ON (p:PoliticalOrg) ASSERT p.name IS UNIQUE;

// CREATE INDEX ON :Company(name);
CREATE CONSTRAINT ON (c:Committee) ASSERT c.name IS UNIQUE;

// CREATE INDEX ON :School(name);
CREATE CONSTRAINT ON (s:School) ASSERT s.name IS UNIQUE;


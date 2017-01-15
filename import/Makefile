
.PHONY: default

SH=/bin/bash

NEO4J_HOME=/usr/local/Cellar/neo4j/3.0.0
DB=$(NEO4J_HOME)/libexec/data/databases/graph.db

NODES_SOURCE=import_nodes.cypher
EDGES_SOURCE=import_edges.cypher

# ASSUME: nodes.csv with CSV dump of nodes sheet
# ASSUME: edges.csv with CSV dump of edges sheet

default:
	$(SH) filter_node_csv.sh
	$(SH) filter_edge_csv.sh
	neo4j-shell -path influenza.db -file $(NODES_SOURCE)
	neo4j-shell -path influenza.db -c 'schema await'
	neo4j-shell -path influenza.db -file $(EDGES_SOURCE)
	mv -f $(DB) $(NEO4J_HOME)/libexec/data/databases/old.db
	mv influenza.db $(DB)


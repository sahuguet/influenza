
.PHONY: default

NEO4J_HOME=/usr/local/Cellar/neo4j/3.0.0
DB=$(NEO4J_HOME)/libexec/data/databases/graph.db

NODES_SOURCE=import_nodes.cypher
EDGES_SOURCE=import_edges.cypher

default:
	curl -s -L -o nodes.csv https://docs.google.com/spreadsheets/d/1xfVnkYjQKs3DHvhgRhMLz9W6MG6dcfU0yHcRmMX8h7c/export?format=csv&id=1xfVnkYjQKs3DHvhgRhMLz9W6MG6dcfU0yHcRmMX8h7c&gid=0
	sh filter_node_csv.sh
	curl -s -L -o edges.csv https://docs.google.com/spreadsheets/d/1xfVnkYjQKs3DHvhgRhMLz9W6MG6dcfU0yHcRmMX8h7c/export?format=csv&id=1xfVnkYjQKs3DHvhgRhMLz9W6MG6dcfU0yHcRmMX8h7c&gid=752680471
	sh filter_edge_csv.sh
	neo4j-shell -path influenza.db -file $(NODES_SOURCE)
	neo4j-shell -path influenza.db -c 'schema await'
	neo4j-shell -path influenza.db -file $(EDGES_SOURCE)
	rm -rf $(NEO4J_HOME)/libexec/data/databases/old.db
	mv -f $(DB) $(NEO4J_HOME)/libexec/data/databases/old.db
	mv influenza.db $(DB)


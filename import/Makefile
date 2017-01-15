
.PHONY: default

NEO4J_HOME=/usr/local/Cellar/neo4j/3.0.0
DB=$(NEO4J_HOME)/libexec/data/databases/graph.db

NODES_SOURCE=import_nodes.cypher
EDGES_SOURCE=import_edges.cypher

default:
	#mv -f ~/Downloads/Debug\ Politics\ -\ Influenza\ -\ Nodes.csv nodes.csv
	sh filter_node_csv.sh
	#mv -f ~/Downloads/Debug\ Politics\ -\ Influenza\ -\ Edges.csv edges.csv
	sh filter_edge_csv.sh
	neo4j-shell -path influenza.db -file $(NODES_SOURCE)
	neo4j-shell -path influenza.db -c 'schema await'
	neo4j-shell -path influenza.db -file $(EDGES_SOURCE)
	rm -rf $(NEO4J_HOME)/libexec/data/databases/old.db
	mv -f $(DB) $(NEO4J_HOME)/libexec/data/databases/old.db
	mv influenza.db $(DB)


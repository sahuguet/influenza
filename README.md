# influenza
A graph database debugging tool for US politics (Debug Politics Hackathon, Jan 2017, NYC)

## How to set-up Neo4j on your local machine
See tutorial at https://neo4j.com/developer/docker/#_how_to_use_the_neo4j_docker_image .

```
docker run \
    --publish=7474:7474 --publish=7687:7687 \
    --volume=$HOME/neo4j/data:/data \
    --volume=$HOME/neo4j/logs:/logs \
    neo4j:3.0
```
## How to query the Neo4j database
https://neo4j.com/docs/cypher-refcard/current/

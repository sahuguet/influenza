
echo "Filtering nodes"

head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_cabinet_positions.csv
grep '^Cabinet Position' nodes.csv >> /tmp/nodes_cabinet_positions.csv

head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_committees.csv
grep '^Committee' nodes.csv >> /tmp/nodes_committees.csv
grep '^Senate Committee' nodes.csv >> /tmp/nodes_committees.csv

head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_gov_orgs.csv
grep '^Government Organization' nodes.csv >> /tmp/nodes_gov_orgs.csv

head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_people.csv
grep '^Person' nodes.csv >> /tmp/nodes_people.csv

head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_political_orgs.csv
grep '^Political Organization' nodes.csv >> /tmp/nodes_political_orgs.csv

head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_companies.csv
grep '^Private Sector Company' nodes.csv >> /tmp/nodes_companies.csv

head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_universities.csv
grep '^Private University' nodes.csv >> /tmp/nodes_universities.csv
grep '^Public University' nodes.csv >> /tmp/nodes_universities.csv

echo "Filtered nodes"


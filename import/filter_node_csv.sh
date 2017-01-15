
# To list node types: cut -d, -f1 nodes.csv | sort -u

echo "Filtering nodes"

echo "Ambassador"
head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_ambassadors.csv
grep '^Ambassador' nodes.csv >> /tmp/nodes_ambassadors.csv

echo "CabinetPosition"
head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_cabinet_positions.csv
grep '^Cabinet Position' nodes.csv >> /tmp/nodes_cabinet_positions.csv

echo "GovernmentOrg"
head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_gov_orgs.csv
grep '^Government Organization' nodes.csv >> /tmp/nodes_gov_orgs.csv

echo "Committee"
head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_committees.csv
grep '^House Committee' nodes.csv >> /tmp/nodes_committees.csv
grep '^Senate Committee' nodes.csv >> /tmp/nodes_committees.csv
grep '^Joint Committee' nodes.csv >> /tmp/nodes_committees.csv

echo "Nonprofit"
head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_nonprofits.csv
grep '^Nonprofit' nodes.csv >> /tmp/nodes_nonprofits.csv

echo "Person"
head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_people.csv
grep '^Person' nodes.csv >> /tmp/nodes_people.csv

echo "PoliticalOrg"
head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_political_orgs.csv
grep '^Political Organization' nodes.csv >> /tmp/nodes_political_orgs.csv

echo "Company"
head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_companies.csv
grep '^Private Sector Company' nodes.csv >> /tmp/nodes_companies.csv

echo "School"
head -1 nodes.csv | perl -pe's/ //g' > /tmp/nodes_universities.csv
grep '^Private University' nodes.csv >> /tmp/nodes_universities.csv
grep '^Public University' nodes.csv >> /tmp/nodes_universities.csv

echo "Filtered nodes"
for file in /tmp/nodes_*.csv; do
  echo "$file: " `tail -n +2 $file | wc -l`
done



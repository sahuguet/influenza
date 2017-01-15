
# To list edge types:
# ruby -r csv -ne'row = CSV.parse($_).first; puts "#{row[0]} -#{row[2]}-> #{row[3]}".inspect' edges.csv | sort -u

echo "Filtering edges"

echo "Government Organization -Employs-> Person"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_gov_people.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Government Organization" && row[3] == "Person"' edges.csv >> /tmp/edges_gov_people.csv

echo "Government Organization -Regulatory Action-> Private Sector Company"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_gov_cos.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Government Organization" && row[3] == "Private Sector Company"' edges.csv >> /tmp/edges_gov_cos.csv

echo "Nonprofit -Pays-> Person"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_nonprofits_people.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Nonprofit" && row[3] == "Person"' edges.csv >> /tmp/edges_nonprofits_people.csv

echo "Person -Advised-> Private Sector Company"
echo "Person -Owner-> Private Sector Company"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people_cos.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Person" && row[3] == "Private Sector Company"' edges.csv >> /tmp/edges_people_cos.csv

echo "Person -Campaign Contribution-> Person"
echo "Person -Married-> Person"
echo "Person -Nominated-> Person"
echo "Person -Direct Report-> Person"
echo "Person -PAC Contribution-> Person"
echo "Person -Reports To-> Person"
echo "Person -Parent-> Person"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Person" && row[3] == "Person"' edges.csv >> /tmp/edges_people.csv

echo "Person -Founded-> Nonprofit"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people_nonprofits.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Person" && row[3] == "Nonprofit"' edges.csv >> /tmp/edges_people_nonprofits.csv

echo "Person -Member-> Government Organization"
echo "Person -Runs-> Government Organization"
echo "Person -Employed by-> Government Organization"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people_gov.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Person" && row[3] == "Government Organization"' edges.csv >> /tmp/edges_people_gov.csv

echo "Person -Member-> House Committee"
echo "Person -Member-> Joint Committee"
echo "Person -Member-> Senate Committee"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people_committees.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Person" && ( row[3] =~ /Committee$/ )' edges.csv >> /tmp/edges_people_committees.csv

echo "Person -Nominee-> Ambassador"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people_ambassador.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Person" && row[3] == "Ambassador"' edges.csv >> /tmp/edges_people_ambassador.csv

echo "Person -Nominee-> Cabinet Position"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people_cabinet.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Person" && row[3] == "Cabinet Position"' edges.csv >> /tmp/edges_people_cabinet.csv

echo "Senate Committee -Confirms Nominee-> Ambassador"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_committee_ambassador.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if (row[0] =~ /Committee$/) && row[3] == "Ambassador"' edges.csv >> /tmp/edges_committee_ambassador.csv

echo "Political Organization -Employs-> Person"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_political_people.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Political Organization" && row[3] == "Person"' edges.csv >> /tmp/edges_political_people.csv

echo "Private Sector Company -Campaign Contribution-> Person"
echo "Private Sector Company -Employs-> Person"
echo "Private Sector Company -PAC Contribution-> Person"
echo "Private Sector Company -Owned by-> Person"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_cos_people.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Private Sector Company" && row[3] == "Person"' edges.csv >> /tmp/edges_cos_people.csv

echo "Private Sector Company -Debt-> Private Sector Company"
echo "Private Sector Company -Owns-> Private Sector Company"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_companies.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if row[0] == "Private Sector Company" && row[3] == "Private Sector Company"' edges.csv >> /tmp/edges_companies.csv

echo "Private University -Employs-> Person"
echo "Public University -Employs-> Person"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_school_people.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if (row[0] =~ /University$/) && row[3] == "Person"' edges.csv >> /tmp/edges_school_people.csv

echo "Senate Committee -Confirms Nominee-> Cabinet Position"
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_committee_cabinet.csv
ruby -r csv -ne'row = CSV.parse($_).first; puts $_ if (row[0] =~ /Committee$/) && row[3] == "Cabinet Position"' edges.csv >> /tmp/edges_committee_cabinet.csv

echo "Filtered edges"
for file in /tmp/edges_*.csv; do
  echo "$file: " `tail -n +2 $file | wc -l`
done


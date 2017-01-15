
# Confirms Nominee

# company-company edges
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_companies.csv
grep ',Debt,' edges.csv >> /tmp/edges_companies.csv
grep ',Owns,' edges.csv >> /tmp/edges_companies.csv

# person-person edges
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people.csv
grep ',Reports To,' edges.csv >> /tmp/edges_people.csv
grep ',Direct Report,' edges.csv >> /tmp/edges_people.csv
grep ',Nominated,' edges.csv >> /tmp/edges_people.csv
grep ',Married,' edges.csv >> /tmp/edges_people.csv

# person-gov org edges
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people_gov.csv
grep ',Runs,' edges.csv >> /tmp/edges_people_gov.csv
grep ',Member,' edges.csv >> /tmp/edges_people_gov.csv

# person-company edges
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people_cos.csv
grep ',Owner,' edges.csv >> /tmp/edges_people_cos.csv
grep ',Advised,' edges.csv >> /tmp/edges_people_cos.csv

# company-person edges
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_cos_people.csv
grep ',Campaign Contribution,' edges.csv >> /tmp/edges_cos_people.csv
grep ',PAC Contribution,' edges.csv >> /tmp/edges_cos_people.csv
grep ',Employs,' edges.csv >> /tmp/edges_cos_people.csv

# gov org-company edges
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_gov_cos.csv
grep ',Regulatory Action,' edges.csv >> /tmp/edges_gov_cos.csv

# person-cabinet edges
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_people_cabinet.csv
grep ',Nominee,' edges.csv >> /tmp/edges_people_cabinet.csv

# committee-cabinet edges
head -1 edges.csv | perl -pe's/ //g' > /tmp/edges_committee_cabinet.csv
grep ',Committee Nominee,' edges.csv >> /tmp/edges_committee_cabinet.csv


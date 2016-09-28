download:
	# Get the database and its structure
	wget https://raw.githubusercontent.com/genome/dgi-db/master/db/structure.sql
	wget http://dgidb.genome.wustl.edu/downloads/data.sql

postgres:
	# Start up postgres with access to this directory under /data
	docker run -d  --name postgres \
		-v `pwd`/data:/var/lib/postgresql/data \
		-v `pwd`:/data \
		postgres

import:
	# Import the dgidb and the fda list into postrgres
	docker exec -it postgres psql -h localhost -U postgres -c "create database dgidb"
	docker exec -it postgres psql -h localhost -U postgres -d dgidb -f /data/structure.sql
	docker exec -it postgres psql -h localhost -U postgres -d dgidb -f /data/data.sql
	docker exec -it postgres psql -h localhost -U postgres -d dgidb \
		-c "create table fda_drugs (name character varying(255))"
	docker exec -it postgres psql -h localhost -U postgres -d dgidb \
		-c "copy fda_drugs from '/data/fda_drugs.csv'"
	
extract:
	docker exec -it postgres psql -h localhost -U postgres -d dgidb \
		-t -A -F'	' -f /data/extract.sql -o /data/fda_drugs.gmt

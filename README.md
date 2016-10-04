# medbook-dgidb
Scripts to extract gene to drug interactions from DGIdb into a gmt file

See the Makefile for details but on a bare machine:

make download postgres import extract

Will download the latest schema database for DGIdb, run postgres in a 
docker container, import the DGIdb data and a list of FDA approved drugs
and then get the union of that and dump it to fda_drugs.gmt.

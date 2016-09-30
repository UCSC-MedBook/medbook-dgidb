select 'green erase', drug_claims.primary_name, array_to_string(array_agg(distinct genes.name), '	')
from drug_claims
inner join fda_drugs on fda_drugs.name = drug_claims.primary_name
inner join interaction_claims on drug_claims.id = interaction_claims.drug_claim_id
inner join gene_claims on gene_claims.id = interaction_claims.gene_claim_id
inner join gene_claims_genes on gene_claims_genes.gene_claim_id = interaction_claims.gene_claim_id
inner join genes on gene_claims_genes.gene_id = genes.id
group by drug_claims.primary_name

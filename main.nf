nextflow.enable.dsl=2

include { twas_vcf_1 } from './modules/twas_vcf_1/module.nf'
include { gwas_vcf_regenie_1 } from './modules/gwas_vcf_regenie_1/module.nf'

workflow {
input1 = Channel.fromPath(params.twas_vcf_1.ch_gene_annotations)
input2 = Channel.fromPath(params.twas_vcf_1.ch_codon_file)
input3 = Channel.fromPath(params.twas_vcf_1.ch_priority_file)
input4 = Channel.fromPath(params.twas_vcf_1.ch_ref_fasta)
input5 = Channel.fromPath(params.twas_vcf_1.ch_ref_fasta_index)
input6 = Channel.fromPath(params.twas_vcf_1.ch_ld_reference)
input7 = Channel.fromPath(params.twas_vcf_1.ch_eqtl_weights)
input8 = Channel.fromPath(params.twas_vcf_1.ch_gwas_sumstats)
input9 = Channel.fromPath(params.gwas_vcf_regenie_1.ch_user_input_vcf)
input10 = Channel.fromPath(params.gwas_vcf_regenie_1.ch_king_reference_data).splitCsv(sep: ';').map { row -> tuple(evaluate(row[0]), row[1], row[2], row[3]) }
input11 = Channel.fromPath(params.gwas_vcf_regenie_1.ch_input_pheno_transform)
input12 = Channel.fromPath(params.gwas_vcf_regenie_1.ch_high_ld_regions)
input13 = Channel.fromPath(params.gwas_vcf_regenie_1.ch_gwas_cat)
input14 = Channel.fromPath(params.gwas_vcf_regenie_1.ch_ld_scores)
input15 = Channel.fromPath(params.gwas_vcf_regenie_1.ch_pheno)
twas_vcf_1(input1, input2, input3, input4, input5, input6, input7, input8)
gwas_vcf_regenie_1(input9, input10, input11, input12, input13, input14, input15)
}



//Build GRCh37-lite index for CICERO 
process STAR_index {
	publishDir "$params.star_index_out"

	//input genome fasta and gtf
	input: 
	path fasta
	path gtf
	
	//output the index into a diretory, and the logfile
	output:
	path "*/GenomeDir"
	path "Log.out"

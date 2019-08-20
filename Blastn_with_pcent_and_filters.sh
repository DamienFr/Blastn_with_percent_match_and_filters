#!/bin/bash

file=xxx.fasta
database=xxx.fasta
min_pcent_query=0
min_pcent_subject=0
min_id=0

if ! blastn -version | grep -q "2.9"; then echo "Code developped for Blast+ v.2.9.0, might or might not work with other blast+ versions"; fi

if ( ! grep -q "," $file ) && ( ! grep -q "," $database ); then

makeblastdb -in ${database} -dbtype nucl -parse_seqids -out db -title "DB_"
blastn  -num_alignments 1000000 -query ${file} -out resultat_blast.tmp -task blastn -db db -outfmt '10 std qlen slen gaps'
echo "qseqid,sseqid,pcent_length_QUERY,pcent_length_SUBJECT,pident Percentage of identical matches,Alignment length,Number of mismatch,Number of gap openings,Start of alignment in query,End of alignment in query,Start of alignment in subject(ref),End of alignment in subject(ref),evalue,bitscore,Query_seq_len,Sbjct_seq_len, gaps" > res_${file}_on_${database}
env min_pcent_query=$min_pcent_query min_pcent_subject=$min_pcent_subject min_id=$min_id perl -F',' -ane '$qlength = 100*$F[3]/$F[12]; $slength = 100*$F[3]/$F[13]; if( $qlength > $ENV{min_pcent_query} && $slength > $ENV{min_pcent_subject} &&  $F[2] > $ENV{min_id}){$F[2] = $qlength . "," . $slength . "," . $F[2]; $toprint = join(",",@F);print $toprint}' resultat_blast.tmp >> res_${file}_on_${database}
rm -f resultat_blast.tmp

else
printf 'Commas in input file(s), cannot continue because scripts are parsing on commas ...'
fi

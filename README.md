# Blastn_with_percent_match_and_filters

This code block blasts a fasta $file against a fasta $database.
It outputs a 17 columns comma-separated table named res_[$file]_on_[$database].csv with this header :

| qseqid | sseqid | pcent_length_QUERY | pcent_length_SUBJECT | pident Percentage of identical matches | Alignment length | Number of mismatch | Number of gap openings | Start of alignment in query | End of alignment in query | Start of alignment in subject(ref) | End of alignment in subject(ref) | evalue | bitscore | Query_seq_len | Sbjct_seq_len |  gaps |

The two calculated fields "pcent_length_QUERY" and "pcent_length_SUBJECT" correspond to the length of the match compared to the length of the query and of the subject, respectively.

You have to manually change file names and filters values.

The script primarily checks if you have the proper blastn version installed (it should work fine for blast+ 2.2 -> 2.9)


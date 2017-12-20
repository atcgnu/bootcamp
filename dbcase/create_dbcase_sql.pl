my ($input) = @ARGV;


#key="chr:pos:genotyep"
print "CREATE TABLE dbcase (key varchr (50), case_num int (10), info varchr (500));\n";

print "BEGIN;\n";
open IN, "$input" or die $!;
while(<IN>){
    chomp;
#   chr1    4770    .       A       G       1       hom:0,het:1     A/G:1   M:0,F:0,U:1     Case:1,Control:0
    my ($chr, $pos, $rs, $ref, $alt, $case_num, $zygosity, $genotype, $gender, $affected_status) = (split /\t/);
    $chr =~ s/chr//g;
    foreach my $gtc (split /,/, $genotype){
        my ($gt, $count) = (split /:/,$gtc);
        my ($a1, $a2) = (split /\//, $gt);
        print "insert into dbcase values ('$chr:$pos:$a1/$a2\', $count, \'$case_num|$zygosity|$genotype|$gender|$affected_status\');\n";
        print "insert into dbcase values ('$chr:$pos:$a2/$a1\', $count, \'$case_num|$zygosity|$genotype|$gender|$affected_status\');\n" if $gt ne "$a2/$a1";
    }
}
print "COMMIT;\n";

print "create index dbcase_index on dbcase(key);";

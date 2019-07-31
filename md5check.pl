#!/usr/bin/perl
use Digest::MD5;

my ($dir) = @ARGV;


my ($file, $file_md5) = &md5sum_dir($dir);

sub md5sum_dir{
    my ($dir) = @_;
    foreach my $f (glob( "$dir/*" )){
        if(-f $f){
            my ($md5, $f) = &get_md5sum($f);
            print "$f\t$md5\n";
        }elsif(-d $f){
            &md5sum_dir($f);
        }
    }
}

sub get_md5sum{
    my ($f) = @_;
    open( FH, $f ) or die $!;
    binmode(FH);
    my $md5 = Digest::MD5->new->addfile(*FH)->hexdigest;
    return ($md5, $f);
}

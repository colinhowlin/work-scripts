#!/usr/bin/perl
# Quickie script to change read-only to read/write SNMP on a single SM/AP
# Copyright 2009-2016 Joel NewKirk 
# jnewkirk@canmon.us 
# subject to the MIT license as presented here: http://www.opensource.org/licenses/mit-license.php

$|=1;
my $debug=2;
use IO::Socket::INET;

my $ip=shift;
my $canpass=shift;

makewriteable($ip,$canpass);
exit;


sub makewriteable()
{
    my ($ip,$canpass)=@_;
    my $host=$ip.":80";
    my $EOL = "\015\012";
    my $remote=IO::Socket::INET->new($host) or return;
    $remote->autoflush(1);
    print $remote "GET /login.cgi?CanopyUsername=admin&CanopyPassword=".$canpass." HTTP/1.1".$EOL;
    print $remote 'User-Agent: Mozilla/5.0'. $EOL;
    print $remote $EOL;
    print $remote $EOL;
    while (<$remote>) {
        if (/Session=(.*)\"/)
        {
            $sessid=$1;
            my $remote1=IO::Socket::INET->new($host) or next;
            $remote1->autoflush(1);
                    my $remote2=IO::Socket::INET->new($host) or next;
                    $remote2->autoflush(1);
                    print $remote2 "GET /himom.cgi?ok=Save+Changes&1534:SNMPReadOnly=0&Session=$sessid HTTP/1.1".$EOL;
                    print $remote2 'User-Agent: Mozilla/5.0'. $EOL;
                    print $remote2 $EOL;
                    print $remote2 $EOL;
                    print "$host: GET /himom.cgi?ok=Save+Changes&1534:SNMPReadOnly=0&Session=$sessid HTTP/1.1\n";
            last;
        }
    }
}

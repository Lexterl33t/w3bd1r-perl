use strict;
use warnings;
use Term::ANSIColor;
use File::Slurp;
use 5.010;
use LWP::UserAgent();



sub Ascii {
	my $banner = "

 ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄     ▄▄▄▄      ▄▄▄▄▄▄▄▄▄▄▄ 
▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░▌  ▄█░░░░▌    ▐░░░░░░░░░░░▌
▐░▌       ▐░▌ ▀▀▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░░▌▐░░▌    ▐░█▀▀▀▀▀▀▀█░▌
▐░▌       ▐░▌          ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌ ▀▀ ▐░░▌    ▐░▌       ▐░▌
▐░▌   ▄   ▐░▌ ▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌    ▐░░▌    ▐░█▄▄▄▄▄▄▄█░▌
▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░▌       ▐░▌    ▐░░▌    ▐░░░░░░░░░░░▌
▐░▌ ▐░▌░▌ ▐░▌ ▀▀▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌    ▐░░▌    ▐░█▀▀▀▀█░█▀▀ 
▐░▌▐░▌ ▐░▌▐░▌          ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌    ▐░░▌    ▐░▌     ▐░▌  
▐░▌░▌   ▐░▐░▌ ▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▄▄▄▄█░░█▄▄▄ ▐░▌  ▐░▌ 
▐░░▌     ▐░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌
 ▀▀       ▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀ 
    

";
return $banner;
}

sub Copyright {
	print color('yellow');
	print("\t\t\t  [ Dev by Muham'RB ]\n");
	print color('reset');
}

sub lineEscape {
	print("\n");
}

sub Dir {
	my ($website, $wordlist) = @_;
	my @line = read_file($wordlist, chomp => 1);
	my $i = 0;
	my $ua = LWP::UserAgent->new;
	while($i < scalar(@line)) {
		
		my $response = $ua->get($website."/".$line[$i]);

		if (index($response->status_line, "OK") != -1) {
			print color('green');
			print("$website/$line[$i] -> Found\n");
			print color('reset');
		} else {
			print(color('red'));
			print("$website/$line[$i] -> Not Found\n");
			print color('reset');
		}
		$i = $i + 1;
	}
	

}


print color('bold blue');
print(Ascii);
print color('reset');
Copyright;
lineEscape();
lineEscape();
print color('blue');
print('[$] - website: ');
chomp(my $website = <STDIN>);
print color('reset');
print(color('yellow'));
print("URI >> $website");
print(color('reset'));
print("\n");
print color('blue');
print('[$] - Wordlist (path): ');
chomp(my $wordlist = <STDIN>);

print color('reset');
print(color('yellow'));
print("Path >> $wordlist");
print(color('reset'));
print("\n");
Dir($website, $wordlist);

sub hexdump;


hexdump "Hello there.\n";



sub hexdump {

	my $copy = reverse $_[0];

	while(my $ittybit = chop $copy) {

		
		printf "%3x ", ord($ittybit);

	}



}


#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# a perl shell module to handle display output. DOH!
#
#

use pms::tmsg;
use pms::argverify;

sub doh;

sub doh_block {

	doh $_[0];


}

	        #ESC7          = save pos
		#ESC[x;yH      = jump
		#ESC8          = return to saved pos


# -- # ===========
# # -- # 0x1b ESC 0x5b  [  0x32  2  0x4a  J   0x1b ESC 0x5b  [  0x30  0  0x3b  ;  
# # -- # 0x30  0  0x48  H  0x1b ESC 0x5b  [   0x31  1  0x3b  ;  0x33  3  0x31  1  
# # -- # 0x72  r  0x1b ESC 0x5b  [  0x33  3   0x32  2  0x3b  ;  0x31  1  0x48  H  
# # -- # 0x5f  _  0x5f  _  0x5f  _  0x5f  _   0x5f  _  0x5f  _  0x5f  _  0x5f  _  # ESC[1;31r

sub doh {
	my $stuff = $_[0];

	if ( $stuff =~ s/(\x1b\[[0-9]+;[0-9]+r)/\1/ )
	#this is vt100 scrolling area setup
	{
		my $setup = $1;


		
		#Copy out the X and Y value out of the setup
		# which we are going to reconstruct below
		$setup =~ m/([0-9]);([0-9]+)/;

		my $sneezyscrollstart = $1;
		my $sneezyscrollend  = $2;

		tmsg "doh() screen setup sneezy calls for $1 to $2", -1;

		#Adjust the scroll area of the screen to be one smaller
		# so our typing text can go in that area.
		#
		# **** may put an option for 2 smaller and duplicating
		#  the line of dashes to delineate the text entry line

		my $curtaintop = $sneezyscrollstart;
		my $curtainend= $sneezyscrollend-1;

		my $rigged="\x1b[$curtaintop;${curtainend}r";

		tmsg "doh() is calling curtains from $curtaintop to $curtainend", -1;

		#escape the brackets in the setup or perl will error
		$setupre = $setup;
		$setupre =~ s/\[/\\\[/;

		$stuff =~ s/$setupre/$rigged/ ;

		#Finally tell the keypunch handler that a terminal mode is 
		# being set up and what row it should use
		#
		# asdf($y)
	}

	#report on what VT100 shit is going on
	
	##do

	print $stuff;


}





#return true to please perl
;1;

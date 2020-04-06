#read stdin as a single string and not a line at a time
my $whole_file; { local $/; $whole_file = <STDIN> };

# line wrapped in the middle of reference <like this>
# This:
# some text <about
#    a thing> really references <about a thing>
# Turns into:
# some text <about a thing> really references <about a thing>
#
# first capture group gets an unclosed < that looks like a reference
# then uncaptured whitespace around a newline
# second capture group gets the rest of the reference and its closing >
# the replacement has a space in the middle to replace the whitespace that was a newline
$whole_file =~ s/(<[a-z][a-zA-Z: ]*)\s*\n\s*([a-zA-Z: ]+[a-z]>)/$1 $2/g;

# remove linebreaks in paragraph text that put a reference at the beginning of a line
# the only allowed references at the beginning of the line are actual definitions with ::= on the same line
$whole_file =~ s/(\w)\s*\n(<[a-z][a-zA-Z: ]+[a-z]>(?!.*::=))/$1 $2/g;

# print the processed file back out for further processing
print $whole_file;

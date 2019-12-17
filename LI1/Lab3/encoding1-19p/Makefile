file = miSudoku
file1 = teams
file2 = events
file3 = bus

$(file): $(file).pl
	swipl -quiet -O -g main --stand_alone=true -o $(file) -c $(file).pl

$(file1): $(file1).pl
	swipl -quiet -O -g main --stand_alone=true -o $(file1) -c $(file1).pl

$(file2): $(file2).pl
	swipl -quiet -O -g main --stand_alone=true -o $(file2) -c $(file2).pl

$(file3): $(file3).pl
	swipl -quiet -O -g main --stand_alone=true -o $(file3) -c $(file3).pl

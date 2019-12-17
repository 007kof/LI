file = minColoring
file1 = teams
file2 = horaris

$(file): $(file).pl
	swipl -O -g main --stand_alone=true -o $(file) -c $(file).pl

$(file1): $(file1).pl
	swipl -O -g main --stand_alone=true -o $(file1) -c $(file1).pl

$(file2): $(file2).pl
	swipl -O -g main --stand_alone=true -o $(file2) -c $(file2).pl

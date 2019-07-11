evidence(_,6174).
evidence(ListOfNumbers,_):-	
	msort(ListOfNumbers,SortedListOfNumbers),
 	createSmallestNumber(SortedListOfNumbers,SmallestNumberFromList,3),
 	createBiggestNumber(SortedListOfNumbers,BiggestNumberFromList,0),
 	Difference is BiggestNumberFromList - SmallestNumberFromList,
 	write('Difference between :'),write(BiggestNumberFromList), write(' and '),
 	write(SmallestNumberFromList),write(' is: '),write(Difference),nl,
 	createListOfNumbers(Difference,NListOfNumbers),
 	evidence(NListOfNumbers,Difference).

numberphile(Number):-
	nl,
 	createListOfNumbers(Number,ListOfNumbers),
 	constraintCheck(ListOfNumbers,Number),
 	nl,
 	evidence(ListOfNumbers,Number).

createListOfNumbers(Number,[Thousands,Hundreds,Decades,LastDigit]):-
	Thousands is Number // 1000,
 	TotalHundreds is Number mod 1000, Hundreds is TotalHundreds // 100,
 	TotalDecades is Number mod 100,	Decades is TotalDecades // 10,
 	LastDigit is Number mod 10.
	
constraintCheck(AList,Number):-
	atLeastOneDifference(AList),
	Number =< 9999,!,
	write('Given number is OK!!').
constraintCheck(AList,_):-
	not(atLeastOneDifference(AList)),!,
	write('*****Given number is not OK, cause all digits are the same *****'),fail.
constraintCheck(_,Number):-
	not(Number =< 9999),!,
	write('*****Given number is not OK, cause Number is > 9999 *****'),fail.
atLeastOneDifference(AList):-
	member(X,AList),member(Y,AList),
	X\=Y.
createSmallestNumber([],0,_).
createSmallestNumber([FirstNumber|RestList],SmallestNumberFromList,ListsLength):-
	TenInListsLengthPower is 10^ListsLength,
	NSmallestNumberFromList is FirstNumber*TenInListsLengthPower,
	NListsLength is ListsLength - 1,
	createSmallestNumber(RestList,ASmallestNumberFromList,NListsLength),
	SmallestNumberFromList is ASmallestNumberFromList + NSmallestNumberFromList.
	
 	
createBiggestNumber([],0,_).
createBiggestNumber([FirstNumber|RestList],BiggestNumberFromList,ListsLength):-
	TenInListsLengthPower is 10^ListsLength,
	NBiggestNumberFromList is FirstNumber*TenInListsLengthPower,
	NListsLength is ListsLength + 1,
	createBiggestNumber(RestList,ABiggestNumberFromList,NListsLength),
	BiggestNumberFromList is ABiggestNumberFromList + NBiggestNumberFromList.

module fsieve

/*
The Fast Sieve of Eratosthenes.

A sequential and optimized version of the sieve of Eratosthenes.
The program calculates a list of the first NrOfPrime primes.
The result of the program is the NrOfPrimes'th prime.

Strictness annotations have been added because the strictness analyser
is not able to deduce all strictness information. Removal of these !'s
will make the program about 20% slower.

On a machine without a math coprocessor the execution of this
program might take a (very) long time. Set NrOfPrimes to a smaller value.
*/

import StdClass; // RWS
import StdInt, StdReal
     
NrOfPrimes :== 3000 
	
//	The sieve algorithm: generate an infinite list of all primes.

Primes::[Int]
Primes = pr where pr = [5 : Sieve 7 4 pr]

Sieve::Int !Int [Int] -> [Int]
Sieve g i prs
	| IsPrime prs g (toInt (sqrt (toReal g)))	=  [g : Sieve` g i prs]
												=  Sieve (g + i) (6 - i) prs

Sieve`::Int Int [Int] -> [Int]
Sieve` g i prs =  Sieve (g + i) (6 - i) prs

IsPrime::[Int] !Int Int -> Bool
IsPrime [f:r] pr bd | f>bd 			=  True
					| pr rem f==0	=  False
									=  IsPrime r pr bd
								  
//	Select is used to get the NrOfPrimes'th prime from the infinite list.

Select::[x] Int -> x
Select [f:r] 1 =  f
Select [f:r] n =  Select r (n - 1)


/*	The Start rule: Select the NrOfPrimes'th prime from the list of primes
	generated by Primes.
*/

Start::Int
Start = Select [2, 3 : Primes] NrOfPrimes


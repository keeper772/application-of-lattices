############################################################
############################################################
#FUNCTIONS
#returns probability of reversible polynomial by checking 
#reversibility of randomly choosen polynomials from given ring
def random_check(tries, poly_ring):
	reversible = 0
	for i in range(tries):
		rand_poly = poly_ring.random_element()
		try:
			temp = rand_poly ** -1
		except ZeroDivisionError:
			continue
		reversible += 1
	return float(reversible/tries)
#----------------------------------------------------------
#returns calculated probability of reversible poly in given ring
def probability_of_reversable_poly(poly_ring, base):
	probability = 1
	poly_ring.<t> = poly_ring
	with localvars(poly_ring, 't'):
		to_factor = t ** N - 1
		factorials = factor(to_factor)
		for i in factorials:
			probability *= (1 - (1 / base ** (i[0].degree())))
	return float(probability)
#----------------------------------------------------------
def check_impact_of_q_on_probability(N, number_of_primes):
	list_of_primes = Primes()[0:number_of_primes]
	probability_q = []
	probability_q_2 = []
	probability_q_3 = []
	for q in list_of_primes:
		field_q = GF(q)
		poly_ring_q.<v> = PolynomialRing(field_q)
		quot_poly_ring_q.<y> = poly_ring_q.quotient(v ** N - 1)
		probability_q.append(probability_of_reversable_poly(poly_ring_q,q))
		q *= q
		field_q = GF(q)
		poly_ring_q.<v> = PolynomialRing(field_q)
		quot_poly_ring_q.<y> = poly_ring_q.quotient(v ** N - 1)
		probability_q_2.append(probability_of_reversable_poly(poly_ring_q,q))
		q *= q
		field_q = GF(q)
		poly_ring_q.<v> = PolynomialRing(field_q)
		quot_poly_ring_q.<y> = poly_ring_q.quotient(v ** N - 1)
		probability_q_3.append(probability_of_reversable_poly(poly_ring_q,q))
	print "##################################################"
	print "N = " + str(N)
	print "Prime \t\tProbability \tPrime^2 \tProbability \tPrime^3 \tProbability"
	for i in range(number_of_primes):
		print(str(list_of_primes[i]) + '\t\t' +  str(probability_q[i])[0:7] + '\t\t' + str(list_of_primes[i] ** 2) + '\t\t' +str(probability_q_2[i])[0:7] + '\t\t' +str(list_of_primes[i] ** 3) +'\t\t' +str(probability_q_3[i])[0:7])
############################################################
#INPUT DATA
N = 5 #only for random check, overwritten after random check
#p = 5 #must be prime or power of prime
q = 17 #must be prime or power of prime, overwritten after random check
tries = 100000 #number of tries in random reversity check

#STRUCTURES
#field_p = GF(p)
field_q = GF(q)
#poly_ring_p.<z> = PolynomialRing(field_p)
poly_ring_q.<v> = PolynomialRing(field_q)
#quot_poly_ring_p.<x> = poly_ring_p.quotient(z ** N - 1)
quot_poly_ring_q.<y> = poly_ring_q.quotient(v ** N - 1)
############################################################
#MAIN PROGRAM

print "Calculated probability:"
print probability_of_reversable_poly(poly_ring_q,q)
print "Probability based on random polynomials"
print random_check(tries,quot_poly_ring_q)

print "####################################################"
for N in range(2,20):
	check_impact_of_q_on_probability(N,20)

for N in Primes()[0:20]:
	check_impact_of_q_on_probability(N,20)

N = 120
check_impact_of_q_on_probability(N,20)
N = 360
check_impact_of_q_on_probability(N,20)
N = next_prime(N)
check_impact_of_q_on_probability(N,20)
N = 720
check_impact_of_q_on_probability(N,20)
N = next_prime(N)
check_impact_of_q_on_probability(N,20)

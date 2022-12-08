# Check effect on the IPP
import random

ippPast = 150
numOffers = 15
commission = 50
ippLimit = 150

# get 10 random values between 50 and 150
ippsCurrent = random.sample(range(50, 150), 10)

numCurrentOffers = len(ippsCurrent)


# create list called IPPnewlist thats sum of randomList and commsion
# IPPnewlist = [x + commission for x in ippsCurrent]

# get nested list of random values of len 3 for each list
allIPP = [random.sample(range(50, 150), 3) for x in range(10)]
def optimalIPPnewListtoIncreaseIPPnow(allIPP):
    optimalIPPlist = []
    bestIPPnow = (sum(optimalIPPlist) + ippPast) / (len(optimalIPPlist) + numOffers)
    for i in range(len(allIPP)):
        for j in range(len(allIPP[i])):
            optimalIPPlist.append(allIPP[i][j])
            ippNow = (sum(optimalIPPlist) + ippPast) / (len(optimalIPPlist) + numOffers)
            # print(bestIPPnow)
            if ippNow > bestIPPnow:
                bestIPPnow = ippNow
                # bestIPPnow = optimalIPPlist
            optimalIPPlist = []
    # create variable retention that takes into account the number of offers and decreases as bestIPPnow increases
    # variable retention = 1 - (bestIPPnow - ippLimit) / (ippLimit - ippPast)     
    return bestIPPnow, optimalIPPlist

print(optimalIPPnewListtoIncreaseIPPnow(allIPP))
# function to get all combinations of allIPP 

# get new ippsCurrent value by combining ippnewlist WITH ippPast  using mean function taking into account offers
# ippNow = (sum(IPPnewlist) + ippPast) / (len(IPPnewlist) + numOffers)
# ippNow = (sum(IPPnewlist) + ippPast) / (numCurrentOffers + numOffers)

# find the combination of values between each value of ippnewlist and ipplimit that gets the highest value of ippNow

# from ortools.linear_solver import pywraplp
# from ortools.init import pywrapinit


# def main():
#     # Create the linear solver with the GLOP backend.
#     solver = pywraplp.Solver.CreateSolver('GLOP')
#     if not solver:
#         return

#     # Create the variables x and y.
#     x = solver.NumVar(0, 1, 'x')
#     y = solver.NumVar(0, 2, 'y')

#     print('Number of variables =', solver.NumVariables())

#     # Create a linear constraint, 0 <= x + y <= 2.
#     ct = solver.Constraint(0, 2, 'ct')
#     ct.SetCoefficient(x, 1)
#     ct.SetCoefficient(y, 1)

#     print('Number of constraints =', solver.NumConstraints())

#     # Create the objective function, 3 * x + y.
#     objective = solver.Objective()
#     objective.SetCoefficient(x, 3)
#     objective.SetCoefficient(y, 1)
#     objective.SetMaximization()

#     solver.Solve()

#     print('Solution:')
#     print('Objective value =', objective.Value())
#     print('x =', x.solution_value())
#     print('y =', y.solution_value())


# if __name__ == '__main__':
#     pywrapinit.CppBridge.InitLogging('basic_example.py')
#     cpp_flags = pywrapinit.CppFlags()
#     cpp_flags.logtostderr = True
#     cpp_flags.log_prefix = False
#     pywrapinit.CppBridge.SetFlags(cpp_flags)

#     main()
allIPP = [random.sample(range(50, 150), 3) for x in range(10)]



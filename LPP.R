# Operations research
# Linear programming using R

library(lpSolve)
library(igraph)

set.seed(1234)
assign.costs <- matrix(sample(50:100, 16, replace=T), ncol=4)

x <- lp.assign(assign.costs)
x$solution

x$objval


#lp.transport
#Set up the cost matrix by generating integer random numbers between 0 and 1000, without replacement. 
#Consider that will be 8 factories(rows) serving 5 warehouses(cols).
set.seed(1234)
transp.costs <- matrix(sample(0:1000, 40, replace=F), nrow = 8)
transp.costs
row.signs <- rep ("<", 8)
# supply constraint
#Set up the offer constraint by generating integer random numbers between 50 and 300, without replacement.
row.rhs <- sample(50:300, 8, replace=F)
row.rhs

# demand constraint
#Set up the demand constraint by generating integer random numbers between 100 and 500, without replacement.
col.signs <- rep (">", 5)
col.rhs <- sample(100:500, 5, replace=F)
col.rhs

#
sol <- lp.transport (transp.costs, "min", row.signs, row.rhs, col.signs, col.rhs, compute.sens=0)


#Find out which factory will not use all its capacity at the optimal cost solution
sol$solution

#cost associated to the optimal distribution?
sol$objval

#Create adjacency matrix using your solution in order to create a graph using igraph package.
AdjMatrix <- cbind(sol$solution, matrix(rep(0,8*3), ncol=3))
AdjMatrix <- AdjMatrix / AdjMatrix
graph <- graph_from_adjacency_matrix(AdjMatrix, mode = "direct", weighted = NULL)
plot(graph)


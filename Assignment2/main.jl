module SelectionAlgs
# Only once, load all the potentilly necessary libraries

#= import Pkg;
Pkg.add("BenchmarkTools"); #used to test out performance
Pkg.add("Plots");
Pkg.add("LaTeXStrings"); #used for cooler plots
Pkg.add("Random"); #used for shuffle method
 =#
using BenchmarkTools, Plots, LaTeXStrings, Base.Order, Random;

# Include all the functions in the project
include("sort_impl.jl")
include("sesquickselect.jl")
include("se_sesquickselect.jl")
include("plots.jl")
include("theoretical.jl")

export default_quicksort!, adaptative_partition!, 
get_scanned_elements, gSE, empirical_plot;
end

import .SelectionAlgs as sa;

n = 30000; T = 1000
#= 
gSE() = get_scanned_elements(n, T)
println(gSE())
 =#
# values obtained with nu = 
#Sx = [1.99, 2.08, 2.1, 2.13, 2.15, 2.19, 2.17, 2.23, 2.29, 2.28, 2.34, 2.33, 2.28, 2.34, 2.38, 2.35, 2.43, 2.43, 2.45, 2.49, 2.48, 2.49, 2.49, 2.55, 2.6, 2.6, 2.6, 2.59, 2.63, 2.61, 2.59, 2.64, 2.69, 2.7, 2.74, 2.72, 2.73, 2.75, 2.75, 2.8, 2.8, 2.82, 2.76, 2.81, 2.88, 2.87, 2.87, 2.87, 2.84, 2.93, 2.95, 2.94, 2.92, 2.97, 2.97, 3.01, 2.99, 2.99, 2.97, 2.99, 3.05, 3.01, 3.05, 3.05, 3.05, 3.01, 3.04, 3.03, 3.03, 3.09, 3.08, 3.1, 3.13, 3.11, 3.15, 3.12, 3.11, 3.15, 3.15, 3.14, 3.16, 3.2, 3.1, 3.13, 3.16, 3.22, 3.22, 3.19, 3.19, 3.24, 3.24, 3.2, 3.21, 3.26, 3.23, 3.27, 3.23, 3.2, 3.26, 3.25, 3.24, 3.25, 3.32, 3.22, 3.32, 3.26, 3.32, 3.26, 3.29, 3.27, 3.3, 3.33, 3.34, 3.38, 3.35, 3.31, 3.29, 3.37, 3.37, 3.36, 3.36, 3.34, 3.38, 3.33, 3.36, 3.4, 3.33, 3.35, 3.4, 3.38, 3.43, 3.34, 3.44, 3.4, 3.42, 3.37, 3.37, 3.39, 3.35, 3.42, 3.36, 3.37, 3.39, 3.36, 3.44, 3.46, 3.41, 3.37, 3.39, 3.38, 3.35, 3.36, 3.34, 3.41, 3.36, 3.41, 3.4, 3.43, 3.42, 3.42, 3.41, 3.39, 3.38, 3.4, 3.4, 3.4, 3.41, 3.4, 3.36, 3.32, 3.37, 3.37, 3.39, 3.38, 3.38, 3.34, 3.32, 3.35, 3.31, 3.33, 3.32, 3.34, 3.34, 3.28, 3.37, 3.29, 3.29, 3.28, 3.33, 3.3, 3.31, 3.31, 3.31, 3.32, 3.35, 3.31, 3.31, 3.27, 3.34, 3.28, 3.31, 3.28, 3.28, 3.23, 3.27, 3.25, 3.2, 3.28, 3.26, 3.18, 3.25, 3.23, 3.22, 3.23, 3.19, 3.17, 3.19, 3.15, 3.17, 3.13, 3.15, 3.14, 3.09, 3.17, 3.16, 3.13, 3.11, 3.11, 3.07, 3.1, 3.08, 3.07, 3.07, 3.06, 3.08, 3.03, 3.01, 3.05, 3.02, 3.05, 3.08, 3.01, 3.04, 3.02, 2.92, 2.93, 2.91, 2.96, 2.9, 2.92, 2.87, 2.86, 2.91, 2.91, 2.84, 2.85, 2.85, 2.85, 2.75, 2.83, 2.78, 2.76, 2.77, 2.73, 2.68, 2.75, 2.71, 2.7, 2.68, 2.67, 2.68, 2.62, 2.61, 2.62, 2.62, 2.56, 2.52, 2.54, 2.47, 2.49, 2.55, 2.45, 2.48, 2.43, 2.41, 2.39, 2.35, 2.39, 2.34, 2.31, 2.24, 2.24, 2.27, 2.21, 2.23, 2.17, 2.16, 2.11, 2.09, 2.01, 1.99]
I = []; 
for i in range(0, step=max(1, n÷300), stop=n)
    if(i == 0); i +=1; end
    append!(I, i)
end
sa.empirical_plot(I, Sx, n)

#DEBUG ONLY
#= 
error = 0; n=3; T = 500
sorted = 1:n
for r in 1:T
    perm = shuffle(sorted)
    for i in range(0, step=max(1, trunc(Int, n/300)), stop=n)
        if(i == 0); i +=1; end
        v = perm
        element = sa.sesquickselect!(v, i)
        if sorted[i] != element; global error += 1
            println("$r: ", v, "\n====================\n");
        end
    end
end
if (error > 0) println("\n ================================================================ \nErrors commited: ", error); end =#
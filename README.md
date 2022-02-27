# Script for testing of generalized PSB: (SU)pPSB, (SU)gPSB, SGOMS...

This repository content the script used for the testing of variations of generalized PSB. The different update formulas can be tested with local developed function, with a MatLab library of optimization problems or the CUTEst library. 


# Generalities

## Technical limitations

The code has been developed to be run on HPC cluser computing of Ghent University. One of the main limitation is that only compiled MatLab code can be executed. For the use of CUTEst, it means that the selection of the problems has to be done at the moment of the compilation.


## Reference

- Boutet, N., Haelterman, R., & Degroote, J. (2020). Secant update penalized Powell-Symmetric-Broyden. Conference: The 8th International Conference on System Modeling and Optimization (ICSMO 2020) (pp. 27-28).
- Boutet, N., Haelterman, R., & Degroote, J. (2020). Secant update version of quasi-Newton PSB with weighted multisecant equations. Computational Optimization and Applications, 75(2), 441-466.
- Boutet, N., Haelterman, R., & Degroote, J. (2021). New Approach for Secant Update Generalized Version of PSB. International Journal of Modeling and Optimization, 11(4). Conference: The 9th International Conference on System Modeling and Optimization (ICSMO 2021)
- Boutet, N., Haelterman, R., & Degroote, J. (2021). Secant Update generalized version of PSB: a new approach. Computational Optimization and Applications, 78(3), 953-982.
- Boutet, N., Haelterman, R., & Degroote, J. (2021). Quasi-Newton Optimization Methods: Combining Multi-Secant with Symmetry. Conference: SIAM Conference on Optimization (OP21).
- Boutet, N. (2021). Analytical study of multi-secant quasi-Newton methods for optimization problems: approaching the multi-secant property in symmetric quasi-Newton update formulas (Doctoral dissertation, Ghent University).


# How to run

# Content of the code

## a_Test_Script

This is the main subscript of the code. It defines the applicable parameters, call the subfunction and save the results.

The parameters are the following. 
- General running parameters
  - value_deviation: for 0, use the standard starting point. To test sensibility to starting point, we add $\Delta=k \times (1,-1,1,-1,\dots,1,-1)$ to the standard starting point. We devined the standard value [0,1,-10,100]. This value can be given as parameter when running the script, otherwise the script will only use the first value of value_deviation. 
  - type_prob: 1= local problems, 2 Library in MatLab, 3 CUTEst.
  - probs: select one given problem when type_prod=1 or 2.
- convergence criteria
  - tol: tolerance of the solution.
  - MaxIte: maximum number of iterations.
- Initialisation of the first step
  - omega_start: value of omega to define the second point
- line search
  - linesearch: 1 if you want to apply line search. Otherwise 0.
  - mu: parameter of the line search.
  - eta: parameter of the line search.
- Saving
  - fname: name of the file where the data will be saved.


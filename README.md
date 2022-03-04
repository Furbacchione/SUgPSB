# Script for testing of generalized PSB: (SU)pPSB, (SU)gPSB, SGOMS...

This repository content the script used for the testing of variations of generalized PSB. The different update formulas can be tested with local developed function, with a MatLab library of optimization problems or the CUTEst library. 

This is a very short explanation of the code. Feel free to send feedback for part of the explanation that should be more clear or if you find errors or bugs.

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

Script to run the compiled code with CUTest based on the rules of ghent University HPC server are given in map "Scripts". 

My_All_in_one_script contains everything needed: MyCompilationBatch for the compilation with CUTest and MyBadJobscript to run multiple instances of the script for different starting points. Note that you have to compile a distinct file for each CUTest problems.

# Content of the code

I describe below the most important pieces of the code. I probably forgot some of the files. For this reason, I publish also a part of my archives. It means that probably some of the published files are obsolete. 

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
  - Other tolerances of line search are defined in e_line_search
- Saving
  - fname: name of the file where the data will be saved.

Note that the update formula of the algorithms and the choice of the algorithm parameters are done in Auxillary Functions, see below.

The function calls g_Optimization_loop and i_Algo_choice.

## Auxillary_functions

### g_Optimization_loop
Main loop of the screen. It calls: 
- d_Update_Hessian: to compute the new value of the Hessian.
- b_First_step: to compute the second point and the first direction
- c2_adapted_QR: script for adapted QR filtering (for SGOMS in particular). c_new_QR could be also used excepted for SGOMS.
- l_direction_calculation: calculate the direction.
- e_line_search: Apply line search if selected.

### d_Update_Hessian
Here you can define update formulas. The formula must compute the value of BH(:,:,end+1). Parameter direct=1, means BH is in fact B, the estimate of the Hessian. If direct=0, BH is H, the estimate of the inverse of the Hessian. Each method should have a distinct name. 

Parameter[1] is the number of secant equation that are conserved in the calculation. Other parameters can be used freely in the update formula definition.

## i_Algo_choice
Here you define the algorithms that you want to test. Some examples are provided.

## simple_example
Script to call the right functions

### simple_function
Here you can define a simple function and its gradient to test the script locally. For type_prob=1

### more_function
Script to call function from map uncprobs (see below).

### cutest_function
Script to call function from CUTest.

## uncprobs
This is a MatLab library of optimization problem based on the list established by Moré (see Ref in Articles above).

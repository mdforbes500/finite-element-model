# finite-element-model
A 1D finite element model built in MATLAB/Octave for ME 499-005 at George Mason University, Spring 2017.
(CC - BY - SA) 2017

## Overview
This object-oriented program models a one-dimensional (1D) element for finite element modeling (FEM). It is designed to solve problems of the type:

-d/dx[a(x)du/dx] + c(x)u(x) - f(x) = 0 on an interval of x: (0, L)

with boundary conditions of:

u(0) = u_0 , and
[a(x)du/dx]|x=L = Q_o

To solve this family of equations for u(x), it approximates the solution with a number of elements, N. The approximate solution, U, is crafted from the linear combination of approximation functions *psi_0*/ and vlaues of u(x) at various points. The approximation functions are geometrically defined as either quadratic (type 2) or linear (type 1), and allow for interpolation between the values of u(x). 

Since the values of u(x) are not "known" *per se*/, matrix methods are used to find it. The first stage of this is to create an elemental stiffness matrix, K_e representing the interactions of this element with other local elements through the nodes (i.e., the points are which u(x) is being found. After this has been done, the elemental stiffness matrices are assembled into the *global*/ stiffness matrix, K. From this point, depending of what the problem being considered stipulates, the force vector can be inserted into F and the boundary conditions can be inserted into the auxiliary vector, Q. This results in an equation of:

[K]{U} = {F} + {Q}

From this point the inverse of the stiffness matrix can be solved, and U can be determined. 

## Classes
Only one class is defined in this model, the ELEMENT.M class. It specifies the properties of the element. It has independent properties of A_E, C_E, H_E, and TYPE_E; in addition, it has dependent properties K_E, or its elemental stiffness matrix. Within this class, it has two functions:

  ELEMENT(A,C,H,TYPE): This is the constructor for element objects. It sets the respective paramenter equal to each property. Please       note that the TYPE parameter must either be a 1 or 2. Use type 1 for a linear element, and type 2 for a quadratic element. 
  
  STIFFNESS_MATRIX(ELEMENT): This is the method that constructs the elemental stiffness matrix for the element. An element-type object     must be passed through it by parameter, as it will store the variable within the element. 
  
## Additional Functions
Two additional functions are defined within this model. They are defined below:

  ASSEMBLER(TYPE, K_E): This is the function that assembles the elemental stiffness matrix into the global stiffness matrix. 
  
  SOLVER(Q, F, K): This solves the matrix equation for U, the approximate solution.
  
  
## Using the Model
An example script (FINITE_ELEMENT_MODEL_1D.M) of how to set up a problem is given in the repository, and users are encouraged to use it in developing their own code. It can be tailored easily in several ways. Firstly, the domain can be redefined easily through modifying the global nodes (XA and XB). Secondly, the domain can be partitioned, so that different sections of the domain have different elemental domains. Thirdly, the type of the element used may be adjusted easily in the elemental partitions (in linear and quadratic cases). 

N.B.: Different partitions should have the *same*/ type. If different types are used, the assembler will NOT be able to create the global stiffness matrix as quadratic matrices have more nodes than linear ones.  

In addition, when discretizing the model into a number of elements, the number of nodes may easily be adjusted by changing N.

Good luck and happy coding! ~Group Gimli

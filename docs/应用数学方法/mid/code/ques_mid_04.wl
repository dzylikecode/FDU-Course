(* ::Package:: *)

A = {{-1, 1}, {-2, -2}};
A // MatrixForm


Alambda = Eigenvalues[A]


Avector = Eigenvectors[A];
Avector // MatrixForm


Ainv = Inverse[A];
Ainv // MatrixForm


b = {{5}, {-1}}
b // MatrixForm


Ainv . b // MatrixForm


c1 = a1 + I b1;
c2 = a2 + I b2;
$Assumptions = {a1 \[Element] Reals, b1 \[Element] Reals, a2 \[Element] Reals, b2 \[Element] Reals};

x = c1 Exp[Alambda[[1]]] Avector[[1]] + c2 Exp[Alambda[[2]]] Avector[[2]]


Im[x]

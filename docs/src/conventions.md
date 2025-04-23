# Keldysh-Schwinger field theory conventions

## System

```math
\begin{aligned}
S & \left[\psi_{+},\left(\psi_{+}\right)^*, \psi_{-},\left(\psi_{-}\right)^*\right]\\
& =\int \mathrm{d}^d x \mathrm{~d} t^{\prime} 
\left(\psi_{+}\right)^*\left[i \partial_t+D \nabla^2-V(x)\right] \psi_{+} -\left(\psi_{-}\right)^*\left[i \partial_t+D \nabla^2-V(x)\right] \psi_{-}
\\
&
\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad+i\left[L_{+}\left(L_{-}\right)^*-\frac{1}{2}\left(\left(L_{+}\right)^* L_{+}-\left(L_{-}\right)^* L_{-}\right)\right]
\end{aligned}
```

with $\psi_+$ and $\psi_-$ are the bosonic fields on the forward $(+)$ and on backward $(-)$ contour.

We can write this in the Retarded-Advanced-Keldysh (RAK) basis by defining $\psi_c = (\psi_+ + \psi_-)/\sqrt{2}$ and $\psi_1 = (\psi_+ - \psi_-)/\sqrt{2}$. The diffusion part of the action is then

```math
S_{\mathrm{diff}}^{R A K}=\int d t d^d x\left\{\bar{\psi}_q\left[i \partial_t+D \nabla^2-V(\vec{x})\right] \psi_c+\bar{\psi}_c\left[i \partial_t+D \nabla^2-V(\vec{x})\right] \psi_q\right\}.
```

## Green's functions

```math
\begin{aligned}
\hat{G}^{R A K}\left(x_1, x_2\right)
&=\left(\begin{array}{cc}G^K\left(x_1, x_2\right) & G^R\left(x_1, x_2\right) \\ G^A\left(x_1, x_2\right) & 0\end{array}\right) \\
&=-i\left(\begin{array}{cc}\left\langle\phi_c\left(x_1\right) \bar{\phi}_c\left(x_2\right)\right\rangle & \left\langle\phi_c\left(x_1\right) \bar{\phi}_q\left(x_2\right)\right\rangle \\ \left\langle\phi_q\left(x_1\right) \bar{\phi}_c\left(x_2\right)\right\rangle & \left\langle\phi_q\left(x_1\right) \bar{\phi}_q\left(x_2\right)\right\rangle\end{array}\right)
\end{aligned}
```


Two point dressed Green's function $G^{\mu \nu}$ labelled by indices $\mu=c,q$ and $\nu=c,q$ is defined as

```math
i G^{\mu \nu}\left(x_1, x_2\right)=\int \mathcal{D}\left[\phi_c, \bar{\phi}_c, \phi_q, \bar{\phi}_q\right] \phi_\mu\left(x_1\right) \bar{\phi}_\nu\left(x_2\right) e^{i S_0+i S_{\mathrm{int}}}
```

with $S_\mathrm{int} = \int d^{d}x d t \mathcal{L}_\mathrm{int}$ the interaction part of the action.

## Perturbation theory

```math
\begin{aligned}
& i G^{\mu \nu}\left(x_1, x_2\right)=\int \mathcal{D}\left[\phi_c, \bar{\phi}_c, \phi_q, \bar{\phi}_q\right] \phi_\mu\left(x_1\right) \bar{\phi}_\nu\left(x_2\right) \sum_{k=0}^{\infty} \frac{i^k S_{\mathrm{int}}^k}{k!} e^{i S_0}= \\ & \quad=i G_0^{\mu \nu}\left(x_1, x_2\right)+i \int d^d y d t_y\left\langle\phi_\mu\left(x_1\right) \bar{\phi}_\nu\left(x_2\right) \mathcal{L}_{\mathrm{int}}(y)\right\rangle_0+\sum_{k=2}^{\infty}\left\langle\phi_\mu\left(x_1\right) \bar{\phi}_\nu\left(x_2\right) \frac{i^k S_{\mathrm{int}}^k}{k!}\right\rangle_0 .
\end{aligned}
```

The perturbative expansion of the Green's function will have the following structure

```math
\hat{G}=\hat{G}_0+\hat{G}_0 \circ \hat{\Sigma} \circ \hat{G}_0+\hat{G}_0 \circ \hat{\Sigma} \circ \hat{G}_0 \circ \hat{\Sigma} \circ \hat{G}_0+\ldots=\hat{G}_0+\hat{G}_0 \circ \hat{\Sigma} \circ \hat{G}.
```

where $\circ$ is the space-time convolution Keldysh-matrix multiplication and the self-energy $\hat{\Sigma}$ is defined as

```math
\hat{\Sigma}\left(y_1, y_2\right)=\left(\begin{array}{cc}0 & \Sigma^A\left(y_1, y_2\right) \\ \Sigma^R\left(y_1, y_2\right) & \Sigma^K\left(y_1, y_2\right)\end{array}\right).
```

This will give us the Dyson equation

```math
[\hat{G}_0^{-1} -\hat{\Sigma} ]\hat{G}=\mathbb{1}.
```

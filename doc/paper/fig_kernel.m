% plots of ES kernel for paper. Barnett 4/11/17
% needs: vline, ft, gauss.

clear
R = 2.0;           % upsampling ratio
beta = 4;
phi = @(z) exp(beta*(sqrt(1-z.^2)-1)) .* (abs(z)<=1);   % ES kernel
figure; set(gcf,'position',[500 500 1000 300]);
subplot(1,3,1); z = -1.1:1e-3:1.1; plot(z,phi(z),'-'); axis tight
xlabel('$z$','interpreter','latex'); ylabel('$\phi(z)$','interpreter','latex')
hold on; plot([-1 1], phi([-1 1]), 'b.','markersize',10);
text(-1,0.9,'(a)');

subplot(1,3,2);
%ns = 13; beta = 2.3*ns;
beta = 30;
phi = @(z) exp(beta*(sqrt(1-z.^2)-1)) .* (abs(z)<=1);   % ES kernel
z = 0:1e-3:1.1; semilogy(z,phi(z),'-');
xlabel('$z$','interpreter','latex'); ylabel('$\phi(z)$','interpreter','latex')
hold on; plot(1, phi(1), 'b.','markersize',10);
axis([0 max(z) 1e-15 1e0]);
text(0.05,3e-2,'(b)');

subplot(1,3,3);
k=0:1e-2:1.7*beta;
L=1.0; phihat = ft(phi,L,k);   % use quadrature for FT
semilogy(k,abs(phihat),'-'); axis tight;
xlabel('$k$','interpreter','latex');
ylabel('$|\hat\phi(k)|$','interpreter','latex')
vline(beta);
text(beta+1,1e-3,'$k=\beta$','interpreter','latex','color',[1 0 0]);
axis([0 max(k) 1e-15 1e0]);
text(3,1e-2,'(c)');

set(gcf,'paperposition',[0 0 9 2.5]);
print -depsc2 kernel.eps

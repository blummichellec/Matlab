function f = Parzen( D,numbins,numhistbins )
%Parzen Window

%Used to generate a pdf fit to data D
%Input numbins represents the number of bins used for the relative
%frequency distribution histogram

n = size(D,1);

%Function used to indicate desired result of Gaussian PDF
phi = @(x)(1/sqrt(2*pi))*exp(-x.^2/2);

syms x % added

k = 0;
for i = 1:n
%    k = k + phi((D-D(i))/numbins);
    k = k + phi((x-D(i))/numbins); % changed
end

f = (1/(n*numbins)) * k;
t=-3:.01:3; % added
for i=1:length(t) % added
    fplot(i) = double(subs(f,x,t(i))); % added
end
    
figure
subplot(1,2,1)
% histogram(D,numbins)
histogram(D,numhistbins) % changed
subplot(1,2,2)
% plot(f);
plot(t,fplot) % changed

end

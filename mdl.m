% © 2017 MICHELLE BLUM ALL RIGHTS RESERVED

function y = mdl(p,C)
%Function used to create function handle

y = 1./(exp(-(p(1)+p(2)*C(:,1)+p(3)*C(:,2))));

end

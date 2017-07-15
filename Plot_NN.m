% Use this function to plot the Neural Net
% © 2017 MARK DEBONIS ALL RIGHTS RESERVED

function Plot_NN(Wi, Wh, Label, D)

% EX: XOR
% Wi = [0.5 1 1;-1.5 1 1]
% Wh = [-1 0.7 -0.4];
% Label =[-1 1 -1 1];
% D=[1 1;-1 1;-1 -1;1 -1];

C0 = D(find(Label==1),:);
C1 = D(find(Label==-1),:);

MX = max( max(C0(:,1)), max(C1(:,1)) );
mX = min( min(C0(:,1)), min(C1(:,1)) );
Xincr = (MX-mX)/200;
MY = max( max(C0(:,2)), max(C1(:,2)) );
mY = min( min(C0(:,2)), min(C1(:,2)) );
Yincr = (MY-mY)/100;
x = mX:Xincr:MX;
y = mY:Yincr:MY;
figure
hold on
for i = 1:length(x)
    for j = 1:length(y)
        pt = [x(i) y(j)];
        [Net, netk, augY, z] = feedNN(Wi, Wh, [1 pt]);
        if sign(z)==1
            plot(pt(:,1),pt(:,2),'.b');
        else
            plot(pt(:,1),pt(:,2),'.r');
        end
    end
end
plot(C0(:,1),C0(:,2),'y*')
plot(C1(:,1),C1(:,2),'go')

end

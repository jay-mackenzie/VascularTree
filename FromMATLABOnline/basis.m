% start = min(vasc);
% hold on
% 
% qx = quiver3(start(1), start(2), start(3), 10, 0, 0, 'r');
% hold on
% 
% qy = quiver3(start(1), start(2), start(3), 0, 10, 0, 'g');
% qz = quiver3(start(1), start(2), start(3), 0, 0, 10, 'b');


% label(qx,'x', 'location','right')
% label(qy,'y','location','bottom')
% label(qz,'z','location','top')
% axis off equal;view([35 0])
xlabel('x')
ylabel('y')
zlabel('z')

axis equal image
% axis vis3d
view([-45 15])
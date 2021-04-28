% DEFINE FUNCTIONS AND PARAMETERS
model = createpde();

Ru = 20;    %OUTER RING DIAMETER
Ri = 12.5;    %INNER RING DIAMETER
H = 5;      %HEIGHT OF THE RING
h = 0.51;    %HEIGHT OF THE MAGNETIC CHARGE
L = 100;    %SIDE LENGTH OF CUBE
M = 1;      %THE MAGNETIZATION STRENGHT OF THE SOURCES
generate_slices(Ri,Ru,h,H,L, M, model);

%f_cyl = @(r,z) (r<Ru).*(r>Ri).*(abs(z)>(H/2-h)).*(abs(z)<(H/2)).*sign(z).*M;
%f_kart = @(location, state) f_cyl((location.x.^2+location.y.^2).^(1/2),location.z);

%pdegplot(model,'FaceLabels','on','FaceAlpha',0.5)

%Sets the differential equation to be laplace in the whole volume, except
%in the charged areas of the ring.
%specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',f_kart);


%Applies dirichlet conditions on all the cubes faces
for i = 1:6
    applyBoundaryCondition(model,'dirichlet','Face',i,'u',0);
end
%% GENERATE MESH

%Generates the mesh. For finer mesh add both 'Hmax',l as parameters where l is
%max lenght of mesh
%   Det här är BRA ( ͡° ͜ʖ ͡°): 
%   generateMesh(model, 'Hmin', 0.1, 'Hmax', 50, 'Hgrad', 1.02);
%   Åtminstone för L = 500, H = 5, h = 0.51
%   Men gör som du vill, jag är bara en kommentar, inte din morsa
generateMesh(model, 'Hmin', 0.1, 'Hmax', 50, 'Hgrad', 1.02);
% pdeplot3D(model, 'FaceAlpha', 0.5);
disp('Mesh generated')

%% Evan
figure()
ax = gca;
ax.NextPlot = 'replaceChildren';
newEls = [findElements(model.Mesh, 'region', 'cell', 2), findElements(model.Mesh, 'region', 'cell', 3)];
startEls = newEls;
meshIDs = {newEls};
allEls = newEls;
while true
    % Draw and set scale
    pdemesh(model.Mesh.Nodes, model.Mesh.Elements(:, newEls), 'FaceAlpha', 0.5)
    hold on
    pdemesh(model.Mesh.Nodes, model.Mesh.Elements(:, startEls), 'FaceColor', 'black')
    hold off
    cell = num2cell(model.Mesh.Nodes(:, model.Mesh.Elements(:, meshIDs{end})), 2);
    [X, Y, Z] = cell{:};
    xlim([0.9*min(X) 1.1*max(X)]);
    ylim([0.9*min(Y) 1.1*max(Y)]);
    zlim([0.9*min(Z) 1.1*max(Z)]);
    drawnow
    newEls = findElements(model.Mesh, 'attached', reshape(model.Mesh.Elements(:,meshIDs{end}), 1, []));
    newEls = newEls(~ismember(newEls,allEls));

    allEls = [allEls newEls];
    meshIDs{end+1} = newEls;
    if numel(newEls) == 0
        break
    end
    
    while (waitforbuttonpress == 0)
    end
end
clear X Y Z ax cell meshIDs newEls startEls
%% SOLVE PDE AND GRADIENT
results = solvepde(model);
disp('PDE solved!')

%% Evaluate Phi and Grad Phi on the X-Z-plane. 
% Set these values to determine how densely gradient and value should be
% evaluated and plotted
Zspace = 0.2;       % Z distance between evaluation points
ZquiverSpacing = 1; % Number of points between each arrow in z-direction.
                    % i.e. Zspace = 0.1, ZquiverSpacing = 5 means one arrow
                    % every 5 points, total distance 0.5
ZvitalySpacing = 5; % Number of points between each z-line in Vitaly plot.
                    % i.e. Zspace = 0.1, ZvitalySpacing = 10 means one line
                    % for each Z
ZvitalyN = 6;       % Total number of lines in plot, starting from Z = 0

                    % Now the same but for X
Xspace = 0.2;
XquiverSpacing = 1;
                    % Start- and endpoints for eval matrices are computed
                    % from magnet dimensions
Xmax = ceil(2*Ru/10)*10;
Zmax = ceil(2*H/10)*10;
                    % Create meshgrid, compute gradients and potential
[X,Y,Z] = meshgrid(-Xmax:Xspace:Xmax,0,-Zmax:Zspace:Zmax);
[gradx,grady,gradz] = evaluateGradient(results,X,Y,Z);
phi = interpolateSolution(results,X,Y,Z);

disp('Gradient computed')
                    % Reshape results from col.vec. to arrays, and remove
                    % redundant Y dimension with squeeze
gradx = squeeze(reshape(gradx,size(X)));
grady = squeeze(reshape(grady,size(Y)));
gradz = squeeze(reshape(gradz,size(Z)));
phi = squeeze(reshape(phi, size(X)));
X = squeeze(X);
Y = squeeze(Y);
Z = squeeze(Z);

%% PLOT 3D SOLUTION

%quiver3(X,Y,Z,gradx,grady,gradz)

%Sjukt cursed plot, plotta ej denna!
%pdeplot3D(model,'ColorMapData',results.NodalSolution)

%axis equal
%xlabel('x')
%ylabel('y')
%zlabel('z')

%% PLOT 2D SOLUTION
close all
xlabel('x')
ylabel('z')
hold on
rectangle('Position', [Ri, -H/2, (Ru-Ri), H]);
rectangle('Position', [Ri, -H/2, (Ru-Ri), h], 'EdgeColor','b');
rectangle('Position', [Ri, H/2-h, (Ru-Ri), h], 'EdgeColor','r');
rectangle('Position', [-Ru, -H/2, (Ru-Ri), H]);
rectangle('Position', [-Ru, -H/2, (Ru-Ri), h], 'EdgeColor','b');
rectangle('Position', [-Ru, H/2-h, (Ru-Ri), h], 'EdgeColor','r');
quiver(X(1:XquiverSpacing:end,1:ZquiverSpacing:end),...
    Z(1:XquiverSpacing:end,1:ZquiverSpacing:end),...
    gradx(1:XquiverSpacing:end,1:ZquiverSpacing:end),...
    gradz(1:XquiverSpacing:end,1:ZquiverSpacing:end), 0.5)
hold off

figure()
xlabel('x')
ylabel('z')
contourf(X, Z, phi, 30)
%% PLOTTING AGAINST VITALIY
% Determine start index (corr. to point (X, Z) = (0,0)
xmid_index = floor((size(X,1)+1)/2);
zmid_index = floor((size(X,2)+1)/2);
% Find all relevant Z indices
z_index = zmid_index + (0:(ZvitalyN-1))*ZvitalySpacing;

colors = ["green", "red", "cyan", "magenta", "yellow", "black", "none", "none", "none"];
figure()
hold on
for i = 1:numel(z_index)
    xs = X(xmid_index:end, z_index(i));
    gradzs = gradz(xmid_index:end, z_index(i));
    plot(xs,gradzs, 'Color', colors(i), 'DisplayName', 'z='+ string(Z(1,z_index(i))));
end

grid on

legend
hold off
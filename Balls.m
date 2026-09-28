function points=Balls()


mt = 0.7793; % mass of tube in kg
mb = 0.00275;
rho = 1.2; %
d = 0.04; %
l = 1.525; %
r_l=0.2032;
g=9.81;

% Open CSV and read third column into array, then find its maximum
% Folder="apps_lab_data"

files=dir("Apps_lab_data\");
files(2)=[]
files(1)=[]
for i = 1:length(files)
  % if  i== 6 |  i== 13 | i== 9 | i== 5 | i == 11
  %   % if i==100
  % else


  % loop through the files and open. Note that dir also lists the directories, so you have to check for them.
  if ~files(i).isdir
    current_file = fullfile("Apps_lab_data/",files(i).name);


    Table = readtable(current_file);
    angles = Table{:,3};
    pressures = Table{:,2};
    % figure(i)
    % plot(pressures)
    % plot(pressures)
    for k=2:length(pressures)
      delta_p(k)=pressures(k)-pressures(k-1);
      if delta_p(k)>=10
        min_pressure(i)=pressures(k-2)*10^3;
      end
    end
    max(delta_p);

    maxAngle = max(angles);
    %min_pressure = min(pressures)*10^3;

    %maxAngle=.5
    theta = maxAngle;
    % theta = input("Input radians: ");
    height=(r_l-r_l*cos(theta));
    v = (mt+mb)/mb*sqrt(2*g*(r_l-r_l*cos(theta)));
    points(i,1)=min_pressure(i);
    points(i,2)=v;
    err_mb=-sqrt(2*9.8*height)*mt/(mb^2)
    err_mt=sqrt(2*9.8*height)
    err_h=1/2*(2*g*height)^(-1/2)*1+(mt/mb)
    err=sqrt(err_h^2+err_mb^2+err_mt^2)
    points(i,3)=err;


    v_n = (mt+mb)*sqrt(2*g*(r_l-r_l*cos(theta)))/(mb+rho*pi/4*d^2*l);
    % disp("-----------------")
    % disp(minPressure)
    % disp(v)
    % disp(maxAngle)
    % fprintf('Exit Velocity = %f [m/s]\nExit Velocity with Air Momentum = %f [m/s]\n', v, v_n)


    % end

    % filename = 'raw_data/run3.csv';
  end
end
% if  i== 6 |  i== 13 | i== 9 | i== 5 | i == 11
points([11,5,9,13,6],:) =[]
writematrix(points,'processed_data.csv');
disp("done")


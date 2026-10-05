function points=Balls()

% set constant variables
mt = 0.7793; % mass of tube in kg
mb = 0.00275;
rho = 1.2; %
d = 0.04; %
l = 1.525; %
r_l=0.2032;
g=9.81;
delta_mb=0.00005
delta_mt=0.00010
delta_h=0.010

% Open CSV and read third column into array, then find its maximum
% Folder="apps_lab_data"

% #read raw csv files from directory
files=dir("Apps_lab_data\");
files(2)=[]
files(1)=[]
for i = 1:length(files)
  % loop through the files and open
  if ~files(i).isdir
    current_file = fullfile("Apps_lab_data/",files(i).name);

    Table = readtable(current_file);
    angles = Table{:,3};
    pressures = Table{:,2};

    % find the spot where pressure spikes and get the pressure right before that happens
    for k=2:length(pressures)
      delta_p(k)=pressures(k)-pressures(k-1);
      if delta_p(k)>=10
        min_pressure(i)=pressures(k-2)*10^3;
      end
    end

    %find the maximum angle
    maxAngle = max(angles);
    theta = maxAngle;

    % calculate height from angles
    height=(r_l-r_l*cos(theta));
    % calculate velocity from height using cons of momentum/energy
    v = (mt+mb)/mb*sqrt(2*g*(r_l-r_l*cos(theta)));

    %build table to be plotted
    points(i,1)=min_pressure(i);
    points(i,2)=v;

    %find errors using partial deritive equations
    err_mb=-sqrt(2*9.8*height)*mt/(mb^2)
    err_mt=sqrt(2*9.8*height)
    err_h=1/2*(2*g*height)^(-1/2)*1+(mt/mb)
    err=sqrt((err_h*delta_h)^2+(err_mb*delta_mb)^2+(err_mt*delta_mt)^2)

    points(i,3)=err;
    points(i,4)=maxAngle;


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
points([11,5,9,13,6],:) =[] %strip off bad trials

%write data to table for later use
writematrix(points,'processed_data.csv');
% disp("done")


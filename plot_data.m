clear
clc
model_table=readmatrix("model_table.csv")
P_initial=model_table(1,:)
v_nominal=model_table(2,:)
v_upper=model_table(3,:)
v_lower=model_table(4,:)


points=readmatrix("processed_data.csv");
%split up the data based on which pressure it ended up using
first_set=points([1,2,10,8,9],:)
second_set=points([3,4,7,5,6],:)
% first_set=points
% second_set=points

%calculate averages and errors
first_ave=[sum(first_set(:,1))/length(first_set),sum(first_set(:,2)/length(first_set))]
second_ave=[sum(second_set(:,1)/length(second_set)),sum(second_set(:,2)/length(second_set))]

sys_error=sum(points(:,3))/2
first_std=[std(first_set(:,1))/2,std(first_set(:,2))/2]
second_std=[std(second_set(:,1))/2,std(second_set(:,2))/2]

first_err=sqrt(sys_error^2+first_std.^2)
second_err=sqrt(sys_error^2+second_std.^2)



figure(1)
clf
hold on
plot(P_initial,v_nominal)
plot(P_initial,v_upper)
plot(P_initial,v_lower)

title("Exit velocities for differing vaccum pressures")
xlabel("Vaccum Pressure (pa)")
ylabel("Velocity (m/s)")
fontsize("increase")
% plot(first_ave(1),first_ave(2),'x','linewidth',7)
% clot(points(:,1),points(:,2),'x','linewidth',7)
errorbar(first_set(:,1),first_set(:,2),first_set(:,3),'x')
errorbar(second_set(:,1),second_set(:,2),second_set(:,3),'x')
% plot(second_set(:,1),second_set(:,2),'x','linewidth',7)
% plot([4.26*10^3,4.18*10^3],[244.8,201.1],'x','linewidth',7)
legend('Nominal velocity','Upper bound','Lower bound','Data in 4 kpa range','Data in 7 kpa range')
hold off


figure(2)
clf
hold on
plot(P_initial,v_nominal)
plot(P_initial,v_upper)
plot(P_initial,v_lower)

title("Exit velocities for differing vaccum pressures")
xlabel("Vaccum Pressure (pa)")
ylabel("Velocity (m/s)")
fontsize("increase")
% plot(first_ave(1),first_ave(2),'x','linewidth',7)
errorbar(first_ave(1),first_ave(2),first_err(2),first_err(2),first_err(1),first_err(1),"o")
errorbar(second_ave(1),second_ave(2),second_err(2),second_err(2),second_err(1),second_err(1),"o")
% plot(first_ave(1),first_ave(2),'x','linewidth',7)
% legend('Nominal velocity','Upper bound','Lower bound','Mesured data')
legend('Nominal velocity','Upper bound','Lower bound','Average in 4 kpa range','Average in 7 kpa range')
hold off
disp("end")

data = load('dataset_edmonton/edmonton_ODO.txt');
data_laser =  load('dataset_edmonton/edmonton_LASER.txt');
changed_data = zeros(size(data,1),3);
x=0;y=0;th=0;
for i = 1:size(data,1)
    th = th+data(i,3);
    changed_data(i,1) = x+(sqrt(data(i,1)^2+data(i,2)^2))*cos(th);
    changed_data(i,2) = y+(sqrt(data(i,1)^2+data(i,2)^2))*sin(th);
    changed_data(i,3) = th;
    x = changed_data(i,1);
    y = changed_data(i,2);    
end
%scatter(changed_data(:,1),changed_data(:,2),'.')
col = size(data_laser,2);
angles = -89:1:90;
angles = angles*pi/180;
laser_data = zeros(size(data_laser,1)*size(data_laser,2),2);
figure(1)
scatter(changed_data(:,1),changed_data(:,2),'.','red');
for i = 1:size(data_laser,1)
    laser_data((i-1)*col+1:i*col,1) = data_laser(i,:).*cos(angles+changed_data(i,3))+changed_data(i,1);
    laser_data((i-1)*col+1:i*col,2) = data_laser(i,:).*sin(angles+changed_data(i,3))+changed_data(i,2);
   
    hold on    
    
    dl = plot(laser_data((i-1)*col+1:i*col,1),laser_data((i-1)*col+1:i*col,2),'.');
   
   axis([-60 60 -60 60])
    xlabel('m')
    ylabel('m')
    title(sprintf('SICK Data: scan %d',i))
    pause(0.01)
     if exist('dl', 'var')
        delete(dl);
    end
end
%scatter(laser_data(:,1),laser_data(:,2),'.','red')
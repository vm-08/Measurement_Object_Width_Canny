%% Measurement of Object Width through Edge Detection based on the Canny Method
% Understanding of Images Project
% Vjosa Mamudi 

% Objective: Determine the width of the chosen objects in the data set by
%            detecting the edges of the object using (partially) the Canny method.
%            The distance between the edges is equal to the width. 
% Remark: Decomment the part of the code according to the width you want to calculate. 

%% Load images 
clc; clear all;
i_num = 0:1:30;         % number of images 	
filepath = uigetdir();  % directory 

%*************************************************************************%
%% Object Nr. 1 "Dowel Pin" %%
for i=1:numel(i_num)
    filename = ['dowl_pin_' num2str(i_num(i)) '.bmp'];
    fullfilename = fullfile(filepath,filename);
    S_im = imread(fullfilename);

    %% Extract Lines used to calculate width
    % change data type to double
    S_im = double(S_im);
    % determine Line and save it as a vector
    i_Z = 500;
    S_Z = S_im(i_Z, :);
    % determine pixel position
    N_Z = length(S_Z);
    x_Z = 1:N_Z;

    %% Filter with Gaussian Filter
    sigma = 1.7; % standard deviation of Gaussian filter
    N_Gauss = 2*ceil(2*sigma)+1; % length of kernel
    h_Gauss = fspecial('gaussian',[1 N_Gauss],sigma); % Gaussian kernel
    S_Z_f = conv(S_Z,h_Gauss,'valid'); % filter line profile (convolution)
    N_Z_f = N_Z-(N_Gauss-1);
    x_Z_f = x_Z(1:N_Z_f)+(N_Gauss-1)/2;
    
    %% Gradient calculation
    % differentiate line and determine position:
    S_delta = diff(S_Z_f);
    x_delta = (x_Z_f(2:N_Z_f)+x_Z_f(1:N_Z_f-1))/2;

    %% Ascertain object width
    N_k = 50; % number of lines used to calculate width
    x_k1 = NaN(1,N_k); 
    x_k2 = NaN(1,N_k); % initialization of variables
    % evaluate each line
    for i_k = 1:N_k
        S_Z = S_im(i_Z+i_k, :);
        % filter line
        S_Z_f = conv(S_Z,h_Gauss,'valid');
        % differentiate line
        S_delta = diff(S_Z_f);
        % calculation of extrema
        [max_pix,ind_max] = max(S_delta); 
        [min_pix,ind_min] = min(S_delta);
        % second derivation
        S_dd_max = diff(S_delta([ind_max-1 ind_max ind_max+1])); 
        S_dd_min = diff(S_delta([ind_min-1 ind_min ind_min+1])); 
        if prod(S_dd_max) >0, error('No central maximum for CANNY'); end
        if prod(S_dd_min) >0, error('No central minimum fo CANNY'); end
        % determine location of first edge through interpolation:
        delta_c1 = (S_dd_max(2)+S_dd_max(1))/(S_dd_max(2)-S_dd_max(1));
        x_k1(i_k) = ind_max+(N_Gauss-1)/2-delta_c1/2;
        % determine location of second edge through interpolation:
        delta_c2 = (S_dd_min(2)+S_dd_min(1))/(S_dd_min(2)-S_dd_min(1));
        x_k2(i_k) = ind_min+(N_Gauss-1)/2-delta_c2/2;
    end
    
    lq_pix = x_k1-x_k2; % width in pixels
    
    
% %*************************************************************************%
% %% Object Nr. 2 "Bosch Rexroth Profile - Inner width" %%
% for i = 1:numel(i_num)
%     filename = ['BR_profile_' num2str(i_num(i)) '.bmp'];
%     fullfilename = fullfile(filepath,filename);
%     S_im = imread(fullfilename);
%     
%     %% Extract Lines used to calculate width
%     % change data type to double
%     S_im = double(S_im);
%     % determine Line and save it as a vector
%     i_Z = 460;
%     S_Z = S_im(i_Z, :);
%     % determine pixel position
%     N_Z = length(S_Z);
%     x_Z = 1:N_Z;
% 
%     %% Filter with Gaussian Filter
%     sigma = 1.7; % standard deviation of Gaussian filter
%     N_Gauss = 2*ceil(2*sigma)+1; % length of kernel
%     h_Gauss = fspecial('gaussian',[1 N_Gauss],sigma); % Gaussian kernel
%     S_Z_f = conv(S_Z,h_Gauss,'valid'); % filter line profile (convolution)
%     N_Z_f = N_Z-(N_Gauss-1);
%     x_Z_f = x_Z(1:N_Z_f)+(N_Gauss-1)/2;
%     
%     %% Gradient calculation
%     % differentiate line and determine position:
%     S_delta = diff(S_Z_f);
%     x_delta = (x_Z_f(2:N_Z_f)+x_Z_f(1:N_Z_f-1))/2;
%     
%     %% Ascertain object width
%     N_k = 50; % number of lines used to calculate width
%     x_k1 = NaN(1,N_k); 
%     x_k2 = NaN(1,N_k); % initialization of variables
%     % evaluate each line
%     for i_k = 1:N_k
%         S_Z = S_im(i_Z+i_k, :);
%         % filter line
%         S_Z_f = conv(S_Z,h_Gauss,'valid'); 
%         % differentiate line
%         S_delta = diff(S_Z_f);
%         % calculation of extrema
%         [max_pix,ind_max] = max(S_delta(800:1000)); 
%         ind_max = ind_max+799;
%         [min_pix,ind_min] = min(S_delta(360:600)); 
%         ind_min = ind_min+359;
%         % second derivation
%         S_dd_max = diff(S_delta([ind_max-1 ind_max ind_max+1]));
%         S_dd_min = diff(S_delta([ind_min-1 ind_min ind_min+1]));
%         if prod(S_dd_max) >0, error('No central maximum for CANNY'); end
%         if prod(S_dd_min) >0, error('No central minimum fo CANNY'); end
%         % determine location of first edge through interpolation:
%         delta_c1 = (S_dd_max(2)+S_dd_max(1))/(S_dd_max(2)-S_dd_max(1));
%         x_k1(i_k) = ind_max+(N_Gauss-1)/2-delta_c1/2;
%         % determine location of second edge through interpolation:
%         delta_c2 = (S_dd_min(2)+S_dd_min(1))/(S_dd_min(2)-S_dd_min(1));
%         x_k2(i_k) = ind_min+(N_Gauss-1)/2-delta_c2/2;
%     end
%     
%     lq_pix = x_k1-x_k2; % width in pixels
  
  
% %*************************************************************************%
% %% Object Nr. 2 "Bosch Rexroth Profile - Outer width" %%
% for i=1:numel(i_num)
%     filename=['BR_profile_' num2str(i_num(i)) '.bmp'];
%     fullfilename=fullfile(filepath,filename);
%     S_im=imread(fullfilename);
% 
%     %% Extract Lines used to calculate width
%     % change data type to double
%     S_im = double(S_im);
%     % determine Line and save it as a vector
%     i_Z = 300;
%     S_Z = S_im(i_Z, :);
%     % determine pixel position
%     N_Z = length(S_Z);
%     x_Z = 1:N_Z;
% 
%     %% Filter with Gaussian Filter
%     sigma = 1.7; % standard deviation of Gaussian filter
%     N_Gauss = 2*ceil(2*sigma)+1; % length of kernel
%     h_Gauss = fspecial('gaussian',[1 N_Gauss],sigma); % Gaussian kernel
%     S_Z_f = conv(S_Z,h_Gauss,'valid'); % filter line profile (convolution)
%     N_Z_f = N_Z-(N_Gauss-1);
%     x_Z_f = x_Z(1:N_Z_f)+(N_Gauss-1)/2;
% 
%     %% Gradient calculation
%     % differentiate line and determine position:
%     S_delta = diff(S_Z_f);
%     x_delta = (x_Z_f(2:N_Z_f)+x_Z_f(1:N_Z_f-1))/2;
%     
%     %% Ascertain object width
%     N_k = 50; % number of lines used to calculate width
%     x_k1 = NaN(1,N_k); 
%     x_k2 = NaN(1,N_k); % initialization of variables
%     % evaluate each line
%     for i_k = 1:N_k
%         S_Z = S_im(i_Z+i_k, :);
%         % filter line
%         S_Z_f = conv(S_Z,h_Gauss,'valid'); 
%         % differentiate line
%         S_delta = diff(S_Z_f);
%         % calculation of extrema
%         [max_pix,ind_max] = max(S_delta(1150:end)); 
%         ind_max = ind_max+1149;
%         [min_pix,ind_min] = min(S_delta(1:200));
%         ind_min = ind_min+0;
%         % second derivation
%         S_dd_max = diff(S_delta([ind_max-1 ind_max ind_max+1])); 
%         S_dd_min = diff(S_delta([ind_min-1 ind_min ind_min+1]));
%         if prod(S_dd_max) >0, error('No central maximum for CANNY'); end
%         if prod(S_dd_min) >0, error('No central minimum fo CANNY'); end
%         % determine location of first edge through interpolation:
%         delta_c1 = (S_dd_max(2)+S_dd_max(1))/(S_dd_max(2)-S_dd_max(1));
%         x_k1(i_k) = ind_max+(N_Gauss-1)/2-delta_c1/2;
%         % determine location of second edge through interpolation:
%         delta_c2=(S_dd_min(2)+S_dd_min(1))/(S_dd_min(2)-S_dd_min(1));
%         x_k2(i_k)=ind_min+(N_Gauss-1)/2-delta_c2/2;
%     end 
%     
%     lq_pix = x_k1-x_k2; % width in pixel
    
    %% Hampel Test
    % detect outliers and replace value with 'NaN'
    [lq_pix_hampel,ind_hampel] = hampel(lq_pix,N_k);
    lq_pix(ind_hampel) = NaN;
    
    %% Average and standard deviation
    lq_pix_mean(i)= mean(lq_pix,'omitnan'); % average
    lq_pix_std(i) = std(lq_pix,'omitnan');  % absolute standard deviation
    lq_pix_std_rel(i) = lq_pix_std/lq_pix_mean; % relative standard deviation
    
end

%% Average width in pixels
lq_pix_mean_all = mean(lq_pix_mean); 
lq_pix_std_mean = std(lq_pix_mean);

%% Calculate width in mm
% l_mean_mm: object width in mm
% l_u: measurement uncertainity of width in mm

% Parameters
l_pix = 5.3e-3;         % pixel size in mm
m = 0.197161438622633;  % magnification of camera lense
m_std = 0.001071452850588; % standard deviation of the magnification

% Calculation
l_mean_mm = lq_pix_mean_all*l_pix/m
l_u = sqrt((l_pix/m*lq_pix_std_mean)^2+(-l_mean_mm*l_pix/m^2*m_std)^2)

%% Visualization of last loaded image
% display last image
     figure(1);
     imshow(S_im, []); hold on;
% plot the line
     line([1 size(S_im,2)],i_Z*[1 1],'color','b');
     
% draw red markers to indicate chosen edges (x_k1 and x_k2)
for i_k = 1:N_k
    % red marker for the first edge
    plot(x_k1(i_k), i_Z + i_k, 'r.', 'MarkerSize', 10);
    % red marker for the second edge
    plot(x_k2(i_k), i_Z + i_k, 'r.', 'MarkerSize', 10);
end

%% Visualization of the means and standard deviations of the data set 
figure(2); clf;
errorbar(lq_pix_mean,lq_pix_std,'xk');
hold on;
yline(lq_pix_mean_all,'--r');
yline(lq_pix_mean_all + lq_pix_std_mean, '-r'); % upper bound
yline(lq_pix_mean_all - lq_pix_std_mean, '-r'); % lower bound
hold off;

% labeling and formatting
xlabel(['number of images (n = ' num2str(numel(i_num)) ')'],'Interpreter','latex');
ylabel('$l''_{lim}$ in px (incl. std deviation)','Interpreter','latex');
title('Means and standard deviations of the invidual images','Interpreter','latex');
legend('Individual image','$\bar{l}''_{lim}$','$s(\bar{l}''_{lim})$','Interpreter','latex','FontSize',10);
xticks([]);
grid;




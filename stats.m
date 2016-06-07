%stats file
close all; clear; init; clc;

im_res = [];
re_res = [];
theor_im = [];
theor_re = [];
max = 10;
r = (-pi):(1/max):(pi);
s = 0:10:90;
j = 1;
for j = 1:length(s)
    for i = 1:length(r)
        A = simFile(r(i),s(j));
        im_res = [im_res (imag(A.data(10))+ 1)]; % +1 to sum the diagonal (Compute actual trace)
        re_res = [re_res (real(A.data(10))+1)];
    end
    figure;
    hold on;
    title('Unitary Trace of varying Z-Gate')
    
    xlabel('-pi < x < pi (rad)')
    ylabel('Trace Amplitude')
    plot(r,im_res)
    plot(r,re_res)
    legend('Img(Trace)','Re(Trace)')
    im_res = [];
    re_res = [];
end
% for i = 1:length(r)
%     theor_im = [theor_im ther_im(r(i))];
%     theor_re = [theor_re ther_re(r(i))];
% end

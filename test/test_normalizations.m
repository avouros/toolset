% Test normalizations

x = [1,2,3,4,5];
% result:
a1 = [-2,-1,0,1,2];
a2 = [0.0667,0.1333,0.20,0.2667,0.3333];
a3 = [0.1348,0.2697,0.4045,0.5394,0.6742];
a4 = [0.1644,0.3288,0.4932,0.6577,0.8221];
a5 = [-1.2649,-0.6325,0,0.6325,1.2649];
a6 = [0,0.250,0.50,0.750,1];
a7 = [2,3.750,5.50,7.250,9];

cmean = normalizations(x,'mean');
one = normalizations(x,'one');
n_norm = normalizations(x,'n-norm');
n_norm3 = normalizations(x,'n-norm',3); 
z_score = normalizations(x,'z-score');
scale = normalizations(x,'scale'); 
scale29 = normalizations(x,'scale',[2,9]);

assert(max(abs(cmean-a1)) < 10^-4 , 'Error x1, mean');
assert(max(abs(one-a2)) < 10^-4 , 'Error x1, one');
assert(max(abs(n_norm-a3)) < 10^-4 , 'Error x1, n-norm');
assert(max(abs(n_norm3-a4)) < 10^-4 , 'Error x1, n-norm3');
assert(max(abs(z_score-a5)) < 10^-4 , 'Error x1, z-score');
assert(max(abs(scale-a6)) < 10^-4 , 'Error x1, scale');
assert(max(abs(scale29-a7)) < 10^-4 , 'Error x1, scale29');

%%

x = [1;2;3;4;5];
% result:
a1 = [-2;-1;0;1;2];
a2 = [0.0667;0.1333;0.20;0.2667;0.3333];
a3 = [0.1348;0.2697;0.4045;0.5394;0.6742];
a4 = [0.1644;0.3288;0.4932;0.6577;0.8221];
a5 = [-1.2649;-0.6325;0;0.6325;1.2649];
a6 = [0;0.250;0.50;0.750;1];
a7 = [2;3.750;5.50;7.250;9];

cmean = normalizations(x,'mean');
one = normalizations(x,'one');
n_norm = normalizations(x,'n-norm');
n_norm3 = normalizations(x,'n-norm',3); 
z_score = normalizations(x,'z-score');
scale = normalizations(x,'scale'); 
scale29 = normalizations(x,'scale',[2,9]);

assert(max(abs(cmean-a1)) < 10^-4 , 'Error x2, mean');
assert(max(abs(one-a2)) < 10^-4 , 'Error x2, one');
assert(max(abs(n_norm-a3)) < 10^-4 , 'Error x2, n-norm');
assert(max(abs(n_norm3-a4)) < 10^-4 , 'Error x2, n-norm3');
assert(max(abs(z_score-a5)) < 10^-4 , 'Error x2, z-score');
assert(max(abs(scale-a6)) < 10^-4 , 'Error x2, scale');
assert(max(abs(scale29-a7)) < 10^-4 , 'Error x2, scale29');

%%

x = [1,2,3 ; 3,2,1 ; 2,3,1 ; 1,3,2];
% result:
a1 = [-0.750,-0.50,1.250;1.250,-0.50,-0.750;0.250,0.50,-0.750;-0.750,0.50,0.250];
a2 = [0.143,0.20,0.4286;0.4286,0.20,0.1429;0.2857,0.30,0.1429;0.1429,0.30,0.2857];
a3 = [0.2582,0.3922,0.7746;0.7746,0.3922,0.2582;0.5164,0.5883,0.2582;0.2582,0.5883,0.5164];
a4 = [0.3001,0.4853,0.9003;0.9003,0.4853,0.3001;0.6002,0.7279,0.3001;0.3001,0.7279,0.6002];
a5 = [-0.7833,-0.8660,1.3056;1.3056,-0.8660,-0.7833;0.2611,0.8660,-0.7833;-0.7833,0.8660,0.2611];
a6 = [0,0,1;1,0,0;0.50,1,0;0,1,0.50];
a7 = [2,2,9;9,2,2;5.50,9,2;2,9,5.50];

cmean = normalizations(x,'mean');
one = normalizations(x,'one');
n_norm = normalizations(x,'n-norm');
n_norm3 = normalizations(x,'n-norm',3); 
z_score = normalizations(x,'z-score');
scale = normalizations(x,'scale'); 
scale29 = normalizations(x,'scale',[2,9]);

assert(max(max(abs(cmean-a1))) < 10^-4 , 'Error x1, mean');
assert(max(max(abs(one-a2))) < 10^-3 , 'Error x1, one');
assert(max(max(abs(n_norm-a3))) < 10^-3 , 'Error x1, n-norm');
assert(max(max(abs(n_norm3-a4))) < 10^-3 , 'Error x1, n-norm3');
assert(max(max(abs(z_score-a5))) < 10^-3 , 'Error x1, z-score');
assert(max(max(abs(scale-a6))) < 10^-3 , 'Error x1, scale');
assert(max(max(abs(scale29-a7))) < 10^-3 , 'Error x1, scale29');


if ispc % Use Windows ghostscript call
  system('gswin64c -o -q -sDEVICE=png256 -dEPSCrop -r300 -oimprovedExample_eps.png improvedExample.eps');
else % Use Unix/OSX ghostscript call
  system('gs -o -q -sDEVICE=png256 -dEPSCrop -r300 -oimprovedExample_eps.png improvedExample.eps');
end



files_eth_1 = dir('../MD_MPI/time_eth/1/*.csv');
files_myri_1 = dir('../MD_MPI/time_myri/1/*.csv');
files_eth_3 = dir('../MD_MPI/time_eth/3/*.csv');
files_myri_3 = dir('../MD_MPI/time_myri/3/*.csv');

eth_ppn = [1 2 4 8 10 12 14 16 22 24 26 28 30 32 34 36 38 64 96 128];
nodes_eth = [1 ; 2 ; 4 ; 8 ; 10 ; 12 ; 14 ; 16 ; 22 ; 24 ; 26 ; 28 ; 30 ; 32 ; 34 ; 36 ; 38 ; 64 ; 96 ; 128];

myri_ppn = [1 2 4  8  10 12 14 16 22 24 26 28 30 32];
nodes_myri = [1 ; 2 ; 4 ; 8 ; 10 ; 12 ; 14 ; 16 ; 22 ; 24 ; 26 ; 28 ; 30 ; 32];
  

num_files_eth = length(eth_ppn);
num_files_myri = length(myri_ppn);

times_eth_1 = zeros(num_files_eth, 1);
times_eth_3 = zeros(num_files_eth, 1);
times_myri_1 = zeros(num_files_myri, 1);
times_myri_3 = zeros(num_files_myri, 1);

for K = 1:num_files_eth
times_eth_1(K) = csvread( strcat( strcat('../MD_MPI/time_eth/1/best_', num2str(eth_ppn(K) )), '.csv'));
times_eth_3(K) = csvread( strcat( strcat('../MD_MPI/time_eth/3/best_', num2str(eth_ppn(K) )), '.csv'));
end

for K = 1:num_files_myri
times_myri_1(K) = csvread( strcat( strcat('../MD_MPI/time_myri/1/best_', num2str(myri_ppn(K) )), '.csv'));
times_myri_3(K) = csvread( strcat( strcat('../MD_MPI/time_myri/3/best_', num2str(myri_ppn(K) )), '.csv'));
end

base_time_eth_1 = times_eth_1(1);
base_time_eth_3 = times_eth_3(1);
base_time_myri_1 = times_myri_1(1);
base_time_myri_3 = times_myri_3(1);

gain_eth_1 =  base_time_eth_1 ./ times_eth_1;
gain_eth_3 =  base_time_eth_3 ./ times_eth_3;

gain_myri_1 =  base_time_myri_1 ./ times_myri_1;
gain_myri_3 = base_time_myri_3 ./ times_myri_3;


bg = [1 1 1; 0 0 0];
cores = distinguishable_colors(100,bg);


plot(eth_ppn,gain_eth_1,'r+--','Color', cores(1,:),'MarkerSize', 8);
hold on;
plot(eth_ppn,gain_eth_3,'r+--','Color', cores(2,:),'MarkerSize', 8);
hold on;
plot(myri_ppn,	gain_myri_1,'ro--','Color', cores(3,:),'MarkerSize', 8);
hold on;
plot(myri_ppn,gain_myri_3 ,'ro--','Color', cores(4,:),'MarkerSize', 8);
hold on;
%%%%%




 figure (1)
 fig = figure(1);
 set(gcf,'PaperPositionMode','auto')
 set(fig, 'Position', [0 0 780 700])
 
set(gca,'xscale','log');
set(gca,'yscale','log');

grid on;
set(gca, 'XTick', [1 2 4 8 10 12 14 16 24 32 64 96 128]);
set(gca, 'YTick', [1 2 4 8 16 32 64]);

xlim([1 128]) ;
%ylim([0 36]) ;


set(gca,'YTickLabel',num2str(get(gca,'YTick').'));


l = legend('Gigabit Ethernet -- dataset 1', 'Gigabit Ethernet -- dataset 3', 'Myrinet 10Gbps -- dataset 1' , 'Myrinet 10Gbps -- dataset 3', 'Location','northwest');

set(l,'FontSize',12);
ylabel('Speedup');

xlabel('Number of OpenMPI Processes');
t = title({'\textbf{Relation between total speedup and number of OpenMPI processes}','Compute node 641, Dataset sizes 1 and 3, GCC version 4.9.3, OpenMPI version 1.8.4','MPI mapping by core, Max number of nodes: 4','Communication platforms: Gigabit Ethernet and Myrinet 10Gbps'},'interpreter','latex')
set(gca,'fontsize',12);

set(t,'FontSize',18);

print('gain_mpi_eth_myri', '-depsc2', '-r300');



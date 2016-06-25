
files_eth_1 = dir('../MD_MPI/time_eth/1/*.csv');
files_myri_1 = dir('../MD_MPI/time_myri/1/*.csv');
files_eth_3 = dir('../MD_MPI/time_eth/3/*.csv');
files_myri_3 = dir('../MD_MPI/time_myri/3/*.csv');

eth_ppn = [1 2 4 8 10 12 14 16 22 24 26 28 30 32 34 36 38 64 96 128]
myri_ppn = [1 2 4  8  10 12 14 16 22 24 26 28 30 32]
    
num_files_eth_1 = length(files_eth_1);
vals = cell(1,num_files_eth_1);
for K = 1:num_files_eth_1
vals{K} = load(files_eth_1(K).name);
end




%%%%%%%%%%%%%% GANHOS %%%%%%%%%%%%%

%OMP GCC
ganho_omp_gcc_CG = (seq_gcc_CG / omp_gcc_CG ) - 1 ; 
ganho_omp_gcc_EP = (seq_gcc_EP / omp_gcc_EP ) - 1 ; 
ganho_omp_gcc_IS = (seq_gcc_IS / omp_gcc_IS ) - 1 ; 
ganho_omp_gcc_MG = (seq_gcc_MG / omp_gcc_MG ) - 1 ; 
ganho_omp_gcc = [ ganho_omp_gcc_CG ganho_omp_gcc_EP ganho_omp_gcc_IS ganho_omp_gcc_MG]; 

%OMP ICC
ganho_omp_icc_CG = (seq_icc_CG / omp_icc_CG ) - 1 ; 
ganho_omp_icc_EP = (seq_icc_EP / omp_icc_EP ) - 1 ; 
ganho_omp_icc_IS = (seq_icc_IS / omp_icc_IS ) - 1 ; 
ganho_omp_icc_MG = (seq_icc_MG / omp_icc_MG ) - 1 ; 
ganho_omp_icc = [ ganho_omp_icc_CG ganho_omp_icc_EP ganho_omp_icc_IS ganho_omp_icc_MG]; 


%MPI GCC ETH
ganho_mpi_gcc_CG = (seq_gcc_CG / mpi_gcc_CG ) - 1 ; 
ganho_mpi_gcc_EP = (seq_gcc_EP / mpi_gcc_EP ) - 1 ; 
ganho_mpi_gcc_IS = (seq_gcc_IS / mpi_gcc_IS ) - 1 ; 
ganho_mpi_gcc_MG = (seq_gcc_MG / mpi_gcc_MG ) - 1 ; 
ganho_mpi_gcc = [ ganho_mpi_gcc_CG ganho_mpi_gcc_EP ganho_mpi_gcc_IS ganho_mpi_gcc_MG]; 

%MPI ICC ETH
ganho_mpi_icc_CG = (seq_icc_CG / mpi_icc_CG ) - 1 ; 
ganho_mpi_icc_EP = (seq_icc_EP / mpi_icc_EP ) - 1 ; 
ganho_mpi_icc_IS = (seq_icc_IS / mpi_icc_IS ) - 1 ; 
ganho_mpi_icc_MG = (seq_icc_MG / mpi_icc_MG ) - 1 ; 
ganho_mpi_icc = [ ganho_mpi_icc_CG ganho_mpi_icc_EP ganho_mpi_icc_IS ganho_mpi_icc_MG]; 

%MPI GCC MX
ganho_mpi_mx_gcc_CG = (seq_gcc_CG / mpi_mx_gcc_CG ) - 1 ; 
ganho_mpi_mx_gcc_EP = (seq_gcc_EP / mpi_mx_gcc_EP ) - 1 ; 
ganho_mpi_mx_gcc_IS = (seq_gcc_IS / mpi_mx_gcc_IS ) - 1 ; 
ganho_mpi_mx_gcc_MG = (seq_gcc_MG / mpi_mx_gcc_MG ) - 1 ; 
ganho_mpi_mx_gcc = [ ganho_mpi_mx_gcc_CG ganho_mpi_mx_gcc_EP ganho_mpi_mx_gcc_IS ganho_mpi_mx_gcc_MG]; 

%MPI ICC MX
%ganho_mpi_mx_icc_CG = (seq_icc_CG / mpi_mx_icc_CG ) - 1 ; 
%ganho_mpi_mx_icc_EP = (seq_icc_EP / mpi_mx_icc_EP ) - 1 ; 
%ganho_mpi_mx_icc_IS = (seq_icc_IS / mpi_mx_icc_IS ) - 1 ; 
%ganho_mpi_mx_icc_MG = (seq_icc_MG / mpi_mx_icc_MG ) - 1 ; 
%ganho_mpi_mx_icc = [ ganho_mpi_mx_icc_CG ganho_mpi_mx_icc_EP ganho_mpi_mx_icc_IS ganho_mpi_mx_icc_MG]; 


 figure (1)
 hFig = figure(1);
 set(gcf,'PaperPositionMode','auto')
 set(hFig, 'Position', [0 0 640 480])
bpcombined = [ganho_omp_gcc(:), ganho_omp_icc(:), ganho_mpi_gcc(:) , ganho_mpi_icc(:), ganho_mpi_mx_gcc(:) ];
hb = bar( x, bpcombined, 'grouped');
bg = [1 1 1 ; 0 0 0];
 %set(gca,'yscale','log');
%set(gca,'YTickLabel',num2str(get(gca,'YTick').'));

cores = distinguishable_colors(8,bg)
set(hb(1), 'FaceColor',cores(1,:))
set(hb(2), 'FaceColor',cores(2,:))
set(hb(3), 'FaceColor',cores(3,:))
set(hb(4), 'FaceColor',cores(4,:))
set(hb(5), 'FaceColor',cores(5,:))
%set(hb(6), 'FaceColor',cores(6,:))

l = legend('OMP GCC 4.9.0 -03','OMP ICC 13.0.1 -03', 'MPI GCC 4.9.0 -03 Gigabit Ethernet','MPI ICC 13.0.1 -03 Gigabit Ethernet', 'MPI GCC 4.9.0 -03 Myrinet 10Gbps');

set(l,'FontSize',12);
%set(l,'location','southeastoutside');

ylabel('Ganho');
xlabel('Kernel');

t = title({'Rela\c{c}\~ao de Ganho para os kernels OMP/MPI - CG, IS, EP, MG, Nodos 641','Classe de dados C para compiladores gcc 4.9.0 e icc 13.0.1 com flag de compila\c{c}\~ao -O3','Para comunica\c{c}\~ao MPI via Gigabit Ethernet e Myrinet 10Gbps'},'interpreter','latex')

set(t,'FontSize',24);
set(gca,'fontsize',12);

set(gca,'xticklabel',name);
ylim([0 44 ]);


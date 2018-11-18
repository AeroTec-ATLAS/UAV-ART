% Define the vertices (physical location of vertices
    V = [...
        0 5 0;... %1
        1 4 0;... %2
        1 1 0;... %3
        8 -2 0;... %4
        8 -3 0;... %5
        1 -2 0;... %6
        1 -5 0;... %7
        3 -6 0;... %8
        3 -7 0;... %9
        0.5 -6 0;... %10
        0 -7 0;... %11
        -0.5 -6 0;... %12
        -3 -7 0;... %13
        -3 -6 0,... %14
        -1, -5 0;... %15
        -1 -2 0,... %16
        -8 -3 0;... %17
        -8 -2 0;... %18
        -1 1 0;... %19
        -1 4 0;... %20 
        0 4 1;... %21
        0 -5 1;... %22
        0 -6 2;... %23
        0 -7 2;... %24
        0 -7 0;... %25
        0 -4 -1;... %26
        0 2 -1;... %27
        ]';
    
     % define faces as a list of vertices numbered above
      
    F = [...
        1, 2, 7, 11;... %15, 20;... % body top
        3, 4, 5, 6;... % asa direita
        7, 8, 9, 10;... % mini asa dir
        12, 13, 14, 15;... % mini asa esq
        16, 17, 18, 19;... % asa esquerda
        1, 21, 22, 23;% 24, 25, 26, 27;... % body side
        ];
 
     % define colors for each face
     myred = [1, 0, 0];
     mygreen = [0, 1, 0];
     myblue = [0, 0, 1];
     myyellow = [1, 1, 0];
     
     facecolors = [...
         myred;... % body top
         mygreen;... % asa direita
         myblue;... % mini asa dir
         myblue;... % mini asa esq
         mygreen;... % asa esquerda
         myyellow;... % body side
     ];
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
   %     MEIO AVIÃO
   
 function [V,F,facecolors] = defineVehicleBody
    
% Define the vertices (physical location of vertices
    V = [...
        0 5 0;... %1
        1 4 0;... %2
        1 1 0;... %3
        8 -2 0;... %4
        8 -3 0;... %5
        1 -2 0;... %6
        1 -5 0;... %7
        3 -6 0;... %8
        3 -7 0;... %9
        0.5 -6 0;... %10
        0 -7 0;... %11 
        ]';
    
     % define faces as a list of vertices numbered above
      
    F = [...
        1, 2, 7, 11;... % body top
        %1, 20, 15, 11;...
        3, 4, 5, 6;... % asa direita
        7, 8, 9, 10;... % mini asa dir
        %12, 13, 14, 15;... % mini asa esq
        ];
 
     % define colors for each face
     myred = [1, 0, 0];
     mygreen = [0, 1, 0];
     myblue = [0, 0, 1];
     myyellow = [1, 1, 0];
     
     facecolors = [...
         myred;... % body top
         %myred;...
         mygreen;... % asa direita
         myblue;... % mini asa dir
         %myblue;... % mini asa esq
     ];
 
end
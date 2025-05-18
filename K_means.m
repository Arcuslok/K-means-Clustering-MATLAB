function [Cluster] = K_means(Vector,Vector_2,k,is_random,Animated)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Entradas:                                            %
%  Vector       | Vector to Classify                      %
%  Vector_2     | Vector to Occupy if Displayed           %
%  k            | Number of Groups to Classify            %
%  is_random    | If you want randomness                  %
%  Animated     | If you want to view step by step        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% If the Entries is less than 5
if (nargin < 5)
    Animated = false;
end

% If the Entries is less than 4
if (nargin < 4)
    is_random = true;
end

% If the Entries is less than 3
if (nargin < 3)
    k = 3;
end

% The Number of Elements of the Vector is calculated
Number_of_Elements = size(Vector,2);
% The Vector Dimension is calculated
Dimension_Vector = size(Vector,1);


% If is_random is equal to true
if (is_random)
    
    % k random elements are taken between 1 and Number_of_Elements; Example
    % k=4, Number_of_Elements=10, x_Initial=[2 8 4 6] (Initialization)
    x_Initial = randperm(Number_of_Elements,k);

% Otherwise
else
    
    % k elements are taken between 1 and k; Example k=4, x_Initial=[1 2 3 4]
    % (Initialization) 
    x_Initial = 1:k;

end

% The initial centroids are extracted
Barycenter = Vector(:,x_Initial);

% Arrangement for Sorting Vector Elements
Cluster = zeros(1,Number_of_Elements);

% Arrangement for Sorting Vector Elements for
% Iterations
Cluster_Prev = Cluster;

Iterations = 0;

Stop = false;

% While Stop equals false
while Stop == false
    
    % For each of the Elements of the Vector
    for x_j = 1:Number_of_Elements
        
        % Arrangement for the Distance of Vector Elements
        Distance = zeros(1,k);
        
        % The distance to each Barycenter is calculated || x_j - u_i ||^2
        for u_i = 1:k
            Distance(u_i) = (norm(Vector(:,x_j) - Barycenter(:,u_i))).^2;
        end
        
        % The position of the barycent closest to the vector element is extracted.
        [~,Nearby_Cluster] = min(Distance);
   
        % Cluster Updated with Barycenter Index (Assigning Elements to Barycenters)
        Cluster(x_j) = Nearby_Cluster;

    end
    
    % If Animated is True
    if (Animated)
        % Figure 2 is cleaned
        clf(figure(2));
        % Figure 2 is created
        figure(2)
        movegui(figure(2),"north");
        grid on
        hold on
        
        % Set the Iteration Number as title
        title(['Iteration N°' num2str(Iterations+1)])
        
        % The points are graphed 
        for i = 1 : length(Vector)
            plot(Vector(:,i), Vector_2(:,i),".","MarkerSize",20);
        end
        
        pause(0.75);
        % The Barycenters are graphed, according to their corresponding Cluster
        for j = 1:k
            
            if (j == 1)
                plot(Barycenter(:,j),Barycenter(:,j),"^","LineWidth",1.3,...
                    "MarkerEdgeColor","black",...
                    "MarkerFaceColor","g",...
                    "MarkerSize",10);
                text(Barycenter(:,j)-150,Barycenter(:,j)-500,['Cluster N°' num2str(j)])
                
            elseif (j == 2)
                plot(Barycenter(:,j),Barycenter(:,j),"^","LineWidth",1.3,...
                    "MarkerEdgeColor","black",...
                    "MarkerFaceColor","y",...
                    "MarkerSize",10);
                text(Barycenter(:,j)-150,Barycenter(:,j)-500,['Cluster N°' num2str(j)])
                
            else
                plot(Barycenter(:,j),Barycenter(:,j),"^","LineWidth",1.3,...
                    "MarkerEdgeColor","black",...
                    "MarkerFaceColor","r",...
                    "MarkerSize",10);
                text(Barycenter(:,j)-150,Barycenter(:,j)-500,['Cluster N°' num2str(j)])
                
            end
            
        end
        
        % The lines are graphed according to the Point, Barycenter and Cluster
        for n = 1 : length(Cluster)
               
            plot([Vector(:,n),Barycenter(:,Cluster(:,n))], [Vector_2(:,n), Barycenter(:,Cluster(:,n))],"black--");
            
            if Cluster(:,n) == 1
                plot(Vector(:,n), Vector_2(:,n),".","MarkerSize",20,"MarkerEdgeColor","g","MarkerFaceColor","g");
                
            elseif Cluster(:,n) == 2
                plot(Vector(:,n), Vector_2(:,n),".","MarkerSize",20,"MarkerEdgeColor","y","MarkerFaceColor","y");
                
            else
                plot(Vector(:,n), Vector_2(:,n),".","MarkerSize",20,"MarkerEdgeColor","r","MarkerFaceColor","r");
                
            end

            pause(0.025);
            
        end
        hold off
        pause(0.75);

    end
    
    % The Barycenters are recalculated using the current Cluster Positions:

    % Fix for Barycenters
    Barycenter = zeros(Dimension_Vector,k);
    
    % For each Cluster the new Centroid is calculated (Update Step)
    for x_Barycenter = 1:k
        Barycenter(:,x_Barycenter) = mean(Vector(:,Cluster == x_Barycenter));
    end
    
    % The Stop variable must be true, when the Clusters no longer change or reach convergence.
    if Cluster_Prev == Cluster
        Stop = true;
    end
    
    % The Cluster is updated with the Previous Cluster and iterates again.
    Cluster_Prev = Cluster;
    Iterations = Iterations + 1;
    
end

fprintf("\nThe K-means Algorithm used %d Iterations to achieve convergence. \n\n",Iterations);

end
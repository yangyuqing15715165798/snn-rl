classdef Monitor < handle
    %MONITOR record and plot net activity
    
    properties
        interactive = true;
        history;
        plotType = 'squares';
        figHandle;
        subPlot = false;
        subPlot_m;
        subPlot_n;
        subPlot_p;
    end
    
    methods
        function obj = Monitor()
            obj.figHandle = figure();
        end
        function setInteractive(obj,parameter)
            obj.interactive = parameter;
        end
        function setPlotType(obj,string)
            obj.plotType = string;
        end
        function setSubPlot(obj,figure,m,n,p)
            obj.figHandle = figure;
            obj.subPlot_m = m;
            obj.subPlot_n = n;
            obj.subPlot_p = p;
            obj.subPlot = true;
        end
        
        
        function record(obj,time,data)
            obj.history{1,end+1} = time;
            obj.history{2,end} = data;
            
            if(obj.subPlot)  
                figure(obj.figHandle);
                subplot(obj.subPlot_m,obj.subPlot_n,obj.subPlot_p);
            end
            
            if (strcmp(obj.plotType,'line'))
                obj.linePlot;
            elseif (strcmp(obj.plotType,'squares'))
                obj.squaresPlot;
            end
        end
        
        function linePlot(obj)
            time = [obj.history{1,:}];
            data = [obj.history{2,:}];
            for line = 1:length(obj.history{2,1})
            hold on;
                plot(time,data(line,:)*0.8+line);
            end
            drawnow;
        end
        
        function squaresPlot(obj)            
            time = [obj.history{1,:}];
            data = [obj.history{2,:}];
            
          
            %start = (index-graphResolution)*(index>graphResolution)+1;
            if( length(time) > 20)
                start = length(time) - 20;
            else
                start = 1;
            end
            
            timeFrame = data(:,start:end);
            pcolor([[timeFrame zeros(size(timeFrame,1),1)] ; zeros(1,size(timeFrame,2)+1)]);
            colormap([0 0 0 ; 0 1 0]);
            axis ij;
            axis square;
            drawnow;
        end
    end
    
end

function [T, I] = formatTrajectory(plotInfo)

%This function takes plotInfo and reformats it in the form of time-based

%Save initial configuration:
names = fieldnames(plotInfo.data(1).state);
for i=1:length(names);
    I.(names{i}) = plotInfo.data(1).state.(names{i})(1);
end

nPhase = length(plotInfo.data);
T = zeros(nPhase,0);
for i=1:nPhase   %loop through each phase
    D = plotInfo.data(i);
    t = D.time;
    t = t - t(1);
    T(i).phase = D.phase;
    T(i).time = t;
    switch D.phase
        case 'D'
            T(i).actuators = [...
                D.control.F1,...
                D.control.F2];
            
            T(i).state = [...
                D.state.x0,...
                D.state.y0,...
                D.state.dx0,...
                D.state.dy0];
            
        case {'S1','S2'}
            T(i).actuators = [...
                D.control.F1,...
                D.control.F2,...
                D.control.T1,...
                D.control.Thip];
            
            T(i).state = [...
                D.state.th1,...
                D.state.th2,...
                D.state.L1,...
                D.state.L2,...
                D.state.dth1,...
                D.state.dth2,...
                D.state.dL1,...
                D.state.dL2];
        case 'F'
            T(i).actuators = [...
                D.control.F1,...
                D.control.F2,...
                D.control.Thip];
            
            T(i).state = [...
                D.state.x,...
                D.state.y,...
                D.state.th1,...
                D.state.th2,...
                D.state.L1,...
                D.state.L2,...
                D.state.dx,...
                D.state.dy,...
                D.state.dth1,...
                D.state.dth2,...
                D.state.dL1,...
                D.state.dL2];
    end
    
end
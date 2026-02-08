% function test_success = run_diagnostics_dbs(test_cpod, test_AO_connection, test_AO_stim, test_ptb_display )
% %RUN_DIAGNOSTICS_DBS Attempts to run diagnostic scripts and gives data
% %related to failed test. If the function returns 
% 
% %% Input handling
% if nargin < 1
%     test.cpod = 1;
% else
%     test.cpod = test_cpod;
% end
% if nargin < 2
%     test.AO_connection = 1;
% else
%     test.AO_connection = test_AO_connection;
% end
% if nargin < 3
%     test.AO_stim = 1;
% else
%    test.AO_stim = test_AO_stim;
% end
% if nargin < 4
%     test.ptb_display = 1;
% else
%     test.ptb_display = test_ptb_display;
% end
% 
% %% Manual inputs (debug mode)
% test.cpod = 1;
% test.AO_connection = 1;
% test.AO_stim = 1;
% test.ptb_display = 1;
% 
% %% Pathing
% mfilePath = mfilename('fullpath'); 
% if contains(mfilePath,'LiveEditorEvaluationHelper') || isempty(mfilePath)
%     mfilePath = matlab.desktop.editor.getActiveFilename; % Get's active file name for relative pathing
% end
% parsePath = strsplit(mfilePath,{'/','\'}); 
% mDirPath = strjoin(parsePath(1:end-1),'/'); % Remove file from path str
% addpath(genpath([mDirPath '/helpers']))
% 
% %% Test C-Pod Connection
% if test.cpod
% try
%     cpod_connect_R2017b(1)
% catch e
% disp('Error found for C-Pod Connection')
% error(e.message)
% end
% end

%% Test C-Pod Connection (Alt Method)
if test.cpod
% try
    cpod_connect_R2017b_in_testing(1)
% catch e
% disp('Error found for C-Pod Connection')
% error(e.message)
% end
end       

% %% Test AO Connection
% if test.AO_connection
% try
%     path.AO = 'C:\Users\ZLab\Documents\AlphaOmega\matlabDirectory';
%     addpath(genpath(path.AO))
%     [DspMac, PcMac] = set_address_DBS();
%     AdpaterIndex = -1;
%     [~] = AO_startConnection(DspMac,PcMac,AdpaterIndex);
%     connected = AO_IsConnected;
% 
%     for j=1:10
%         disp(j);
%         pause(1);
%         connected = AO_IsConnected;
%         if connected == 1
%             break
%         end
%     end
% 
%     if connected
%         fprintf('AO Connected\n')
%     else
%         fprintf('AO Not Connected\n')
%     end
%     AO_CloseConnection();
% catch e
% disp('Error found for AO_Connection')
% error(e.message)
% end
% end
% 
% %% Test AO Stim
% clc;
% if test.AO_stim && test.AO_connection            % Must be connected to stimulate
% % try
%     % Connecting
%     path.AO = 'C:\Users\ZLab\Documents\AlphaOmega\matlabDirectory';
%     addpath(genpath(path.AO))
%     [DspMac, PcMac] = set_address_DBS();         % Gets the PC and AO addresses
%     AdpaterIndex = -1;
%     [~] = AO_startConnection(DspMac,PcMac,AdpaterIndex);   % Establishing connection between the computer and AO ?
%     pause(1)
%     if AO_IsConnected
%         fprintf('AO Connected\n')
%     else
%         fprintf('AO Not Connected\n')
%     end
% 
%     % Setting stimulation parameters.
%     StimChannel='SPK 01';                        % stimulation channel name as appears in software - the microtip ?
%     FirstPhaseDelay_mS=0;
%     FirstPhaseAmpl_mA= -0.05;
%     FirstPhaseWidth_mS= 0.06;
%     SecondPhaseDelay_mS=FirstPhaseDelay_mS;      % Timing is the same as the first phase
%     SecondPhaseAmpl_mA= -FirstPhaseAmpl_mA;      % Polarity is the opposite as the first phase (why ?)
%     SecondPhaseWidth_mS=FirstPhaseWidth_mS;      % Same width as the first phase
%     Freq_hZ=130;                                 % Stimulating at 130 Hz
%     Duration_sec=1;                              % Stimulating for 1 second
%     ReturnChannel=-1;                            % ?
% 
%     nameLength=length(StimChannel );
%     stim_channel=AO_TranslateNameToID( StimChannel , nameLength );
% 
%     num_repetitions = 4;           % Stimulation runs 4 times (4 trials ?)
%     pause_duration = 1;            % 1 second pause between trials
%     for i = 1:num_repetitions      % Delivers stim at 130 Hz for 1 second, 1 second rest, repeats 4 times
%         [~]= AO_StartDigitalStimulation(stim_channel, FirstPhaseDelay_mS, ...
%         FirstPhaseAmpl_mA, FirstPhaseWidth_mS, SecondPhaseDelay_mS, SecondPhaseAmpl_mA, ...
%         SecondPhaseWidth_mS, Freq_hZ, Duration_sec, ReturnChannel);
%         pause(pause_duration)
%     end
% 
% 
% %     [~] = AO_StopStimulation(-1);      % Will stop all stimulation
% 
%     AO_CloseConnection();
% % catch e
% % disp('Error found for Stimulation')
% % error(e.message)
% % end
% end
% 
% %% Test AO Stim (SNr)
% clc;
% if test.AO_stim && test.AO_connection % Must be connected to stimulate
% % try
%     % Connecting
%     path.AO = 'C:\Users\ZLab\Documents\AlphaOmega\matlabDirectory';
%     addpath(genpath(path.AO))
%     [DspMac, PcMac] = set_address_DBS();
%     AdpaterIndex = -1;
%     [~] = AO_startConnection(DspMac,PcMac,AdpaterIndex);
%     pause(1)
%     if AO_IsConnected
%         fprintf('AO Connected\n')
%     else
%         fprintf('AO Not Connected\n')
%     end
% 
%     % Setting stimulation parameters.
%     StimChannel='SPK 01'; % stimulation channel name as appears in software
%     FirstPhaseDelay_mS=0;
%     FirstPhaseAmpl_mA= -0.05;
%     FirstPhaseWidth_mS= 0.06;
%     SecondPhaseDelay_mS=FirstPhaseDelay_mS;         
%     SecondPhaseAmpl_mA= -FirstPhaseAmpl_mA;          
%     SecondPhaseWidth_mS=FirstPhaseWidth_mS;         
%     Freq_hZ=90;
%     Duration_sec=0.5;
%     ReturnChannel=-1;
% 
%     nameLength=length(StimChannel );
%     stim_channel=AO_TranslateNameToID( StimChannel , nameLength );
% 
% 
%     num_repetitions = 25;
%     pause_duration = 10;
%     for i = 1:num_repetitions
%         disp(i)
%         [~]= AO_StartDigitalStimulation(stim_channel, FirstPhaseDelay_mS, ...
%         FirstPhaseAmpl_mA, FirstPhaseWidth_mS, SecondPhaseDelay_mS, SecondPhaseAmpl_mA, ...
%         SecondPhaseWidth_mS, Freq_hZ, Duration_sec, ReturnChannel);
%         pause(pause_duration)
%     end
% 
% 
% %     [~] = AO_StopStimulation(-1);
% 
%     AO_CloseConnection();
% % catch e
% % disp('Error found for Stimulation')
% % error(e.message)
% % end
% end

%% Test AO Stim (STN-theta)
clc;
if test.AO_stim && test.AO_connection % Must be connected to stimulate
% try
    % Connecting
    path.AO = 'C:\Users\ZLab\Documents\AlphaOmega\matlabDirectory';
    addpath(genpath(path.AO))
    [DspMac, PcMac] = set_address_DBS();
    AdpaterIndex = -1;
    [~] = AO_startConnection(DspMac,PcMac,AdpaterIndex);
    pause(1)
    if AO_IsConnected
        fprintf('AO Connected\n')
    else
        fprintf('AO Not Connected\n')
    end
    
    % Setting stimulation parameters.
    StimChannel='SPK 01'; % stimulation channel name as appears in software
    FirstPhaseDelay_mS=0;
    FirstPhaseAmpl_mA= -0.05;
    FirstPhaseWidth_mS= 0.06;
    SecondPhaseDelay_mS=FirstPhaseDelay_mS;
    SecondPhaseAmpl_mA= -FirstPhaseAmpl_mA;
    SecondPhaseWidth_mS=FirstPhaseWidth_mS;
    Freq_hZ=6;
    Duration_sec=4;
    ReturnChannel=-1;
    
    nameLength=length(StimChannel );
    stim_channel=AO_TranslateNameToID( StimChannel , nameLength );
    
    
    num_repetitions = 25;
    pause_duration = 4;
    for i = 1:num_repetitions
        disp(i)
        [~]= AO_StartDigitalStimulation(stim_channel, FirstPhaseDelay_mS, ...
        FirstPhaseAmpl_mA, FirstPhaseWidth_mS, SecondPhaseDelay_mS, SecondPhaseAmpl_mA, ...
        SecondPhaseWidth_mS, Freq_hZ, Duration_sec, ReturnChannel);
        pause(pause_duration)
        
    end

    
%     [~] = AO_StopStimulation(-1);
    
    AO_CloseConnection();
% catch e
% disp('Error found for Stimulation')
% error(e.message)
% end
end

%% Test AO Stim (STN-gamma)
clc;
if test.AO_stim && test.AO_connection % Must be connected to stimulate
% try
    % Connecting
    path.AO = 'C:\Users\ZLab\Documents\AlphaOmega\matlabDirectory';
    addpath(genpath(path.AO))
    [DspMac, PcMac] = set_address_DBS();
    AdpaterIndex = -1;
    [~] = AO_startConnection(DspMac,PcMac,AdpaterIndex);
    pause(1)
    if AO_IsConnected
        fprintf('AO Connected\n')
    else
        fprintf('AO Not Connected\n')
    end
    
    % Setting stimulation parameters.
    StimChannel='SPK 01'; % stimulation channel name as appears in software
    FirstPhaseDelay_mS=0;
    FirstPhaseAmpl_mA= -0.05;
    FirstPhaseWidth_mS= 0.06;
    SecondPhaseDelay_mS=FirstPhaseDelay_mS;
    SecondPhaseAmpl_mA= -FirstPhaseAmpl_mA;
    SecondPhaseWidth_mS=FirstPhaseWidth_mS;
    Freq_hZ=130;
    Duration_sec=4;
    ReturnChannel=-1;
    
    nameLength=length(StimChannel );
    stim_channel=AO_TranslateNameToID( StimChannel , nameLength );
    
    
    num_repetitions = 25;
    pause_duration = 4;
    for i = 1:num_repetitions
        disp(i)
        [~]= AO_StartDigitalStimulation(stim_channel, FirstPhaseDelay_mS, ...
        FirstPhaseAmpl_mA, FirstPhaseWidth_mS, SecondPhaseDelay_mS, SecondPhaseAmpl_mA, ...
        SecondPhaseWidth_mS, Freq_hZ, Duration_sec, ReturnChannel);
        pause(pause_duration)
        
    end

    
%     [~] = AO_StopStimulation(-1);
    
    AO_CloseConnection();
% catch e
% disp('Error found for Stimulation')
% error(e.message)
% end
end

%% Test PTB External Display
% Please ensure you are connected to an external monitor
if test.ptb_display == 1
try
    sampleStop % Executes the sample task to initially test out the display.
    % TODO: Replace later with a sample DBS task. 
catch e
disp('Error found for PTB external display')
error(e.message)
end

end



%% Test Summary
test_success = 0;
fprintf('Result: %d', test_success)

end
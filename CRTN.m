classdef CRTN < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        BasicCRTNTab                    matlab.ui.container.Tab
        TotalNumberofVehiclesinsampleperiodQValueEditFieldLabel  matlab.ui.control.Label
        TotalNumberofVehiclesinsampleperiodQValueEditField  matlab.ui.control.NumericEditField
        Vehicletotalfor1hourLA101hror18hoursLA1018hrLabel  matlab.ui.control.Label
        ButtonGroup                     matlab.ui.container.ButtonGroup
        LA101hrButton                   matlab.ui.control.RadioButton
        LA1018hrButton                  matlab.ui.control.RadioButton
        ButtonGroup_2                   matlab.ui.container.ButtonGroup
        MinutesButton                   matlab.ui.control.RadioButton
        HourButton                      matlab.ui.control.RadioButton
        HoursButton                     matlab.ui.control.RadioButton
        TotallengthofsampleperiodforthevehiclescountedLabel  matlab.ui.control.Label
        HGVCorrectionTab                matlab.ui.container.Tab
        NumberoflargevehiclesHGVsEditFieldLabel  matlab.ui.control.Label
        NumberoflargevehiclesHGVsEditField  matlab.ui.control.NumericEditField
        AverageVelocityofVehiclesEditFieldLabel  matlab.ui.control.Label
        AverageVelocityofVehiclesEditField  matlab.ui.control.NumericEditField
        Switch                          matlab.ui.control.Switch
        VehicleVelocityinKilometersorMilesperHourLabel  matlab.ui.control.Label
        DistanceCorrectionTab           matlab.ui.container.Tab
        DistancefromroadinmetersEditFieldLabel  matlab.ui.control.Label
        DistancefromroadinmetersEditField  matlab.ui.control.NumericEditField
        MLabel                          matlab.ui.control.Label
        AngularCorrectionTab            matlab.ui.container.Tab
        WhatangleoftheroadcanbeseenInDegreesEditFieldLabel  matlab.ui.control.Label
        WhatangleoftheroadcanbeseenInDegreesEditField  matlab.ui.control.NumericEditField
        SingleBarrierCorrectionatOneFrequencyTab  matlab.ui.container.Tab
        HeightofBarrierMetersEditFieldLabel  matlab.ui.control.Label
        HeightofBarrierMetersEditField  matlab.ui.control.NumericEditField
        DistancefromBarriertoroadMetersEditFieldLabel  matlab.ui.control.Label
        DistancefromBarriertoroadMetersEditField  matlab.ui.control.NumericEditField
        MeasurementpositiondistancefromroadMetersEditFieldLabel  matlab.ui.control.Label
        MeasurementpositiondistancefromroadMetersEditField  matlab.ui.control.NumericEditField
        FrequencyHZEditFieldLabel       matlab.ui.control.Label
        FrequencyHZEditField            matlab.ui.control.NumericEditField
        MLabel_2                        matlab.ui.control.Label
        MLabel_3                        matlab.ui.control.Label
        MLabel_4                        matlab.ui.control.Label
        HZLabel                         matlab.ui.control.Label
        DistanceabovegroundatreceivingReceiverMetersEditFieldLabel  matlab.ui.control.Label
        DistanceabovegroundatreceivingReceiverMetersEditField  matlab.ui.control.NumericEditField
        DistanceabovegroundatsourceMetersEditFieldLabel  matlab.ui.control.Label
        DistanceabovegroundatsourceMetersEditField  matlab.ui.control.NumericEditField
        MLabel_5                        matlab.ui.control.Label
        MLabel_6                        matlab.ui.control.Label
        GradientTab                     matlab.ui.container.Tab
        GradientvalueasapercentageEditFieldLabel  matlab.ui.control.Label
        GradientvalueasapercentageEditField  matlab.ui.control.NumericEditField
        Label                           matlab.ui.control.Label
        TotalCRTNEditFieldLabel         matlab.ui.control.Label
        TotalCRTNEditField              matlab.ui.control.NumericEditField
        CalculateButton                 matlab.ui.control.Button
        ResetCalculatorButton           matlab.ui.control.Button
        DistanceCorrectionValueLabel    matlab.ui.control.Label
        DistanceCorrectionValueEditField  matlab.ui.control.NumericEditField
        HGVCorrectionValueEditFieldLabel  matlab.ui.control.Label
        HGVCorrectionValueEditField     matlab.ui.control.NumericEditField
        CRTNNocorrectionEditFieldLabel  matlab.ui.control.Label
        CRTNNocorrectionEditField       matlab.ui.control.NumericEditField
        AngularcorrectionValueLabel     matlab.ui.control.Label
        AngularcorrectionValueEditField  matlab.ui.control.NumericEditField
        dBLabel                         matlab.ui.control.Label
        dBLabel_2                       matlab.ui.control.Label
        dBLabel_3                       matlab.ui.control.Label
        dBLabel_4                       matlab.ui.control.Label
        dBLabel_5                       matlab.ui.control.Label
        CRTNCalculatorLabel             matlab.ui.control.Label
        BarrierCorrectionValueEditFieldLabel  matlab.ui.control.Label
        BarrierCorrectionValueEditField  matlab.ui.control.NumericEditField
        dBLabel_6                       matlab.ui.control.Label
        GradientCorrectionValueEditFieldLabel  matlab.ui.control.Label
        GradientCorrectionValueEditField  matlab.ui.control.NumericEditField
        dBLabel_7                       matlab.ui.control.Label
    end

    methods (Access = private)

        % Button pushed function: CalculateButton
        function CalculateButtonPushed(app, ~)
            %%CRTN
            Q=app.TotalNumberofVehiclesinsampleperiodQValueEditField.Value; % Number of vehicles Variable

            %%HGV
            V= app.AverageVelocityofVehiclesEditField.Value;   % Velocity of Large vehicles
            P= ((app.NumberoflargevehiclesHGVsEditField.Value)/Q)*100; % Percent of large vehicles
            MPKM=app.Switch.Value;                                     % Switch Variable Name
            
            %%Distance Correction
            R2=app.DistancefromroadinmetersEditField.Value;                % Distance from Road
            
            %%Angular Correction
            angle=app.WhatangleoftheroadcanbeseenInDegreesEditField.Value; % Angle of visible road
            
            %%Barrier
            HB=app.HeightofBarrierMetersEditField.Value;                        % Height of the barrier
            DFR=app.MeasurementpositiondistancefromroadMetersEditField.Value;   % Distance from road
            RTB=app.DistancefromBarriertoroadMetersEditField.Value;
            HRP=app.DistanceabovegroundatreceivingReceiverMetersEditField.Value;
            HAS=app.DistanceabovegroundatsourceMetersEditField.Value;
            Freq=app.FrequencyHZEditField.Value;                                  % Frequency
           
            %% Gradient
            Gradient=app.GradientvalueasapercentageEditField.Value;
             
            %CRTN Vehicle Estimation for periods and adjustments for LA10 1HR and 18Hr
            if (app.MinutesButton.Value)&&(app.LA101hrButton.Value) 
            QA=Q*12;
            elseif (app.HourButton.Value)&&(app.LA101hrButton.Value) 
            QA=Q;
            elseif (app.HoursButton.Value)&&(app.LA101hrButton.Value)
            QA=0;
            msgbox('Unreliable for calculating LA10, please use LA10 18hr or a different approximation.');
            elseif (app.MinutesButton.Value)&&(app.LA1018hrButton.Value) 
            QA=Q*12*18;
            elseif (app.HourButton.Value)&&(app.LA1018hrButton.Value) 
            QA=Q*18;
            elseif (app.HoursButton.Value)&&(app.LA1018hrButton.Value)
            QA=Q;
            end

            %%CRTN Calculation                  
            if (QA==0)                          %If the Q value=0
                LA=0;                           %Set output value to 0 to avoid error       
            elseif(app.LA101hrButton.Value)     %set for LA1hr
                LA= 42.2 + 10*log10(QA);
            elseif (app.LA1018hrButton.Value)   %Set for LA18hr
                LA=29.1+10*log10(QA);
            end
                                             
            % HGV mph and kmh alteration
            if strcmp(MPKM,'KM/H')
                VA=V;
            elseif strcmp(MPKM,'MPH')
                VA=V*1.609344;
            end
            %%HGV Correction
            if (VA == 0)
                HVGC=0;
            else
                HVGC=33*log10(VA+40+(500/VA))+10*log10(1+(5*(P)/VA))-68.8;
            end
            
            %% Distance Correction
            if  (R2==0)
                DC=0;
            else
                DC=10*log10(R2/13.5);
            end
            
            %%Angular Correction
            if (angle==0)
                AC =0;
            else
                AC=10*log10(angle/180);
            end
            
            %% Barrier
            if (HB==0)
                Barrier=0;
            else
                BMP=DFR-RTB;%Distance from barrier to measurement position 
                HBFR=HB-HRP;%Difference in height between barrier and receiver position
                HBFS=HB-HAS;%Differnce in height between the barrier and source position
                CA=((BMP.^2)+(HBFR.^2)); 
                CAA=sqrt(CA); %%Total length of Hypotenuse A(From Barrier to Receiver position)
                CB=((HBFS.^2)+(RTB.^2));
                CBB=sqrt(CB); %%Total length of Hypotenuse B(From Barrier to Sourse)
                CT=(CAA+CBB)-DFR; %%Differnce between total length of the two hypotenuses 
                %minus distance away from the room
                C=343/Freq; %Calculation for wavelength
                N=(2*CT)/C; %Coefficient N
                Barrier=10*log10(3+(20*N)); %Barrier correction figure    
            end
            
            %% Gradient
             if (Gradient==0)
                 G=0;
             else
                 G=0.3*Gradient;
             end
            
            app.TotalCRTNEditField.Value=LA+HVGC-DC+AC+G+Barrier;                 
            app.CRTNNocorrectionEditField.Value=LA;
            app.HGVCorrectionValueEditField.Value=HVGC;
            app.DistanceCorrectionValueEditField.Value=DC;
            app.AngularcorrectionValueEditField.Value=AC;
            app.BarrierCorrectionValueEditField.Value=Barrier;
            app.GradientCorrectionValueEditField.Value=G;
        end

        % Callback function
        function CheckBoxValueChanged(~, ~)
            
        end

        % Callback function
        function CheckBox_2ValueChanged(~, ~)
            
        end

        % Value changed function: TotalCRTNEditField
        function TotalCRTNEditFieldValueChanged(~, ~)
            
            
        end

        % Button pushed function: ResetCalculatorButton
        function ResetCalculatorButtonPushed(app, ~)
            app.TotalNumberofVehiclesinsampleperiodQValueEditField.Value=0;
            app.NumberoflargevehiclesHGVsEditField.Value=0;
            app.AverageVelocityofVehiclesEditField.Value=0;
            app.DistancefromroadinmetersEditField.Value=0;
            app.WhatangleoftheroadcanbeseenInDegreesEditField.Value=0;
            app.TotalCRTNEditField.Value=0;                   %% Total with corrections in results field
            app.CRTNNocorrectionEditField.Value=0;
            app.HGVCorrectionValueEditField.Value=0;
            app.DistanceCorrectionValueEditField.Value=0;
            app.AngularcorrectionValueEditField.Value=0;
            app.HeightofBarrierMetersEditField.Value=0;
            app.DistancefromBarriertoroadMetersEditField.Value=0;
            app.MeasurementpositiondistancefromroadMetersEditField.Value=0;
            app.FrequencyHZEditField.Value=0;
            app.DistanceabovegroundatreceivingReceiverMetersEditField.Value=0;
            app.DistanceabovegroundatsourceMetersEditField.Value=0;
            app.BarrierCorrectionValueEditField.Value=0;
        end

        % Value changed function: 
        % TotalNumberofVehiclesinsampleperiodQValueEditField
        function TotalNumberofVehiclesinsampleperiodQValueEditFieldValueChanged(~, ~)
            
        end

        % Value changed function: Switch
        function SwitchValueChanged(~, ~)
            
        end

        % Callback function
        function SampleperiodfortotalVehiclesDropDownValueChanged(~, ~)
            
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Color = [0.3137 0.8314 0.5294];
            app.UIFigure.Colormap = [0.2431 0.149 0.6588;0.251 0.1647 0.7059;0.2588 0.1804 0.7529;0.2627 0.1961 0.7961;0.2706 0.2157 0.8353;0.2745 0.2353 0.8706;0.2784 0.2549 0.898;0.2784 0.2784 0.9216;0.2824 0.302 0.9412;0.2824 0.3216 0.9569;0.2784 0.3451 0.9725;0.2745 0.3686 0.9843;0.2706 0.3882 0.9922;0.2588 0.4118 0.9961;0.2431 0.4353 1;0.2196 0.4588 0.9961;0.1961 0.4863 0.9882;0.1843 0.5059 0.9804;0.1804 0.5294 0.9686;0.1765 0.549 0.9529;0.1686 0.5686 0.9373;0.1529 0.5922 0.9216;0.1451 0.6078 0.9098;0.1373 0.6275 0.898;0.1255 0.6471 0.8902;0.1098 0.6627 0.8745;0.0941 0.6784 0.8588;0.0706 0.6941 0.8392;0.0314 0.7098 0.8157;0.0039 0.7216 0.7922;0.0078 0.7294 0.7647;0.0431 0.7412 0.7412;0.098 0.749 0.7137;0.1412 0.7569 0.6824;0.1725 0.7686 0.6549;0.1922 0.7765 0.6235;0.2157 0.7843 0.5922;0.2471 0.7922 0.5569;0.2902 0.7961 0.5176;0.3412 0.8 0.4784;0.3922 0.8039 0.4353;0.4471 0.8039 0.3922;0.5059 0.8 0.349;0.5608 0.7961 0.3059;0.6157 0.7882 0.2627;0.6706 0.7804 0.2235;0.7255 0.7686 0.1922;0.7725 0.7608 0.1647;0.8196 0.749 0.1529;0.8627 0.7412 0.1608;0.902 0.7333 0.1765;0.9412 0.7294 0.2118;0.9725 0.7294 0.2392;0.9961 0.7451 0.2353;0.9961 0.7647 0.2196;0.9961 0.7882 0.2039;0.9882 0.8118 0.1882;0.9804 0.8392 0.1765;0.9686 0.8627 0.1647;0.9608 0.8902 0.1529;0.9608 0.9137 0.1412;0.9647 0.9373 0.1255;0.9686 0.9608 0.1059;0.9765 0.9843 0.0824];
            app.UIFigure.Position = [200 200 556 536];
            app.UIFigure.Name = 'UI Figure';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.AutoResizeChildren = 'off';
            app.TabGroup.Position = [18 202 522 257];

            % Create BasicCRTNTab
            app.BasicCRTNTab = uitab(app.TabGroup);
            app.BasicCRTNTab.AutoResizeChildren = 'off';
            app.BasicCRTNTab.Title = 'Basic CRTN';
            app.BasicCRTNTab.BackgroundColor = [1 1 1];

            % Create TotalNumberofVehiclesinsampleperiodQValueEditFieldLabel
            app.TotalNumberofVehiclesinsampleperiodQValueEditFieldLabel = uilabel(app.BasicCRTNTab);
            app.TotalNumberofVehiclesinsampleperiodQValueEditFieldLabel.FontName = 'Calibri';
            app.TotalNumberofVehiclesinsampleperiodQValueEditFieldLabel.FontSize = 15;
            app.TotalNumberofVehiclesinsampleperiodQValueEditFieldLabel.FontWeight = 'bold';
            app.TotalNumberofVehiclesinsampleperiodQValueEditFieldLabel.Position = [9 189 334 22];
            app.TotalNumberofVehiclesinsampleperiodQValueEditFieldLabel.Text = 'Total Number of Vehicles in sample period (Q Value)';

            % Create TotalNumberofVehiclesinsampleperiodQValueEditField
            app.TotalNumberofVehiclesinsampleperiodQValueEditField = uieditfield(app.BasicCRTNTab, 'numeric');
            app.TotalNumberofVehiclesinsampleperiodQValueEditField.Limits = [0 Inf];
            app.TotalNumberofVehiclesinsampleperiodQValueEditField.RoundFractionalValues = 'on';
            app.TotalNumberofVehiclesinsampleperiodQValueEditField.ValueChangedFcn = createCallbackFcn(app, @TotalNumberofVehiclesinsampleperiodQValueEditFieldValueChanged, true);
            app.TotalNumberofVehiclesinsampleperiodQValueEditField.FontName = 'Calibri';
            app.TotalNumberofVehiclesinsampleperiodQValueEditField.FontSize = 15;
            app.TotalNumberofVehiclesinsampleperiodQValueEditField.FontWeight = 'bold';
            app.TotalNumberofVehiclesinsampleperiodQValueEditField.Position = [359 189 131 22];

            % Create Vehicletotalfor1hourLA101hror18hoursLA1018hrLabel
            app.Vehicletotalfor1hourLA101hror18hoursLA1018hrLabel = uilabel(app.BasicCRTNTab);
            app.Vehicletotalfor1hourLA101hror18hoursLA1018hrLabel.FontName = 'Calibri';
            app.Vehicletotalfor1hourLA101hror18hoursLA1018hrLabel.FontSize = 14;
            app.Vehicletotalfor1hourLA101hror18hoursLA1018hrLabel.FontWeight = 'bold';
            app.Vehicletotalfor1hourLA101hror18hoursLA1018hrLabel.Position = [9 52 410 28];
            app.Vehicletotalfor1hourLA101hror18hoursLA1018hrLabel.Text = 'Vehicle total for 1 hour (LA10 1hr) or 18 hours (LA10 18hr) ';

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.BasicCRTNTab);
            app.ButtonGroup.AutoResizeChildren = 'off';
            app.ButtonGroup.Tooltip = {'These options although you to pick between an LA10 18hr and LA 1hr calculation.'};
            app.ButtonGroup.ForegroundColor = [1 1 1];
            app.ButtonGroup.BorderType = 'none';
            app.ButtonGroup.TitlePosition = 'centertop';
            app.ButtonGroup.BackgroundColor = [1 1 1];
            app.ButtonGroup.FontName = 'Calibri';
            app.ButtonGroup.FontWeight = 'bold';
            app.ButtonGroup.FontSize = 14;
            app.ButtonGroup.Position = [359 24 131 56];

            % Create LA101hrButton
            app.LA101hrButton = uiradiobutton(app.ButtonGroup);
            app.LA101hrButton.Tooltip = {'This equation is meant to calculate the  road traffic noise level over a period of one hour.'};
            app.LA101hrButton.Text = 'LA10 1hr';
            app.LA101hrButton.FontName = 'Calibri';
            app.LA101hrButton.FontSize = 14;
            app.LA101hrButton.FontWeight = 'bold';
            app.LA101hrButton.Position = [6 32 79 22];
            app.LA101hrButton.Value = true;

            % Create LA1018hrButton
            app.LA1018hrButton = uiradiobutton(app.ButtonGroup);
            app.LA1018hrButton.Tooltip = {'This calculation measures the road traffic noise level over a period of 18 hours.'};
            app.LA1018hrButton.Text = 'LA10 18hr';
            app.LA1018hrButton.FontName = 'Calibri';
            app.LA1018hrButton.FontSize = 14;
            app.LA1018hrButton.FontWeight = 'bold';
            app.LA1018hrButton.Position = [6 6 79 22];

            % Create ButtonGroup_2
            app.ButtonGroup_2 = uibuttongroup(app.BasicCRTNTab);
            app.ButtonGroup_2.AutoResizeChildren = 'off';
            app.ButtonGroup_2.Tooltip = {'The number of vehicles will automatically adjust depending on your sample period.'};
            app.ButtonGroup_2.BorderType = 'none';
            app.ButtonGroup_2.TitlePosition = 'righttop';
            app.ButtonGroup_2.BackgroundColor = [1 1 1];
            app.ButtonGroup_2.FontName = 'Calibri';
            app.ButtonGroup_2.FontWeight = 'bold';
            app.ButtonGroup_2.FontSize = 14;
            app.ButtonGroup_2.Position = [359 93 131 79];

            % Create MinutesButton
            app.MinutesButton = uiradiobutton(app.ButtonGroup_2);
            app.MinutesButton.Text = '5 Minutes';
            app.MinutesButton.FontName = 'Calibri';
            app.MinutesButton.FontSize = 14;
            app.MinutesButton.FontWeight = 'bold';
            app.MinutesButton.Position = [6 53 85 22];
            app.MinutesButton.Value = true;

            % Create HourButton
            app.HourButton = uiradiobutton(app.ButtonGroup_2);
            app.HourButton.Text = '1 Hour';
            app.HourButton.FontName = 'Calibri';
            app.HourButton.FontSize = 14;
            app.HourButton.FontWeight = 'bold';
            app.HourButton.Position = [6 31 70 22];

            % Create HoursButton
            app.HoursButton = uiradiobutton(app.ButtonGroup_2);
            app.HoursButton.Text = '18 Hours';
            app.HoursButton.FontName = 'Calibri';
            app.HoursButton.FontSize = 14;
            app.HoursButton.FontWeight = 'bold';
            app.HoursButton.Position = [6 9 79 22];

            % Create TotallengthofsampleperiodforthevehiclescountedLabel
            app.TotallengthofsampleperiodforthevehiclescountedLabel = uilabel(app.BasicCRTNTab);
            app.TotallengthofsampleperiodforthevehiclescountedLabel.FontName = 'Calibri';
            app.TotallengthofsampleperiodforthevehiclescountedLabel.FontSize = 15;
            app.TotallengthofsampleperiodforthevehiclescountedLabel.FontWeight = 'bold';
            app.TotallengthofsampleperiodforthevehiclescountedLabel.Position = [9 150 345 22];
            app.TotallengthofsampleperiodforthevehiclescountedLabel.Text = 'Total length of sample period for the vehicles counted';

            % Create HGVCorrectionTab
            app.HGVCorrectionTab = uitab(app.TabGroup);
            app.HGVCorrectionTab.AutoResizeChildren = 'off';
            app.HGVCorrectionTab.Title = 'HGV Correction';
            app.HGVCorrectionTab.BackgroundColor = [1 1 1];

            % Create NumberoflargevehiclesHGVsEditFieldLabel
            app.NumberoflargevehiclesHGVsEditFieldLabel = uilabel(app.HGVCorrectionTab);
            app.NumberoflargevehiclesHGVsEditFieldLabel.VerticalAlignment = 'top';
            app.NumberoflargevehiclesHGVsEditFieldLabel.FontName = 'Calibri';
            app.NumberoflargevehiclesHGVsEditFieldLabel.FontSize = 15;
            app.NumberoflargevehiclesHGVsEditFieldLabel.FontWeight = 'bold';
            app.NumberoflargevehiclesHGVsEditFieldLabel.Position = [9 189 272 22];
            app.NumberoflargevehiclesHGVsEditFieldLabel.Text = 'Number of large vehicles (HGV''s)  ';

            % Create NumberoflargevehiclesHGVsEditField
            app.NumberoflargevehiclesHGVsEditField = uieditfield(app.HGVCorrectionTab, 'numeric');
            app.NumberoflargevehiclesHGVsEditField.Limits = [0 Inf];
            app.NumberoflargevehiclesHGVsEditField.FontName = 'Calibri';
            app.NumberoflargevehiclesHGVsEditField.FontSize = 15;
            app.NumberoflargevehiclesHGVsEditField.FontWeight = 'bold';
            app.NumberoflargevehiclesHGVsEditField.Tooltip = {'Total number of large vehicles counted within sample period.'};
            app.NumberoflargevehiclesHGVsEditField.Position = [359 189 90 22];

            % Create AverageVelocityofVehiclesEditFieldLabel
            app.AverageVelocityofVehiclesEditFieldLabel = uilabel(app.HGVCorrectionTab);
            app.AverageVelocityofVehiclesEditFieldLabel.VerticalAlignment = 'top';
            app.AverageVelocityofVehiclesEditFieldLabel.FontName = 'Calibri';
            app.AverageVelocityofVehiclesEditFieldLabel.FontSize = 15;
            app.AverageVelocityofVehiclesEditFieldLabel.FontWeight = 'bold';
            app.AverageVelocityofVehiclesEditFieldLabel.Position = [9 147 402 22];
            app.AverageVelocityofVehiclesEditFieldLabel.Text = 'Average Velocity of Vehicles';

            % Create AverageVelocityofVehiclesEditField
            app.AverageVelocityofVehiclesEditField = uieditfield(app.HGVCorrectionTab, 'numeric');
            app.AverageVelocityofVehiclesEditField.Limits = [0 Inf];
            app.AverageVelocityofVehiclesEditField.FontName = 'Calibri';
            app.AverageVelocityofVehiclesEditField.FontSize = 15;
            app.AverageVelocityofVehiclesEditField.FontWeight = 'bold';
            app.AverageVelocityofVehiclesEditField.Tooltip = {'Change the slider below to indicate Miles or Kilometers.'};
            app.AverageVelocityofVehiclesEditField.Position = [359 148 90 22];

            % Create Switch
            app.Switch = uiswitch(app.HGVCorrectionTab, 'slider');
            app.Switch.Items = {'KM/H', 'MPH'};
            app.Switch.ValueChangedFcn = createCallbackFcn(app, @SwitchValueChanged, true);
            app.Switch.FontName = 'Calibri';
            app.Switch.FontSize = 14;
            app.Switch.FontWeight = 'bold';
            app.Switch.Position = [380 102 45 20];
            app.Switch.Value = 'KM/H';

            % Create VehicleVelocityinKilometersorMilesperHourLabel
            app.VehicleVelocityinKilometersorMilesperHourLabel = uilabel(app.HGVCorrectionTab);
            app.VehicleVelocityinKilometersorMilesperHourLabel.FontName = 'Calibri';
            app.VehicleVelocityinKilometersorMilesperHourLabel.FontSize = 15;
            app.VehicleVelocityinKilometersorMilesperHourLabel.FontWeight = 'bold';
            app.VehicleVelocityinKilometersorMilesperHourLabel.Position = [9 101 306 22];
            app.VehicleVelocityinKilometersorMilesperHourLabel.Text = 'Vehicle Velocity in Kilometers or Miles per Hour';

            % Create DistanceCorrectionTab
            app.DistanceCorrectionTab = uitab(app.TabGroup);
            app.DistanceCorrectionTab.Title = 'Distance Correction';
            app.DistanceCorrectionTab.BackgroundColor = [1 1 1];

            % Create DistancefromroadinmetersEditFieldLabel
            app.DistancefromroadinmetersEditFieldLabel = uilabel(app.DistanceCorrectionTab);
            app.DistancefromroadinmetersEditFieldLabel.FontName = 'Calibri';
            app.DistancefromroadinmetersEditFieldLabel.FontSize = 15;
            app.DistancefromroadinmetersEditFieldLabel.FontWeight = 'bold';
            app.DistancefromroadinmetersEditFieldLabel.Position = [9 189 272 22];
            app.DistancefromroadinmetersEditFieldLabel.Text = 'Distance  from road in meters';

            % Create DistancefromroadinmetersEditField
            app.DistancefromroadinmetersEditField = uieditfield(app.DistanceCorrectionTab, 'numeric');
            app.DistancefromroadinmetersEditField.Limits = [0 Inf];
            app.DistancefromroadinmetersEditField.FontName = 'Calibri';
            app.DistancefromroadinmetersEditField.FontSize = 15;
            app.DistancefromroadinmetersEditField.FontWeight = 'bold';
            app.DistancefromroadinmetersEditField.Tooltip = {'How far away from the road was the measuring position?'};
            app.DistancefromroadinmetersEditField.Position = [359 189 90 22];

            % Create MLabel
            app.MLabel = uilabel(app.DistanceCorrectionTab);
            app.MLabel.FontName = 'Calibri';
            app.MLabel.FontSize = 14;
            app.MLabel.FontWeight = 'bold';
            app.MLabel.Position = [456 189 25 22];
            app.MLabel.Text = 'M';

            % Create AngularCorrectionTab
            app.AngularCorrectionTab = uitab(app.TabGroup);
            app.AngularCorrectionTab.Title = 'Angular Correction';
            app.AngularCorrectionTab.BackgroundColor = [1 1 1];

            % Create WhatangleoftheroadcanbeseenInDegreesEditFieldLabel
            app.WhatangleoftheroadcanbeseenInDegreesEditFieldLabel = uilabel(app.AngularCorrectionTab);
            app.WhatangleoftheroadcanbeseenInDegreesEditFieldLabel.FontName = 'Calibri';
            app.WhatangleoftheroadcanbeseenInDegreesEditFieldLabel.FontSize = 15;
            app.WhatangleoftheroadcanbeseenInDegreesEditFieldLabel.FontWeight = 'bold';
            app.WhatangleoftheroadcanbeseenInDegreesEditFieldLabel.Position = [9 189 315 22];
            app.WhatangleoftheroadcanbeseenInDegreesEditFieldLabel.Text = 'What angle of the road can be seen? (In Degrees)';

            % Create WhatangleoftheroadcanbeseenInDegreesEditField
            app.WhatangleoftheroadcanbeseenInDegreesEditField = uieditfield(app.AngularCorrectionTab, 'numeric');
            app.WhatangleoftheroadcanbeseenInDegreesEditField.Limits = [0 360];
            app.WhatangleoftheroadcanbeseenInDegreesEditField.FontName = 'Calibri';
            app.WhatangleoftheroadcanbeseenInDegreesEditField.FontSize = 15;
            app.WhatangleoftheroadcanbeseenInDegreesEditField.FontWeight = 'bold';
            app.WhatangleoftheroadcanbeseenInDegreesEditField.Position = [367 189 90 22];

            % Create SingleBarrierCorrectionatOneFrequencyTab
            app.SingleBarrierCorrectionatOneFrequencyTab = uitab(app.TabGroup);
            app.SingleBarrierCorrectionatOneFrequencyTab.Title = 'Single Barrier Correction at One Frequency';
            app.SingleBarrierCorrectionatOneFrequencyTab.BackgroundColor = [1 1 1];

            % Create HeightofBarrierMetersEditFieldLabel
            app.HeightofBarrierMetersEditFieldLabel = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.HeightofBarrierMetersEditFieldLabel.FontName = 'Calibri';
            app.HeightofBarrierMetersEditFieldLabel.FontSize = 15;
            app.HeightofBarrierMetersEditFieldLabel.FontWeight = 'bold';
            app.HeightofBarrierMetersEditFieldLabel.Position = [9 189 272 22];
            app.HeightofBarrierMetersEditFieldLabel.Text = 'Height of Barrier (Meters)';

            % Create HeightofBarrierMetersEditField
            app.HeightofBarrierMetersEditField = uieditfield(app.SingleBarrierCorrectionatOneFrequencyTab, 'numeric');
            app.HeightofBarrierMetersEditField.Limits = [0 Inf];
            app.HeightofBarrierMetersEditField.FontName = 'Calibri';
            app.HeightofBarrierMetersEditField.FontSize = 15;
            app.HeightofBarrierMetersEditField.Position = [367 189 90 22];

            % Create DistancefromBarriertoroadMetersEditFieldLabel
            app.DistancefromBarriertoroadMetersEditFieldLabel = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.DistancefromBarriertoroadMetersEditFieldLabel.FontName = 'Calibri';
            app.DistancefromBarriertoroadMetersEditFieldLabel.FontSize = 15;
            app.DistancefromBarriertoroadMetersEditFieldLabel.FontWeight = 'bold';
            app.DistancefromBarriertoroadMetersEditFieldLabel.Position = [9 153 272 22];
            app.DistancefromBarriertoroadMetersEditFieldLabel.Text = 'Distance from Barrier to road (Meters)';

            % Create DistancefromBarriertoroadMetersEditField
            app.DistancefromBarriertoroadMetersEditField = uieditfield(app.SingleBarrierCorrectionatOneFrequencyTab, 'numeric');
            app.DistancefromBarriertoroadMetersEditField.Limits = [0 Inf];
            app.DistancefromBarriertoroadMetersEditField.FontName = 'Calibri';
            app.DistancefromBarriertoroadMetersEditField.FontSize = 15;
            app.DistancefromBarriertoroadMetersEditField.Position = [367 153 90 22];

            % Create MeasurementpositiondistancefromroadMetersEditFieldLabel
            app.MeasurementpositiondistancefromroadMetersEditFieldLabel = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.MeasurementpositiondistancefromroadMetersEditFieldLabel.FontName = 'Calibri';
            app.MeasurementpositiondistancefromroadMetersEditFieldLabel.FontSize = 15;
            app.MeasurementpositiondistancefromroadMetersEditFieldLabel.FontWeight = 'bold';
            app.MeasurementpositiondistancefromroadMetersEditFieldLabel.Position = [9 117 330 22];
            app.MeasurementpositiondistancefromroadMetersEditFieldLabel.Text = 'Measurement position distance from road (Meters)';

            % Create MeasurementpositiondistancefromroadMetersEditField
            app.MeasurementpositiondistancefromroadMetersEditField = uieditfield(app.SingleBarrierCorrectionatOneFrequencyTab, 'numeric');
            app.MeasurementpositiondistancefromroadMetersEditField.Limits = [0 Inf];
            app.MeasurementpositiondistancefromroadMetersEditField.FontName = 'Calibri';
            app.MeasurementpositiondistancefromroadMetersEditField.FontSize = 15;
            app.MeasurementpositiondistancefromroadMetersEditField.Position = [367 117 90 22];

            % Create FrequencyHZEditFieldLabel
            app.FrequencyHZEditFieldLabel = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.FrequencyHZEditFieldLabel.FontName = 'Calibri';
            app.FrequencyHZEditFieldLabel.FontSize = 15;
            app.FrequencyHZEditFieldLabel.FontWeight = 'bold';
            app.FrequencyHZEditFieldLabel.Position = [9 17 99 22];
            app.FrequencyHZEditFieldLabel.Text = 'Frequency (HZ)';

            % Create FrequencyHZEditField
            app.FrequencyHZEditField = uieditfield(app.SingleBarrierCorrectionatOneFrequencyTab, 'numeric');
            app.FrequencyHZEditField.Limits = [0 20000];
            app.FrequencyHZEditField.FontName = 'Calibri';
            app.FrequencyHZEditField.FontSize = 15;
            app.FrequencyHZEditField.Position = [367 17 90 22];

            % Create MLabel_2
            app.MLabel_2 = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.MLabel_2.FontName = 'Calibri';
            app.MLabel_2.FontSize = 14;
            app.MLabel_2.FontWeight = 'bold';
            app.MLabel_2.Position = [465 189 25 22];
            app.MLabel_2.Text = 'M';

            % Create MLabel_3
            app.MLabel_3 = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.MLabel_3.FontName = 'Calibri';
            app.MLabel_3.FontSize = 14;
            app.MLabel_3.FontWeight = 'bold';
            app.MLabel_3.Position = [465 153 25 22];
            app.MLabel_3.Text = 'M';

            % Create MLabel_4
            app.MLabel_4 = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.MLabel_4.FontName = 'Calibri';
            app.MLabel_4.FontSize = 14;
            app.MLabel_4.FontWeight = 'bold';
            app.MLabel_4.Position = [465 117 25 22];
            app.MLabel_4.Text = 'M';

            % Create HZLabel
            app.HZLabel = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.HZLabel.FontName = 'Calibri';
            app.HZLabel.FontSize = 14;
            app.HZLabel.FontWeight = 'bold';
            app.HZLabel.Position = [465 17 25 22];
            app.HZLabel.Text = 'HZ';

            % Create DistanceabovegroundatreceivingReceiverMetersEditFieldLabel
            app.DistanceabovegroundatreceivingReceiverMetersEditFieldLabel = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.DistanceabovegroundatreceivingReceiverMetersEditFieldLabel.FontName = 'Calibri';
            app.DistanceabovegroundatreceivingReceiverMetersEditFieldLabel.FontSize = 15;
            app.DistanceabovegroundatreceivingReceiverMetersEditFieldLabel.FontWeight = 'bold';
            app.DistanceabovegroundatreceivingReceiverMetersEditFieldLabel.Position = [9 84 342 22];
            app.DistanceabovegroundatreceivingReceiverMetersEditFieldLabel.Text = 'Distance above ground at receiving Receiver (Meters)';

            % Create DistanceabovegroundatreceivingReceiverMetersEditField
            app.DistanceabovegroundatreceivingReceiverMetersEditField = uieditfield(app.SingleBarrierCorrectionatOneFrequencyTab, 'numeric');
            app.DistanceabovegroundatreceivingReceiverMetersEditField.FontName = 'Calibri';
            app.DistanceabovegroundatreceivingReceiverMetersEditField.FontSize = 15;
            app.DistanceabovegroundatreceivingReceiverMetersEditField.Position = [367 84 90 22];

            % Create DistanceabovegroundatsourceMetersEditFieldLabel
            app.DistanceabovegroundatsourceMetersEditFieldLabel = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.DistanceabovegroundatsourceMetersEditFieldLabel.FontName = 'Calibri';
            app.DistanceabovegroundatsourceMetersEditFieldLabel.FontSize = 15;
            app.DistanceabovegroundatsourceMetersEditFieldLabel.FontWeight = 'bold';
            app.DistanceabovegroundatsourceMetersEditFieldLabel.Position = [9 48 268 22];
            app.DistanceabovegroundatsourceMetersEditFieldLabel.Text = 'Distance above ground at source (Meters)';

            % Create DistanceabovegroundatsourceMetersEditField
            app.DistanceabovegroundatsourceMetersEditField = uieditfield(app.SingleBarrierCorrectionatOneFrequencyTab, 'numeric');
            app.DistanceabovegroundatsourceMetersEditField.FontName = 'Calibri';
            app.DistanceabovegroundatsourceMetersEditField.FontSize = 15;
            app.DistanceabovegroundatsourceMetersEditField.Position = [367 48 90 22];

            % Create MLabel_5
            app.MLabel_5 = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.MLabel_5.FontName = 'Calibri';
            app.MLabel_5.FontSize = 14;
            app.MLabel_5.FontWeight = 'bold';
            app.MLabel_5.Position = [465 84 25 22];
            app.MLabel_5.Text = 'M';

            % Create MLabel_6
            app.MLabel_6 = uilabel(app.SingleBarrierCorrectionatOneFrequencyTab);
            app.MLabel_6.FontName = 'Calibri';
            app.MLabel_6.FontSize = 14;
            app.MLabel_6.FontWeight = 'bold';
            app.MLabel_6.Position = [465 48 25 22];
            app.MLabel_6.Text = 'M';

            % Create GradientTab
            app.GradientTab = uitab(app.TabGroup);
            app.GradientTab.Title = 'Gradient';
            app.GradientTab.BackgroundColor = [1 1 1];

            % Create GradientvalueasapercentageEditFieldLabel
            app.GradientvalueasapercentageEditFieldLabel = uilabel(app.GradientTab);
            app.GradientvalueasapercentageEditFieldLabel.FontName = 'Calibri';
            app.GradientvalueasapercentageEditFieldLabel.FontSize = 14;
            app.GradientvalueasapercentageEditFieldLabel.FontWeight = 'bold';
            app.GradientvalueasapercentageEditFieldLabel.Position = [9 178 184 22];
            app.GradientvalueasapercentageEditFieldLabel.Text = 'Gradient value as a percentage';

            % Create GradientvalueasapercentageEditField
            app.GradientvalueasapercentageEditField = uieditfield(app.GradientTab, 'numeric');
            app.GradientvalueasapercentageEditField.Limits = [0 100];
            app.GradientvalueasapercentageEditField.FontName = 'Calibri';
            app.GradientvalueasapercentageEditField.FontSize = 14;
            app.GradientvalueasapercentageEditField.FontWeight = 'bold';
            app.GradientvalueasapercentageEditField.Position = [377 178 100 22];

            % Create Label
            app.Label = uilabel(app.GradientTab);
            app.Label.FontName = 'Calibri';
            app.Label.FontSize = 14;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [489 178 25 22];
            app.Label.Text = '%';

            % Create TotalCRTNEditFieldLabel
            app.TotalCRTNEditFieldLabel = uilabel(app.UIFigure);
            app.TotalCRTNEditFieldLabel.VerticalAlignment = 'top';
            app.TotalCRTNEditFieldLabel.FontName = 'Calibri';
            app.TotalCRTNEditFieldLabel.FontSize = 20;
            app.TotalCRTNEditFieldLabel.FontWeight = 'bold';
            app.TotalCRTNEditFieldLabel.FontColor = [1 0 0];
            app.TotalCRTNEditFieldLabel.Position = [27 30 99 27];
            app.TotalCRTNEditFieldLabel.Text = 'Total CRTN ';

            % Create TotalCRTNEditField
            app.TotalCRTNEditField = uieditfield(app.UIFigure, 'numeric');
            app.TotalCRTNEditField.Limits = [-150 150];
            app.TotalCRTNEditField.ValueChangedFcn = createCallbackFcn(app, @TotalCRTNEditFieldValueChanged, true);
            app.TotalCRTNEditField.Editable = 'off';
            app.TotalCRTNEditField.FontSize = 20;
            app.TotalCRTNEditField.FontWeight = 'bold';
            app.TotalCRTNEditField.Tooltip = {'Total value including all correction calculations that have been entered.'};
            app.TotalCRTNEditField.Position = [181 32 65 22];

            % Create CalculateButton
            app.CalculateButton = uibutton(app.UIFigure, 'push');
            app.CalculateButton.ButtonPushedFcn = createCallbackFcn(app, @CalculateButtonPushed, true);
            app.CalculateButton.IconAlignment = 'center';
            app.CalculateButton.FontName = 'Calibri';
            app.CalculateButton.FontSize = 20;
            app.CalculateButton.FontWeight = 'bold';
            app.CalculateButton.FontAngle = 'italic';
            app.CalculateButton.FontColor = [1 0 0];
            app.CalculateButton.Tooltip = {'Leave sections blank if you do not need correction.'};
            app.CalculateButton.Position = [436 28 104 42];
            app.CalculateButton.Text = 'Calculate';

            % Create ResetCalculatorButton
            app.ResetCalculatorButton = uibutton(app.UIFigure, 'push');
            app.ResetCalculatorButton.ButtonPushedFcn = createCallbackFcn(app, @ResetCalculatorButtonPushed, true);
            app.ResetCalculatorButton.FontName = 'Calibri';
            app.ResetCalculatorButton.FontSize = 14;
            app.ResetCalculatorButton.FontWeight = 'bold';
            app.ResetCalculatorButton.Tooltip = {'Resets all values for calculator'; ' and outputs.'};
            app.ResetCalculatorButton.Position = [320 30 110 26];
            app.ResetCalculatorButton.Text = 'Reset Calculator';

            % Create DistanceCorrectionValueLabel
            app.DistanceCorrectionValueLabel = uilabel(app.UIFigure);
            app.DistanceCorrectionValueLabel.VerticalAlignment = 'top';
            app.DistanceCorrectionValueLabel.FontName = 'Calibri';
            app.DistanceCorrectionValueLabel.FontSize = 14;
            app.DistanceCorrectionValueLabel.FontAngle = 'italic';
            app.DistanceCorrectionValueLabel.FontColor = [1 0 0];
            app.DistanceCorrectionValueLabel.Position = [27 102 159 22];
            app.DistanceCorrectionValueLabel.Text = 'Distance (Correction Value)';

            % Create DistanceCorrectionValueEditField
            app.DistanceCorrectionValueEditField = uieditfield(app.UIFigure, 'numeric');
            app.DistanceCorrectionValueEditField.Editable = 'off';
            app.DistanceCorrectionValueEditField.FontName = 'Calibri';
            app.DistanceCorrectionValueEditField.FontSize = 14;
            app.DistanceCorrectionValueEditField.Tooltip = {'Amends for the measurement distance if more or less than 13.5 Meters away from source.'};
            app.DistanceCorrectionValueEditField.Position = [182 102 64 22];

            % Create HGVCorrectionValueEditFieldLabel
            app.HGVCorrectionValueEditFieldLabel = uilabel(app.UIFigure);
            app.HGVCorrectionValueEditFieldLabel.VerticalAlignment = 'top';
            app.HGVCorrectionValueEditFieldLabel.FontName = 'Calibri';
            app.HGVCorrectionValueEditFieldLabel.FontSize = 14;
            app.HGVCorrectionValueEditFieldLabel.FontAngle = 'italic';
            app.HGVCorrectionValueEditFieldLabel.FontColor = [1 0 0];
            app.HGVCorrectionValueEditFieldLabel.Position = [27 134 136 22];
            app.HGVCorrectionValueEditFieldLabel.Text = 'HGV (Correction Value)';

            % Create HGVCorrectionValueEditField
            app.HGVCorrectionValueEditField = uieditfield(app.UIFigure, 'numeric');
            app.HGVCorrectionValueEditField.Editable = 'off';
            app.HGVCorrectionValueEditField.FontName = 'Calibri';
            app.HGVCorrectionValueEditField.FontSize = 14;
            app.HGVCorrectionValueEditField.Tooltip = {'Ammends the CRTN calculation taking into consideration the number of Large vehicles.'};
            app.HGVCorrectionValueEditField.Position = [182 134 64 22];

            % Create CRTNNocorrectionEditFieldLabel
            app.CRTNNocorrectionEditFieldLabel = uilabel(app.UIFigure);
            app.CRTNNocorrectionEditFieldLabel.VerticalAlignment = 'top';
            app.CRTNNocorrectionEditFieldLabel.FontName = 'Calibri';
            app.CRTNNocorrectionEditFieldLabel.FontSize = 14;
            app.CRTNNocorrectionEditFieldLabel.FontAngle = 'italic';
            app.CRTNNocorrectionEditFieldLabel.FontColor = [1 0 0];
            app.CRTNNocorrectionEditFieldLabel.Position = [27 165 124 22];
            app.CRTNNocorrectionEditFieldLabel.Text = 'CRTN (No correction)';

            % Create CRTNNocorrectionEditField
            app.CRTNNocorrectionEditField = uieditfield(app.UIFigure, 'numeric');
            app.CRTNNocorrectionEditField.Editable = 'off';
            app.CRTNNocorrectionEditField.FontName = 'Calibri';
            app.CRTNNocorrectionEditField.FontSize = 14;
            app.CRTNNocorrectionEditField.Tooltip = {'Basic Calculation with no corrections.'};
            app.CRTNNocorrectionEditField.Position = [182 165 64 22];

            % Create AngularcorrectionValueLabel
            app.AngularcorrectionValueLabel = uilabel(app.UIFigure);
            app.AngularcorrectionValueLabel.VerticalAlignment = 'top';
            app.AngularcorrectionValueLabel.FontName = 'Calibri';
            app.AngularcorrectionValueLabel.FontSize = 15;
            app.AngularcorrectionValueLabel.FontAngle = 'italic';
            app.AngularcorrectionValueLabel.FontColor = [1 0 0];
            app.AngularcorrectionValueLabel.Position = [279 165 165 22];
            app.AngularcorrectionValueLabel.Text = 'Angular (correction Value)';

            % Create AngularcorrectionValueEditField
            app.AngularcorrectionValueEditField = uieditfield(app.UIFigure, 'numeric');
            app.AngularcorrectionValueEditField.Editable = 'off';
            app.AngularcorrectionValueEditField.Position = [443 165 65 22];

            % Create dBLabel
            app.dBLabel = uilabel(app.UIFigure);
            app.dBLabel.FontName = 'Calibri';
            app.dBLabel.FontSize = 20;
            app.dBLabel.FontWeight = 'bold';
            app.dBLabel.Position = [254 30 27 27];
            app.dBLabel.Text = 'dB';

            % Create dBLabel_2
            app.dBLabel_2 = uilabel(app.UIFigure);
            app.dBLabel_2.FontName = 'Calibri';
            app.dBLabel_2.FontSize = 14;
            app.dBLabel_2.FontWeight = 'bold';
            app.dBLabel_2.Position = [255 165 25 22];
            app.dBLabel_2.Text = 'dB';

            % Create dBLabel_3
            app.dBLabel_3 = uilabel(app.UIFigure);
            app.dBLabel_3.FontName = 'Calibri';
            app.dBLabel_3.FontSize = 14;
            app.dBLabel_3.FontWeight = 'bold';
            app.dBLabel_3.Position = [255 134 25 22];
            app.dBLabel_3.Text = 'dB';

            % Create dBLabel_4
            app.dBLabel_4 = uilabel(app.UIFigure);
            app.dBLabel_4.FontName = 'Calibri';
            app.dBLabel_4.FontSize = 14;
            app.dBLabel_4.FontWeight = 'bold';
            app.dBLabel_4.Position = [255 102 25 22];
            app.dBLabel_4.Text = 'dB';

            % Create dBLabel_5
            app.dBLabel_5 = uilabel(app.UIFigure);
            app.dBLabel_5.FontName = 'Calibri';
            app.dBLabel_5.FontSize = 14;
            app.dBLabel_5.FontWeight = 'bold';
            app.dBLabel_5.Position = [515 165 25 22];
            app.dBLabel_5.Text = 'dB';

            % Create CRTNCalculatorLabel
            app.CRTNCalculatorLabel = uilabel(app.UIFigure);
            app.CRTNCalculatorLabel.FontName = 'Calibri';
            app.CRTNCalculatorLabel.FontSize = 25;
            app.CRTNCalculatorLabel.FontWeight = 'bold';
            app.CRTNCalculatorLabel.FontColor = [1 0 0];
            app.CRTNCalculatorLabel.Position = [193 481 171 34];
            app.CRTNCalculatorLabel.Text = 'CRTN Calculator';

            % Create BarrierCorrectionValueEditFieldLabel
            app.BarrierCorrectionValueEditFieldLabel = uilabel(app.UIFigure);
            app.BarrierCorrectionValueEditFieldLabel.FontName = 'Calibri';
            app.BarrierCorrectionValueEditFieldLabel.FontSize = 14;
            app.BarrierCorrectionValueEditFieldLabel.FontColor = [1 0 0];
            app.BarrierCorrectionValueEditFieldLabel.Position = [279 134 151 22];
            app.BarrierCorrectionValueEditFieldLabel.Text = 'Barrier (Correction Value)';

            % Create BarrierCorrectionValueEditField
            app.BarrierCorrectionValueEditField = uieditfield(app.UIFigure, 'numeric');
            app.BarrierCorrectionValueEditField.Editable = 'off';
            app.BarrierCorrectionValueEditField.FontName = 'Calibri';
            app.BarrierCorrectionValueEditField.FontSize = 14;
            app.BarrierCorrectionValueEditField.Position = [444 134 64 22];

            % Create dBLabel_6
            app.dBLabel_6 = uilabel(app.UIFigure);
            app.dBLabel_6.FontName = 'Calibri';
            app.dBLabel_6.FontSize = 14;
            app.dBLabel_6.FontWeight = 'bold';
            app.dBLabel_6.Position = [514 134 25 22];
            app.dBLabel_6.Text = 'dB';

            % Create GradientCorrectionValueEditFieldLabel
            app.GradientCorrectionValueEditFieldLabel = uilabel(app.UIFigure);
            app.GradientCorrectionValueEditFieldLabel.FontName = 'Calibri';
            app.GradientCorrectionValueEditFieldLabel.FontSize = 14;
            app.GradientCorrectionValueEditFieldLabel.FontColor = [1 0 0];
            app.GradientCorrectionValueEditFieldLabel.Position = [279 102 161 22];
            app.GradientCorrectionValueEditFieldLabel.Text = 'Gradient (Correction Value)';

            % Create GradientCorrectionValueEditField
            app.GradientCorrectionValueEditField = uieditfield(app.UIFigure, 'numeric');
            app.GradientCorrectionValueEditField.Editable = 'off';
            app.GradientCorrectionValueEditField.FontName = 'Calibri';
            app.GradientCorrectionValueEditField.FontSize = 14;
            app.GradientCorrectionValueEditField.Position = [444 102 64 22];

            % Create dBLabel_7
            app.dBLabel_7 = uilabel(app.UIFigure);
            app.dBLabel_7.FontName = 'Calibri';
            app.dBLabel_7.FontSize = 14;
            app.dBLabel_7.FontWeight = 'bold';
            app.dBLabel_7.Position = [515 102 25 22];
            app.dBLabel_7.Text = 'dB';
        end
    end

    methods (Access = public)

        % Construct app
        function app = CRTN

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
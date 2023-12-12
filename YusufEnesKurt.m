classdef YusufEnesKurt < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        figure1                    matlab.ui.Figure
        Panel                      matlab.ui.container.Panel
        StopButton                 matlab.ui.control.Button
        AddButton                  matlab.ui.control.Button
        PhaseEditField             matlab.ui.control.EditField
        PhaseEditFieldLabel        matlab.ui.control.Label
        FrequencyEditField_2       matlab.ui.control.EditField
        FrequencyEditField_2Label  matlab.ui.control.Label
        AmplitudeEditField         matlab.ui.control.EditField
        AmplitudeEditFieldLabel    matlab.ui.control.Label
        AddButton_2                matlab.ui.control.Button
        FrequencyEditField         matlab.ui.control.EditField
        FrequencyEditFieldLabel    matlab.ui.control.Label
        akImaginerEditField        matlab.ui.control.EditField
        akImaginerEditFieldLabel   matlab.ui.control.Label
        akReelEditField            matlab.ui.control.EditField
        akReelEditFieldLabel       matlab.ui.control.Label
        Panel_2                    matlab.ui.container.Panel
        UIAxes2                    matlab.ui.control.UIAxes
        UIAxes                     matlab.ui.control.UIAxes
    end

    
    properties (Access = public)
        Property % Description
        k
        xt
        yt
    end
    
    properties (Access = private)
        Property4 % Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function GUI1_OpeningFcn(app, varargin)
            % --- Executes just before GUI1 is made visible.
            
            % Ensure that the app appears on screen when run
            movegui(app.figure1, 'onscreen');
            
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app); %#ok<ASGLU>
            
            % This function has no output args, see OutputFcn.
            % hObject    handle to figure
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            % varargin   command line arguments to GUI1 (see VARARGIN)
            
            % Choose default command line output for GUI1
            handles.output = hObject;
            
            % Update handles structure
            guidata(hObject, handles);

            app.k = -1;
            app.xt = 0;
            app.yt = 0;

            
        end

        % Button pushed function: AddButton_2
        function buttonPushed(app, event)
            app.k = app.k + 1;

            % EditField'daki değerleri değişkenlere aktarma

            akReel = app.akReelEditField.Value;
            akImaginer = app.akImaginerEditField.Value;

            akReel = str2num(akReel);
            akImaginer = str2num(akImaginer);

            frekans = app.FrequencyEditField.Value;
            frekans = str2num(frekans);

            fs=25;
            t=0:1/fs:20;

            % Oluşan sonucu diğer sonuçlarla toplama

            app.xt = app.xt + exp(1j*2*pi*app.k*frekans*t)*(akReel+akImaginer*1j);

            for i=1:length(t)

                % Sonucu grafiğe yansıtma

                plot(app.UIAxes,(1:i)/fs,imag(app.xt(1:i)));

                xlim(app.UIAxes,[0, 20]);
                ylim(app.UIAxes,[-10, 10]);
                drawnow;

            end

        end

        % Button pushed function: AddButton
        function buttonPushed2(app, event)
            
            % EditField'daki değerleri değişkenlere aktarma
            
            amplitude = app.AmplitudeEditField.Value;
            amplitude = str2num(amplitude);

            frequency = app.FrequencyEditField_2.Value;
            frequency = str2num(frequency);

            phase = app.PhaseEditField.Value;
            phase = str2num(phase);

            t=(0:0.05:4*pi);

            % Oluşan sonucu diğer sonuçlarla toplama

            app.yt = app.yt + amplitude*cos(2*pi*frequency*t+phase);


            for i=1:length(t)      

                % Sonucu grafiğe yansıtma
                
                plot(app.UIAxes2 , (1:i) , app.yt(1:i));

                xlim(app.UIAxes2,[0, 100]);
                ylim(app.UIAxes2,[-10, 10]);
                drawnow;

            end


        end

        % Button pushed function: StopButton
        function buttonPushed3(app, event)
            app.k = -1;
            app.xt = 0;
            app.yt = 0;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create figure1 and hide until all components are created
            app.figure1 = uifigure('Visible', 'off');
            app.figure1.Position = [680 678 740 593];
            app.figure1.Name = 'GUI1';
            app.figure1.Resize = 'off';
            app.figure1.HandleVisibility = 'callback';
            app.figure1.Tag = 'figure1';

            % Create Panel_2
            app.Panel_2 = uipanel(app.figure1);
            app.Panel_2.TitlePosition = 'centertop';
            app.Panel_2.Position = [1 1 740 426];

            % Create UIAxes
            app.UIAxes = uiaxes(app.Panel_2);
            title(app.UIAxes, 'Soru1')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [12 221 714 190];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.Panel_2);
            title(app.UIAxes2, 'Soru2')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [12 19 714 185];

            % Create Panel
            app.Panel = uipanel(app.figure1);
            app.Panel.Position = [1 426 740 168];

            % Create akReelEditFieldLabel
            app.akReelEditFieldLabel = uilabel(app.Panel);
            app.akReelEditFieldLabel.HorizontalAlignment = 'right';
            app.akReelEditFieldLabel.Position = [31 133 50 22];
            app.akReelEditFieldLabel.Text = 'ak(Reel)';

            % Create akReelEditField
            app.akReelEditField = uieditfield(app.Panel, 'text');
            app.akReelEditField.Position = [96 133 100 22];

            % Create akImaginerEditFieldLabel
            app.akImaginerEditFieldLabel = uilabel(app.Panel);
            app.akImaginerEditFieldLabel.HorizontalAlignment = 'right';
            app.akImaginerEditFieldLabel.Position = [220 133 72 22];
            app.akImaginerEditFieldLabel.Text = 'ak(Imaginer)';

            % Create akImaginerEditField
            app.akImaginerEditField = uieditfield(app.Panel, 'text');
            app.akImaginerEditField.Position = [307 133 100 22];

            % Create FrequencyEditFieldLabel
            app.FrequencyEditFieldLabel = uilabel(app.Panel);
            app.FrequencyEditFieldLabel.HorizontalAlignment = 'right';
            app.FrequencyEditFieldLabel.Position = [437 133 62 22];
            app.FrequencyEditFieldLabel.Text = 'Frequency';

            % Create FrequencyEditField
            app.FrequencyEditField = uieditfield(app.Panel, 'text');
            app.FrequencyEditField.Position = [514 133 100 22];

            % Create AddButton_2
            app.AddButton_2 = uibutton(app.Panel, 'push');
            app.AddButton_2.ButtonPushedFcn = createCallbackFcn(app, @buttonPushed, true);
            app.AddButton_2.Position = [626 133 100 23];
            app.AddButton_2.Text = 'Add';

            % Create AmplitudeEditFieldLabel
            app.AmplitudeEditFieldLabel = uilabel(app.Panel);
            app.AmplitudeEditFieldLabel.HorizontalAlignment = 'right';
            app.AmplitudeEditFieldLabel.Position = [23 87 58 22];
            app.AmplitudeEditFieldLabel.Text = 'Amplitude';

            % Create AmplitudeEditField
            app.AmplitudeEditField = uieditfield(app.Panel, 'text');
            app.AmplitudeEditField.Position = [96 87 100 22];

            % Create FrequencyEditField_2Label
            app.FrequencyEditField_2Label = uilabel(app.Panel);
            app.FrequencyEditField_2Label.HorizontalAlignment = 'right';
            app.FrequencyEditField_2Label.Position = [230 87 62 22];
            app.FrequencyEditField_2Label.Text = 'Frequency';

            % Create FrequencyEditField_2
            app.FrequencyEditField_2 = uieditfield(app.Panel, 'text');
            app.FrequencyEditField_2.Position = [307 87 100 22];

            % Create PhaseEditFieldLabel
            app.PhaseEditFieldLabel = uilabel(app.Panel);
            app.PhaseEditFieldLabel.HorizontalAlignment = 'right';
            app.PhaseEditFieldLabel.Position = [460 87 39 22];
            app.PhaseEditFieldLabel.Text = 'Phase';

            % Create PhaseEditField
            app.PhaseEditField = uieditfield(app.Panel, 'text');
            app.PhaseEditField.Position = [514 87 100 22];

            % Create AddButton
            app.AddButton = uibutton(app.Panel, 'push');
            app.AddButton.ButtonPushedFcn = createCallbackFcn(app, @buttonPushed2, true);
            app.AddButton.Position = [626 86 100 23];
            app.AddButton.Text = 'Add';

            % Create StopButton
            app.StopButton = uibutton(app.Panel, 'push');
            app.StopButton.ButtonPushedFcn = createCallbackFcn(app, @buttonPushed3, true);
            app.StopButton.Position = [626 41 100 23];
            app.StopButton.Text = 'Stop';

            % Show the figure after all components are created
            app.figure1.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = dsp20011044(varargin)

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.figure1)

                % Execute the startup function
                runStartupFcn(app, @(app)GUI1_OpeningFcn(app, varargin{:}))
            else

                % Focus the running singleton app
                figure(runningApp.figure1)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.figure1)
        end
    end
end
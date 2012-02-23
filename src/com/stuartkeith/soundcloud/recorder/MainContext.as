package com.stuartkeith.soundcloud.recorder 
{
	import com.stuartkeith.soundcloud.recorder.command.*;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.MainContext;
	import com.stuartkeith.soundcloud.recorder.mediator.*;
	import com.stuartkeith.soundcloud.recorder.model.*;
	import com.stuartkeith.soundcloud.recorder.service.*;
	import com.stuartkeith.soundcloud.recorder.service.MicrophoneServiceEvent;
	import com.stuartkeith.soundcloud.recorder.view.*;
	import com.stuartkeith.soundcloud.recorder.vo.*;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.mvcs.Context;
	
	public class MainContext extends Context 
	{
		public function MainContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true) 
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void 
		{
			// create a SoundCloudConfigurationVO and inject it as a singleton for use in commands
			var soundCloudConfigurationVO:SoundCloudConfigurationVO = new SoundCloudConfigurationVO(contextView.loaderInfo.parameters);
			injector.mapValue(SoundCloudConfigurationVO, soundCloudConfigurationVO);
			
			// inject models
			injector.mapSingleton(RecordingModel);
			
			// inject services
			injector.mapSingleton(MicrophoneService);
			injector.mapSingleton(SoundOutputService);
			
			// map views to mediators
			mediatorMap.mapView(MainView, MainMediator);
			mediatorMap.mapView(ConnectButton, ConnectButtonMediator);
			mediatorMap.mapView(RecordView, RecordViewMediator);
			mediatorMap.mapView(UploadSoundView, UploadSoundViewMediator);
			
			// map framework events to commands
			commandMap.mapEvent(FrameworkEvent.APPLICATION_READY, ProcessQueryStringCommand);
			commandMap.mapEvent(FrameworkEvent.BEGIN_PLAYING, BeginPlayingCommand);
			commandMap.mapEvent(FrameworkEvent.BEGIN_RECORDING, BeginRecordingCommand);
			commandMap.mapEvent(FrameworkEvent.CONNECT_TO_SOUNDCLOUD, NavigateToSoundCloudAuthorisationURLCommand);
			commandMap.mapEvent(FrameworkEvent.STOP_PLAYING, StopPlayingCommand);
			commandMap.mapEvent(FrameworkEvent.STOP_RECORDING, StopRecordingCommand);
			commandMap.mapEvent(MicrophoneServiceEvent.RECORDING_COMPLETE, StoreRecordingCommand);
			
			// call super (this will dispatch STARTUP_COMPLETE).
			super.startup();
		}
	}
}

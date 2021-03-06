package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	
	public class AuthorisationView extends Window 
	{
		// components:
		protected var text:Text;
		protected var connectButton:ConnectButton;
		
		public function AuthorisationView($errorDescription:String) 
		{
			super();
			
			// set up the window:
			
			title = "SoundCloud Authorisation";
			width = 320;
			height = 164;
			draggable = false;
			
			// create components:
			
			var vBox:VBox = new VBox(this, 8, 8);
			vBox.alignment = VBox.CENTER;
			vBox.spacing = 8;
			
			text = new Text(vBox, 0, 0, $errorDescription);
			connectButton = new ConnectButton();
			
			text.editable = false;
			text.selectable = false;
			text.width = width - (vBox.spacing * 2);
			text.height = height - _titleBar.height - connectButton.height - (vBox.spacing * 3);
			vBox.addChild(text);
			
			vBox.addChild(connectButton);
		}
	}
}

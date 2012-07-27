package jp.akb7.concurrent 
{
    import flash.concurrent.Condition;
    import flash.concurrent.Mutex;
    import flash.events.Event;
    import flash.system.MessageChannel;
    import flash.system.Worker;
    import flash.utils.ByteArray;
	
	[Event(name="result", type="jp.akb7.concurrent.FutureEvent")]
    public class FutureTask extends Task implements Future
    {
		public static const IN_CHANNEL:String = "jp.akb7.concurrent.FutureTask.inchannel";
		
        private var _inchannel:MessageChannel;
        
        private var _callable:ByteArray;
        
        private var _thread:Task;
        
        private var _result:Object;
        
        private var _running:Boolean = false;
        
        public function FutureTask(runnable:ByteArray,name:String=null,condition:Condition=null,mutex:Mutex=null,sharedMemory:ByteArray=null){
			super(runnable,name,condition,mutex,sharedMemory);
		}
        
        public function getResult(timeout:Number=-1):Object{ 
            //ワーカー開始
			doPrepare();
			var result:Object = _inchannel.receive(true);
            _running = false;
            return result;
        }
        
        public function getResultAsync():void{
            //ワーカー開始
            doPrepare();
			_inchannel.addEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
			_inchannel.receive();
        }
		
		protected final function doPrepare():void{
			_running = true;

			//子ワーカー作成
			start();
			
			//メッセージチャンネル作成
			//メインワーカーに対するメッセージチャンネル作成
			_inchannel = _worker.createMessageChannel(Worker.current);
			
			//共有プロパティに設定
			_worker.setSharedProperty(IN_CHANNEL, _inchannel);            
		}
		
		protected override function doTerminateWorker():void
		{
			if( _worker != null ){
				_worker.setSharedProperty(IN_CHANNEL, null);
				_inchannel.removeEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
				_inchannel = null;
				_running = false;
			}
			super.doTerminateWorker();
		}
		
        private function inchannel_channelMessageHandler(e:Event):void{
            //メッセージチャンネルにメッセージがあるかどうか
            if( _inchannel.messageAvailable ){
                //メッセージチャンネルに受信
                var message:Object = _inchannel.receive();
                
                var event:FutureEvent = new FutureEvent(FutureEvent.RESULT);
                event.data = message;
                dispatchEvent(event);
                
				terminate();
            }
        }
    }
}
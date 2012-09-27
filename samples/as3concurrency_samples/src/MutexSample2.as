package 
{
    import flash.concurrent.Mutex;
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.Task;
    
    public class MutexSample2 extends Sprite{
        
        public function MutexSample2(){
            var m:Mutex = new Mutex();
            
            var th1:Task = new Task(Workers.MutexTestCommand2,"command-1",null,null,m);
            var th2:Task = new Task(Workers.MutexTestCommand2,"command-2",null,null,m);
            
            trace("command - start");
            th1.start();
            th2.start();
        }         
    }
}
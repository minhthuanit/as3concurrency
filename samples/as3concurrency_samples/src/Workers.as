/*******************************************************************************************************************************************
 * This is an automatically generated class. Please do not modify it since your changes may be lost in the following circumstances:
 *     - Members will be added to this class whenever an embedded worker is added.
 *     - Members in this class will be renamed when a worker is renamed or moved to a different package.
 *     - Members in this class will be removed when a worker is deleted.
 *******************************************************************************************************************************************/

package 
{
    
    import flash.utils.ByteArray;
    
    public class Workers
    {
        
        [Embed(source="../workerswfs/ResidentCommand1.swf", mimeType="application/octet-stream")]
        private static var ResidentCommand1_ByteClass:Class;
        
        [Embed(source="../workerswfs/ConditionCommand1.swf", mimeType="application/octet-stream")]
        private static var ConditionCommand1_ByteClass:Class;
        
        [Embed(source="../workerswfs/MutexTestCommand1.swf", mimeType="application/octet-stream")]
        private static var MutexTestCommand1_ByteClass:Class;
        
        [Embed(source="../workerswfs/MutexTestCommand2.swf", mimeType="application/octet-stream")]
        private static var MutexTestCommand2_ByteClass:Class;
        
        public static function get ResidentCommand1():ByteArray
        {
            return new ResidentCommand1_ByteClass();
        }
        
        public static function get ConditionCommand1():ByteArray
        {
            return new ConditionCommand1_ByteClass();
        }
        
        public static function get MutexTestCommand1():ByteArray
        {
            return new MutexTestCommand1_ByteClass();
        }
        
        public static function get MutexTestCommand2():ByteArray
        {
            return new MutexTestCommand2_ByteClass();
        }
        
        
    }
}
package zero.util;

/**
 *  @author 01010111
 */
class IntPoint
{

    public var x:Int;
    public var y:Int;

    public function new(x:Int = 0, ?y:Int)
    {
        this.x = x;
        this.y = y == null ? x : y;
    }

    public function compare(ip:IntPoint):Bool
    {
        return (ip.x == x && ip.y == y);
    }

    public static function add(ip1, ip2):IntPoint
    {
        return new IntPoint(ip1.x + ip2.x, ip1.y + ip2.y);
    }

}
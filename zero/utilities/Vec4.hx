package zero.utilities;

using Math;

/**
 * A simple Vector class
 * 
 * **Usage:**
 * 
 * - Initialize using Vec4.get() `var vec = Vec4.get(0, 1, 0, 1);`
 * - Or with an array `var vec:Vec4 = [0, 1, 0, 1];`
 * - Recycle vectors when you're done with them: `my_vector.put()`
 */
abstract Vec4(Array<Float>)
{

	// Utility
	static var epsilon:Float = 1e-8;
	static function zero(n:Float):Float return n.abs() <= epsilon ? 0 : n;
	
	// Array creation/access
	@:from static function from_array_float(input:Array<Float>) return new Vec4(input[0], input[1], input[2], input[3]);
	@:from static function from_array_int(input:Array<Int>) return new Vec4(input[0], input[1], input[2], input[3]);
	@:arrayAccess function arr_set(n:Int, v:Float) n < 0 || n > 3 ? return : this[n] = v;
	@:arrayAccess function arr_get(n:Int):Float return this[n.min(3).max(0).floor()];

	// Pooling
	static var pool:Array<Vec4> = [];
	public static function get(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0):Vec4 return pool.length > 0 ? pool.shift().set(x, y, z, w) : new Vec4(x, y, z, w);
	public inline function put()
	{
		pool.push(this);
		this = null;
	}

	function new(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) this = [x, y, z, w];
	public inline function set(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0):Vec4
	{
		this[0] = zero(x);
		this[1] = zero(y);
		this[2] = zero(z);
		this[3] = zero(w);
		return this;
	}

	public var x (get, set):Float;
	function get_x() return this[0];
	function set_x(v) return this[0] = v;

	public var y (get, set):Float;
	function get_y() return this[1];
	function set_y(v) return this[1] = v;

	public var z (get, set):Float;
	function get_z() return this[2];
	function set_z(v) return this[2] = v;

	public var w (get, set):Float;
	function get_w() return this[3];
	function set_w(v) return this[3] = v;

	// These functions modify the vector in place!
	public inline function copy_from(v:Vec4):Vec4 return set(v.x, v.y, v.z, v.w);
	public inline function scale(n:Float):Vec4 return set(x * n, y * n, z * n, w * n);

	public inline function copy():Vec4 return Vec4.get(x, y, z, w);
	public inline function equals(v:Vec4):Bool return x == v.x && y == v.y && z == v.z && w == v.w;
	public inline function toString():String return 'x: $x | y: $y | z: $z | w: $w';

	// Operator Overloads
	@:op(A + B) static function add(v1:Vec4, v2:Vec4):Vec4 return Vec4.get(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z, v1.w + v2.w);
	@:op(A + B) static function add_f(v:Vec4, n:Float):Vec4 return Vec4.get(v.x + n, v.y + n, v.z + n, v.w + n);
	@:op(A - B) static function subtract(v1:Vec4, v2:Vec4):Vec4 return Vec4.get(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z, v1.w - v2.w);
	@:op(A - B) static function subtract_f(v:Vec4, n:Float):Vec4 return Vec4.get(v.x - n, v.y - n, v.z - n, v.w - n);
	@:op(A * B) static function multiply(v1:Vec4, v2:Vec4):Vec4 return Vec4.get(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z, v1.w * v2.w);
	@:op(A * B) static function multiply_f(v:Vec4, n:Float):Vec4 return Vec4.get(v.x * n, v.y * n, v.z * n, v.w * n);
	@:op(A / B) static function divide(v1:Vec4, v2:Vec4):Vec4 return Vec4.get(v1.x / v2.x, v1.y / v2.y, v1.z / v2.z, v1.w / v2.w);
	@:op(A / B) static function divide_f(v:Vec4, n:Float):Vec4 return Vec4.get(v.x / n, v.y / n, v.z / n, v.w / n);
	@:op(A % B) static function mod(v1:Vec4, v2:Vec4):Vec4 return Vec4.get(v1.x % v2.x, v1.y % v2.y, v1.z % v2.z, v1.w % v2.w);
	@:op(A % B) static function mod_f(v:Vec4, n:Float):Vec4 return Vec4.get(v.x % n, v.y % n, v.z % n, v.w % n);

	// Swizzling
	@:dox(hide) public var xx (get, never):Vec2; private function get_xx() return Vec2.get(x, x);
	@:dox(hide) public var xy (get, never):Vec2; private function get_xy() return Vec2.get(x, y);
	@:dox(hide) public var xz (get, never):Vec2; private function get_xz() return Vec2.get(x, z);
	@:dox(hide) public var xw (get, never):Vec2; private function get_xw() return Vec2.get(x, w);
	@:dox(hide) public var yx (get, never):Vec2; private function get_yx() return Vec2.get(y, x);
	@:dox(hide) public var yy (get, never):Vec2; private function get_yy() return Vec2.get(y, y);
	@:dox(hide) public var yz (get, never):Vec2; private function get_yz() return Vec2.get(y, z);
	@:dox(hide) public var yw (get, never):Vec2; private function get_yw() return Vec2.get(y, w);
	@:dox(hide) public var zx (get, never):Vec2; private function get_zx() return Vec2.get(z, x);
	@:dox(hide) public var zy (get, never):Vec2; private function get_zy() return Vec2.get(z, y);
	@:dox(hide) public var zz (get, never):Vec2; private function get_zz() return Vec2.get(z, z);
	@:dox(hide) public var zw (get, never):Vec2; private function get_zw() return Vec2.get(z, w);
	@:dox(hide) public var wx (get, never):Vec2; private function get_wx() return Vec2.get(w, x);
	@:dox(hide) public var wy (get, never):Vec2; private function get_wy() return Vec2.get(w, y);
	@:dox(hide) public var wz (get, never):Vec2; private function get_wz() return Vec2.get(w, z);
	@:dox(hide) public var ww (get, never):Vec2; private function get_ww() return Vec2.get(w, w);
	@:dox(hide) public var xxxx (get, never):Vec4; private function get_xxxx() return Vec4.get(x, x, x, x);
	@:dox(hide) public var xxxy (get, never):Vec4; private function get_xxxy() return Vec4.get(x, x, x, y);
	@:dox(hide) public var xxxz (get, never):Vec4; private function get_xxxz() return Vec4.get(x, x, x, z);
	@:dox(hide) public var xxxw (get, never):Vec4; private function get_xxxw() return Vec4.get(x, x, x, w);
	@:dox(hide) public var xxyx (get, never):Vec4; private function get_xxyx() return Vec4.get(x, x, y, x);
	@:dox(hide) public var xxyy (get, never):Vec4; private function get_xxyy() return Vec4.get(x, x, y, y);
	@:dox(hide) public var xxyz (get, never):Vec4; private function get_xxyz() return Vec4.get(x, x, y, z);
	@:dox(hide) public var xxyw (get, never):Vec4; private function get_xxyw() return Vec4.get(x, x, y, w);
	@:dox(hide) public var xxzx (get, never):Vec4; private function get_xxzx() return Vec4.get(x, x, z, x);
	@:dox(hide) public var xxzy (get, never):Vec4; private function get_xxzy() return Vec4.get(x, x, z, y);
	@:dox(hide) public var xxzz (get, never):Vec4; private function get_xxzz() return Vec4.get(x, x, z, z);
	@:dox(hide) public var xxzw (get, never):Vec4; private function get_xxzw() return Vec4.get(x, x, z, w);
	@:dox(hide) public var xxwx (get, never):Vec4; private function get_xxwx() return Vec4.get(x, x, w, x);
	@:dox(hide) public var xxwy (get, never):Vec4; private function get_xxwy() return Vec4.get(x, x, w, y);
	@:dox(hide) public var xxwz (get, never):Vec4; private function get_xxwz() return Vec4.get(x, x, w, z);
	@:dox(hide) public var xxww (get, never):Vec4; private function get_xxww() return Vec4.get(x, x, w, w);
	@:dox(hide) public var xyxx (get, never):Vec4; private function get_xyxx() return Vec4.get(x, y, x, x);
	@:dox(hide) public var xyxy (get, never):Vec4; private function get_xyxy() return Vec4.get(x, y, x, y);
	@:dox(hide) public var xyxz (get, never):Vec4; private function get_xyxz() return Vec4.get(x, y, x, z);
	@:dox(hide) public var xyxw (get, never):Vec4; private function get_xyxw() return Vec4.get(x, y, x, w);
	@:dox(hide) public var xyyx (get, never):Vec4; private function get_xyyx() return Vec4.get(x, y, y, x);
	@:dox(hide) public var xyyy (get, never):Vec4; private function get_xyyy() return Vec4.get(x, y, y, y);
	@:dox(hide) public var xyyz (get, never):Vec4; private function get_xyyz() return Vec4.get(x, y, y, z);
	@:dox(hide) public var xyyw (get, never):Vec4; private function get_xyyw() return Vec4.get(x, y, y, w);
	@:dox(hide) public var xyzx (get, never):Vec4; private function get_xyzx() return Vec4.get(x, y, z, x);
	@:dox(hide) public var xyzy (get, never):Vec4; private function get_xyzy() return Vec4.get(x, y, z, y);
	@:dox(hide) public var xyzz (get, never):Vec4; private function get_xyzz() return Vec4.get(x, y, z, z);
	@:dox(hide) public var xyzw (get, never):Vec4; private function get_xyzw() return Vec4.get(x, y, z, w);
	@:dox(hide) public var xywx (get, never):Vec4; private function get_xywx() return Vec4.get(x, y, w, x);
	@:dox(hide) public var xywy (get, never):Vec4; private function get_xywy() return Vec4.get(x, y, w, y);
	@:dox(hide) public var xywz (get, never):Vec4; private function get_xywz() return Vec4.get(x, y, w, z);
	@:dox(hide) public var xyww (get, never):Vec4; private function get_xyww() return Vec4.get(x, y, w, w);
	@:dox(hide) public var xzxx (get, never):Vec4; private function get_xzxx() return Vec4.get(x, z, x, x);
	@:dox(hide) public var xzxy (get, never):Vec4; private function get_xzxy() return Vec4.get(x, z, x, y);
	@:dox(hide) public var xzxz (get, never):Vec4; private function get_xzxz() return Vec4.get(x, z, x, z);
	@:dox(hide) public var xzxw (get, never):Vec4; private function get_xzxw() return Vec4.get(x, z, x, w);
	@:dox(hide) public var xzyx (get, never):Vec4; private function get_xzyx() return Vec4.get(x, z, y, x);
	@:dox(hide) public var xzyy (get, never):Vec4; private function get_xzyy() return Vec4.get(x, z, y, y);
	@:dox(hide) public var xzyz (get, never):Vec4; private function get_xzyz() return Vec4.get(x, z, y, z);
	@:dox(hide) public var xzyw (get, never):Vec4; private function get_xzyw() return Vec4.get(x, z, y, w);
	@:dox(hide) public var xzzx (get, never):Vec4; private function get_xzzx() return Vec4.get(x, z, z, x);
	@:dox(hide) public var xzzy (get, never):Vec4; private function get_xzzy() return Vec4.get(x, z, z, y);
	@:dox(hide) public var xzzz (get, never):Vec4; private function get_xzzz() return Vec4.get(x, z, z, z);
	@:dox(hide) public var xzzw (get, never):Vec4; private function get_xzzw() return Vec4.get(x, z, z, w);
	@:dox(hide) public var xzwx (get, never):Vec4; private function get_xzwx() return Vec4.get(x, z, w, x);
	@:dox(hide) public var xzwy (get, never):Vec4; private function get_xzwy() return Vec4.get(x, z, w, y);
	@:dox(hide) public var xzwz (get, never):Vec4; private function get_xzwz() return Vec4.get(x, z, w, z);
	@:dox(hide) public var xzww (get, never):Vec4; private function get_xzww() return Vec4.get(x, z, w, w);
	@:dox(hide) public var xwxx (get, never):Vec4; private function get_xwxx() return Vec4.get(x, w, x, x);
	@:dox(hide) public var xwxy (get, never):Vec4; private function get_xwxy() return Vec4.get(x, w, x, y);
	@:dox(hide) public var xwxz (get, never):Vec4; private function get_xwxz() return Vec4.get(x, w, x, z);
	@:dox(hide) public var xwxw (get, never):Vec4; private function get_xwxw() return Vec4.get(x, w, x, w);
	@:dox(hide) public var xwyx (get, never):Vec4; private function get_xwyx() return Vec4.get(x, w, y, x);
	@:dox(hide) public var xwyy (get, never):Vec4; private function get_xwyy() return Vec4.get(x, w, y, y);
	@:dox(hide) public var xwyz (get, never):Vec4; private function get_xwyz() return Vec4.get(x, w, y, z);
	@:dox(hide) public var xwyw (get, never):Vec4; private function get_xwyw() return Vec4.get(x, w, y, w);
	@:dox(hide) public var xwzx (get, never):Vec4; private function get_xwzx() return Vec4.get(x, w, z, x);
	@:dox(hide) public var xwzy (get, never):Vec4; private function get_xwzy() return Vec4.get(x, w, z, y);
	@:dox(hide) public var xwzz (get, never):Vec4; private function get_xwzz() return Vec4.get(x, w, z, z);
	@:dox(hide) public var xwzw (get, never):Vec4; private function get_xwzw() return Vec4.get(x, w, z, w);
	@:dox(hide) public var xwwx (get, never):Vec4; private function get_xwwx() return Vec4.get(x, w, w, x);
	@:dox(hide) public var xwwy (get, never):Vec4; private function get_xwwy() return Vec4.get(x, w, w, y);
	@:dox(hide) public var xwwz (get, never):Vec4; private function get_xwwz() return Vec4.get(x, w, w, z);
	@:dox(hide) public var xwww (get, never):Vec4; private function get_xwww() return Vec4.get(x, w, w, w);
	@:dox(hide) public var yxxx (get, never):Vec4; private function get_yxxx() return Vec4.get(y, x, x, x);
	@:dox(hide) public var yxxy (get, never):Vec4; private function get_yxxy() return Vec4.get(y, x, x, y);
	@:dox(hide) public var yxxz (get, never):Vec4; private function get_yxxz() return Vec4.get(y, x, x, z);
	@:dox(hide) public var yxxw (get, never):Vec4; private function get_yxxw() return Vec4.get(y, x, x, w);
	@:dox(hide) public var yxyx (get, never):Vec4; private function get_yxyx() return Vec4.get(y, x, y, x);
	@:dox(hide) public var yxyy (get, never):Vec4; private function get_yxyy() return Vec4.get(y, x, y, y);
	@:dox(hide) public var yxyz (get, never):Vec4; private function get_yxyz() return Vec4.get(y, x, y, z);
	@:dox(hide) public var yxyw (get, never):Vec4; private function get_yxyw() return Vec4.get(y, x, y, w);
	@:dox(hide) public var yxzx (get, never):Vec4; private function get_yxzx() return Vec4.get(y, x, z, x);
	@:dox(hide) public var yxzy (get, never):Vec4; private function get_yxzy() return Vec4.get(y, x, z, y);
	@:dox(hide) public var yxzz (get, never):Vec4; private function get_yxzz() return Vec4.get(y, x, z, z);
	@:dox(hide) public var yxzw (get, never):Vec4; private function get_yxzw() return Vec4.get(y, x, z, w);
	@:dox(hide) public var yxwx (get, never):Vec4; private function get_yxwx() return Vec4.get(y, x, w, x);
	@:dox(hide) public var yxwy (get, never):Vec4; private function get_yxwy() return Vec4.get(y, x, w, y);
	@:dox(hide) public var yxwz (get, never):Vec4; private function get_yxwz() return Vec4.get(y, x, w, z);
	@:dox(hide) public var yxww (get, never):Vec4; private function get_yxww() return Vec4.get(y, x, w, w);
	@:dox(hide) public var yyxx (get, never):Vec4; private function get_yyxx() return Vec4.get(y, y, x, x);
	@:dox(hide) public var yyxy (get, never):Vec4; private function get_yyxy() return Vec4.get(y, y, x, y);
	@:dox(hide) public var yyxz (get, never):Vec4; private function get_yyxz() return Vec4.get(y, y, x, z);
	@:dox(hide) public var yyxw (get, never):Vec4; private function get_yyxw() return Vec4.get(y, y, x, w);
	@:dox(hide) public var yyyx (get, never):Vec4; private function get_yyyx() return Vec4.get(y, y, y, x);
	@:dox(hide) public var yyyy (get, never):Vec4; private function get_yyyy() return Vec4.get(y, y, y, y);
	@:dox(hide) public var yyyz (get, never):Vec4; private function get_yyyz() return Vec4.get(y, y, y, z);
	@:dox(hide) public var yyyw (get, never):Vec4; private function get_yyyw() return Vec4.get(y, y, y, w);
	@:dox(hide) public var yyzx (get, never):Vec4; private function get_yyzx() return Vec4.get(y, y, z, x);
	@:dox(hide) public var yyzy (get, never):Vec4; private function get_yyzy() return Vec4.get(y, y, z, y);
	@:dox(hide) public var yyzz (get, never):Vec4; private function get_yyzz() return Vec4.get(y, y, z, z);
	@:dox(hide) public var yyzw (get, never):Vec4; private function get_yyzw() return Vec4.get(y, y, z, w);
	@:dox(hide) public var yywx (get, never):Vec4; private function get_yywx() return Vec4.get(y, y, w, x);
	@:dox(hide) public var yywy (get, never):Vec4; private function get_yywy() return Vec4.get(y, y, w, y);
	@:dox(hide) public var yywz (get, never):Vec4; private function get_yywz() return Vec4.get(y, y, w, z);
	@:dox(hide) public var yyww (get, never):Vec4; private function get_yyww() return Vec4.get(y, y, w, w);
	@:dox(hide) public var yzxx (get, never):Vec4; private function get_yzxx() return Vec4.get(y, z, x, x);
	@:dox(hide) public var yzxy (get, never):Vec4; private function get_yzxy() return Vec4.get(y, z, x, y);
	@:dox(hide) public var yzxz (get, never):Vec4; private function get_yzxz() return Vec4.get(y, z, x, z);
	@:dox(hide) public var yzxw (get, never):Vec4; private function get_yzxw() return Vec4.get(y, z, x, w);
	@:dox(hide) public var yzyx (get, never):Vec4; private function get_yzyx() return Vec4.get(y, z, y, x);
	@:dox(hide) public var yzyy (get, never):Vec4; private function get_yzyy() return Vec4.get(y, z, y, y);
	@:dox(hide) public var yzyz (get, never):Vec4; private function get_yzyz() return Vec4.get(y, z, y, z);
	@:dox(hide) public var yzyw (get, never):Vec4; private function get_yzyw() return Vec4.get(y, z, y, w);
	@:dox(hide) public var yzzx (get, never):Vec4; private function get_yzzx() return Vec4.get(y, z, z, x);
	@:dox(hide) public var yzzy (get, never):Vec4; private function get_yzzy() return Vec4.get(y, z, z, y);
	@:dox(hide) public var yzzz (get, never):Vec4; private function get_yzzz() return Vec4.get(y, z, z, z);
	@:dox(hide) public var yzzw (get, never):Vec4; private function get_yzzw() return Vec4.get(y, z, z, w);
	@:dox(hide) public var yzwx (get, never):Vec4; private function get_yzwx() return Vec4.get(y, z, w, x);
	@:dox(hide) public var yzwy (get, never):Vec4; private function get_yzwy() return Vec4.get(y, z, w, y);
	@:dox(hide) public var yzwz (get, never):Vec4; private function get_yzwz() return Vec4.get(y, z, w, z);
	@:dox(hide) public var yzww (get, never):Vec4; private function get_yzww() return Vec4.get(y, z, w, w);
	@:dox(hide) public var ywxx (get, never):Vec4; private function get_ywxx() return Vec4.get(y, w, x, x);
	@:dox(hide) public var ywxy (get, never):Vec4; private function get_ywxy() return Vec4.get(y, w, x, y);
	@:dox(hide) public var ywxz (get, never):Vec4; private function get_ywxz() return Vec4.get(y, w, x, z);
	@:dox(hide) public var ywxw (get, never):Vec4; private function get_ywxw() return Vec4.get(y, w, x, w);
	@:dox(hide) public var ywyx (get, never):Vec4; private function get_ywyx() return Vec4.get(y, w, y, x);
	@:dox(hide) public var ywyy (get, never):Vec4; private function get_ywyy() return Vec4.get(y, w, y, y);
	@:dox(hide) public var ywyz (get, never):Vec4; private function get_ywyz() return Vec4.get(y, w, y, z);
	@:dox(hide) public var ywyw (get, never):Vec4; private function get_ywyw() return Vec4.get(y, w, y, w);
	@:dox(hide) public var ywzx (get, never):Vec4; private function get_ywzx() return Vec4.get(y, w, z, x);
	@:dox(hide) public var ywzy (get, never):Vec4; private function get_ywzy() return Vec4.get(y, w, z, y);
	@:dox(hide) public var ywzz (get, never):Vec4; private function get_ywzz() return Vec4.get(y, w, z, z);
	@:dox(hide) public var ywzw (get, never):Vec4; private function get_ywzw() return Vec4.get(y, w, z, w);
	@:dox(hide) public var ywwx (get, never):Vec4; private function get_ywwx() return Vec4.get(y, w, w, x);
	@:dox(hide) public var ywwy (get, never):Vec4; private function get_ywwy() return Vec4.get(y, w, w, y);
	@:dox(hide) public var ywwz (get, never):Vec4; private function get_ywwz() return Vec4.get(y, w, w, z);
	@:dox(hide) public var ywww (get, never):Vec4; private function get_ywww() return Vec4.get(y, w, w, w);
	@:dox(hide) public var zxxx (get, never):Vec4; private function get_zxxx() return Vec4.get(z, x, x, x);
	@:dox(hide) public var zxxy (get, never):Vec4; private function get_zxxy() return Vec4.get(z, x, x, y);
	@:dox(hide) public var zxxz (get, never):Vec4; private function get_zxxz() return Vec4.get(z, x, x, z);
	@:dox(hide) public var zxxw (get, never):Vec4; private function get_zxxw() return Vec4.get(z, x, x, w);
	@:dox(hide) public var zxyx (get, never):Vec4; private function get_zxyx() return Vec4.get(z, x, y, x);
	@:dox(hide) public var zxyy (get, never):Vec4; private function get_zxyy() return Vec4.get(z, x, y, y);
	@:dox(hide) public var zxyz (get, never):Vec4; private function get_zxyz() return Vec4.get(z, x, y, z);
	@:dox(hide) public var zxyw (get, never):Vec4; private function get_zxyw() return Vec4.get(z, x, y, w);
	@:dox(hide) public var zxzx (get, never):Vec4; private function get_zxzx() return Vec4.get(z, x, z, x);
	@:dox(hide) public var zxzy (get, never):Vec4; private function get_zxzy() return Vec4.get(z, x, z, y);
	@:dox(hide) public var zxzz (get, never):Vec4; private function get_zxzz() return Vec4.get(z, x, z, z);
	@:dox(hide) public var zxzw (get, never):Vec4; private function get_zxzw() return Vec4.get(z, x, z, w);
	@:dox(hide) public var zxwx (get, never):Vec4; private function get_zxwx() return Vec4.get(z, x, w, x);
	@:dox(hide) public var zxwy (get, never):Vec4; private function get_zxwy() return Vec4.get(z, x, w, y);
	@:dox(hide) public var zxwz (get, never):Vec4; private function get_zxwz() return Vec4.get(z, x, w, z);
	@:dox(hide) public var zxww (get, never):Vec4; private function get_zxww() return Vec4.get(z, x, w, w);
	@:dox(hide) public var zyxx (get, never):Vec4; private function get_zyxx() return Vec4.get(z, y, x, x);
	@:dox(hide) public var zyxy (get, never):Vec4; private function get_zyxy() return Vec4.get(z, y, x, y);
	@:dox(hide) public var zyxz (get, never):Vec4; private function get_zyxz() return Vec4.get(z, y, x, z);
	@:dox(hide) public var zyxw (get, never):Vec4; private function get_zyxw() return Vec4.get(z, y, x, w);
	@:dox(hide) public var zyyx (get, never):Vec4; private function get_zyyx() return Vec4.get(z, y, y, x);
	@:dox(hide) public var zyyy (get, never):Vec4; private function get_zyyy() return Vec4.get(z, y, y, y);
	@:dox(hide) public var zyyz (get, never):Vec4; private function get_zyyz() return Vec4.get(z, y, y, z);
	@:dox(hide) public var zyyw (get, never):Vec4; private function get_zyyw() return Vec4.get(z, y, y, w);
	@:dox(hide) public var zyzx (get, never):Vec4; private function get_zyzx() return Vec4.get(z, y, z, x);
	@:dox(hide) public var zyzy (get, never):Vec4; private function get_zyzy() return Vec4.get(z, y, z, y);
	@:dox(hide) public var zyzz (get, never):Vec4; private function get_zyzz() return Vec4.get(z, y, z, z);
	@:dox(hide) public var zyzw (get, never):Vec4; private function get_zyzw() return Vec4.get(z, y, z, w);
	@:dox(hide) public var zywx (get, never):Vec4; private function get_zywx() return Vec4.get(z, y, w, x);
	@:dox(hide) public var zywy (get, never):Vec4; private function get_zywy() return Vec4.get(z, y, w, y);
	@:dox(hide) public var zywz (get, never):Vec4; private function get_zywz() return Vec4.get(z, y, w, z);
	@:dox(hide) public var zyww (get, never):Vec4; private function get_zyww() return Vec4.get(z, y, w, w);
	@:dox(hide) public var zzxx (get, never):Vec4; private function get_zzxx() return Vec4.get(z, z, x, x);
	@:dox(hide) public var zzxy (get, never):Vec4; private function get_zzxy() return Vec4.get(z, z, x, y);
	@:dox(hide) public var zzxz (get, never):Vec4; private function get_zzxz() return Vec4.get(z, z, x, z);
	@:dox(hide) public var zzxw (get, never):Vec4; private function get_zzxw() return Vec4.get(z, z, x, w);
	@:dox(hide) public var zzyx (get, never):Vec4; private function get_zzyx() return Vec4.get(z, z, y, x);
	@:dox(hide) public var zzyy (get, never):Vec4; private function get_zzyy() return Vec4.get(z, z, y, y);
	@:dox(hide) public var zzyz (get, never):Vec4; private function get_zzyz() return Vec4.get(z, z, y, z);
	@:dox(hide) public var zzyw (get, never):Vec4; private function get_zzyw() return Vec4.get(z, z, y, w);
	@:dox(hide) public var zzzx (get, never):Vec4; private function get_zzzx() return Vec4.get(z, z, z, x);
	@:dox(hide) public var zzzy (get, never):Vec4; private function get_zzzy() return Vec4.get(z, z, z, y);
	@:dox(hide) public var zzzz (get, never):Vec4; private function get_zzzz() return Vec4.get(z, z, z, z);
	@:dox(hide) public var zzzw (get, never):Vec4; private function get_zzzw() return Vec4.get(z, z, z, w);
	@:dox(hide) public var zzwx (get, never):Vec4; private function get_zzwx() return Vec4.get(z, z, w, x);
	@:dox(hide) public var zzwy (get, never):Vec4; private function get_zzwy() return Vec4.get(z, z, w, y);
	@:dox(hide) public var zzwz (get, never):Vec4; private function get_zzwz() return Vec4.get(z, z, w, z);
	@:dox(hide) public var zzww (get, never):Vec4; private function get_zzww() return Vec4.get(z, z, w, w);
	@:dox(hide) public var zwxx (get, never):Vec4; private function get_zwxx() return Vec4.get(z, w, x, x);
	@:dox(hide) public var zwxy (get, never):Vec4; private function get_zwxy() return Vec4.get(z, w, x, y);
	@:dox(hide) public var zwxz (get, never):Vec4; private function get_zwxz() return Vec4.get(z, w, x, z);
	@:dox(hide) public var zwxw (get, never):Vec4; private function get_zwxw() return Vec4.get(z, w, x, w);
	@:dox(hide) public var zwyx (get, never):Vec4; private function get_zwyx() return Vec4.get(z, w, y, x);
	@:dox(hide) public var zwyy (get, never):Vec4; private function get_zwyy() return Vec4.get(z, w, y, y);
	@:dox(hide) public var zwyz (get, never):Vec4; private function get_zwyz() return Vec4.get(z, w, y, z);
	@:dox(hide) public var zwyw (get, never):Vec4; private function get_zwyw() return Vec4.get(z, w, y, w);
	@:dox(hide) public var zwzx (get, never):Vec4; private function get_zwzx() return Vec4.get(z, w, z, x);
	@:dox(hide) public var zwzy (get, never):Vec4; private function get_zwzy() return Vec4.get(z, w, z, y);
	@:dox(hide) public var zwzz (get, never):Vec4; private function get_zwzz() return Vec4.get(z, w, z, z);
	@:dox(hide) public var zwzw (get, never):Vec4; private function get_zwzw() return Vec4.get(z, w, z, w);
	@:dox(hide) public var zwwx (get, never):Vec4; private function get_zwwx() return Vec4.get(z, w, w, x);
	@:dox(hide) public var zwwy (get, never):Vec4; private function get_zwwy() return Vec4.get(z, w, w, y);
	@:dox(hide) public var zwwz (get, never):Vec4; private function get_zwwz() return Vec4.get(z, w, w, z);
	@:dox(hide) public var zwww (get, never):Vec4; private function get_zwww() return Vec4.get(z, w, w, w);
	@:dox(hide) public var wxxx (get, never):Vec4; private function get_wxxx() return Vec4.get(w, x, x, x);
	@:dox(hide) public var wxxy (get, never):Vec4; private function get_wxxy() return Vec4.get(w, x, x, y);
	@:dox(hide) public var wxxz (get, never):Vec4; private function get_wxxz() return Vec4.get(w, x, x, z);
	@:dox(hide) public var wxxw (get, never):Vec4; private function get_wxxw() return Vec4.get(w, x, x, w);
	@:dox(hide) public var wxyx (get, never):Vec4; private function get_wxyx() return Vec4.get(w, x, y, x);
	@:dox(hide) public var wxyy (get, never):Vec4; private function get_wxyy() return Vec4.get(w, x, y, y);
	@:dox(hide) public var wxyz (get, never):Vec4; private function get_wxyz() return Vec4.get(w, x, y, z);
	@:dox(hide) public var wxyw (get, never):Vec4; private function get_wxyw() return Vec4.get(w, x, y, w);
	@:dox(hide) public var wxzx (get, never):Vec4; private function get_wxzx() return Vec4.get(w, x, z, x);
	@:dox(hide) public var wxzy (get, never):Vec4; private function get_wxzy() return Vec4.get(w, x, z, y);
	@:dox(hide) public var wxzz (get, never):Vec4; private function get_wxzz() return Vec4.get(w, x, z, z);
	@:dox(hide) public var wxzw (get, never):Vec4; private function get_wxzw() return Vec4.get(w, x, z, w);
	@:dox(hide) public var wxwx (get, never):Vec4; private function get_wxwx() return Vec4.get(w, x, w, x);
	@:dox(hide) public var wxwy (get, never):Vec4; private function get_wxwy() return Vec4.get(w, x, w, y);
	@:dox(hide) public var wxwz (get, never):Vec4; private function get_wxwz() return Vec4.get(w, x, w, z);
	@:dox(hide) public var wxww (get, never):Vec4; private function get_wxww() return Vec4.get(w, x, w, w);
	@:dox(hide) public var wyxx (get, never):Vec4; private function get_wyxx() return Vec4.get(w, y, x, x);
	@:dox(hide) public var wyxy (get, never):Vec4; private function get_wyxy() return Vec4.get(w, y, x, y);
	@:dox(hide) public var wyxz (get, never):Vec4; private function get_wyxz() return Vec4.get(w, y, x, z);
	@:dox(hide) public var wyxw (get, never):Vec4; private function get_wyxw() return Vec4.get(w, y, x, w);
	@:dox(hide) public var wyyx (get, never):Vec4; private function get_wyyx() return Vec4.get(w, y, y, x);
	@:dox(hide) public var wyyy (get, never):Vec4; private function get_wyyy() return Vec4.get(w, y, y, y);
	@:dox(hide) public var wyyz (get, never):Vec4; private function get_wyyz() return Vec4.get(w, y, y, z);
	@:dox(hide) public var wyyw (get, never):Vec4; private function get_wyyw() return Vec4.get(w, y, y, w);
	@:dox(hide) public var wyzx (get, never):Vec4; private function get_wyzx() return Vec4.get(w, y, z, x);
	@:dox(hide) public var wyzy (get, never):Vec4; private function get_wyzy() return Vec4.get(w, y, z, y);
	@:dox(hide) public var wyzz (get, never):Vec4; private function get_wyzz() return Vec4.get(w, y, z, z);
	@:dox(hide) public var wyzw (get, never):Vec4; private function get_wyzw() return Vec4.get(w, y, z, w);
	@:dox(hide) public var wywx (get, never):Vec4; private function get_wywx() return Vec4.get(w, y, w, x);
	@:dox(hide) public var wywy (get, never):Vec4; private function get_wywy() return Vec4.get(w, y, w, y);
	@:dox(hide) public var wywz (get, never):Vec4; private function get_wywz() return Vec4.get(w, y, w, z);
	@:dox(hide) public var wyww (get, never):Vec4; private function get_wyww() return Vec4.get(w, y, w, w);
	@:dox(hide) public var wzxx (get, never):Vec4; private function get_wzxx() return Vec4.get(w, z, x, x);
	@:dox(hide) public var wzxy (get, never):Vec4; private function get_wzxy() return Vec4.get(w, z, x, y);
	@:dox(hide) public var wzxz (get, never):Vec4; private function get_wzxz() return Vec4.get(w, z, x, z);
	@:dox(hide) public var wzxw (get, never):Vec4; private function get_wzxw() return Vec4.get(w, z, x, w);
	@:dox(hide) public var wzyx (get, never):Vec4; private function get_wzyx() return Vec4.get(w, z, y, x);
	@:dox(hide) public var wzyy (get, never):Vec4; private function get_wzyy() return Vec4.get(w, z, y, y);
	@:dox(hide) public var wzyz (get, never):Vec4; private function get_wzyz() return Vec4.get(w, z, y, z);
	@:dox(hide) public var wzyw (get, never):Vec4; private function get_wzyw() return Vec4.get(w, z, y, w);
	@:dox(hide) public var wzzx (get, never):Vec4; private function get_wzzx() return Vec4.get(w, z, z, x);
	@:dox(hide) public var wzzy (get, never):Vec4; private function get_wzzy() return Vec4.get(w, z, z, y);
	@:dox(hide) public var wzzz (get, never):Vec4; private function get_wzzz() return Vec4.get(w, z, z, z);
	@:dox(hide) public var wzzw (get, never):Vec4; private function get_wzzw() return Vec4.get(w, z, z, w);
	@:dox(hide) public var wzwx (get, never):Vec4; private function get_wzwx() return Vec4.get(w, z, w, x);
	@:dox(hide) public var wzwy (get, never):Vec4; private function get_wzwy() return Vec4.get(w, z, w, y);
	@:dox(hide) public var wzwz (get, never):Vec4; private function get_wzwz() return Vec4.get(w, z, w, z);
	@:dox(hide) public var wzww (get, never):Vec4; private function get_wzww() return Vec4.get(w, z, w, w);
	@:dox(hide) public var wwxx (get, never):Vec4; private function get_wwxx() return Vec4.get(w, w, x, x);
	@:dox(hide) public var wwxy (get, never):Vec4; private function get_wwxy() return Vec4.get(w, w, x, y);
	@:dox(hide) public var wwxz (get, never):Vec4; private function get_wwxz() return Vec4.get(w, w, x, z);
	@:dox(hide) public var wwxw (get, never):Vec4; private function get_wwxw() return Vec4.get(w, w, x, w);
	@:dox(hide) public var wwyx (get, never):Vec4; private function get_wwyx() return Vec4.get(w, w, y, x);
	@:dox(hide) public var wwyy (get, never):Vec4; private function get_wwyy() return Vec4.get(w, w, y, y);
	@:dox(hide) public var wwyz (get, never):Vec4; private function get_wwyz() return Vec4.get(w, w, y, z);
	@:dox(hide) public var wwyw (get, never):Vec4; private function get_wwyw() return Vec4.get(w, w, y, w);
	@:dox(hide) public var wwzx (get, never):Vec4; private function get_wwzx() return Vec4.get(w, w, z, x);
	@:dox(hide) public var wwzy (get, never):Vec4; private function get_wwzy() return Vec4.get(w, w, z, y);
	@:dox(hide) public var wwzz (get, never):Vec4; private function get_wwzz() return Vec4.get(w, w, z, z);
	@:dox(hide) public var wwzw (get, never):Vec4; private function get_wwzw() return Vec4.get(w, w, z, w);
	@:dox(hide) public var wwwx (get, never):Vec4; private function get_wwwx() return Vec4.get(w, w, w, x);
	@:dox(hide) public var wwwy (get, never):Vec4; private function get_wwwy() return Vec4.get(w, w, w, y);
	@:dox(hide) public var wwwz (get, never):Vec4; private function get_wwwz() return Vec4.get(w, w, w, z);
	@:dox(hide) public var wwww (get, never):Vec4; private function get_wwww() return Vec4.get(w, w, w, w);

}
package ru.stablex.ui.widgets;

import flash.display.DisplayObject;
import nme.display.DisplayObject;
import nme.display.DisplayObjectContainer;
import ru.stablex.TweenSprite;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.UIBuilder;


/**
* Basic widget
*/

class Widget extends TweenSprite{
    static private inline var _X_USE_LEFT          = 1;
    static private inline var _X_USE_LEFT_PERCENT  = 2;
    static private inline var _X_USE_RIGHT         = 3;
    static private inline var _X_USE_RIGHT_PERCENT = 4;

    static private inline var _Y_USE_TOP            = 5;
    static private inline var _Y_USE_TOP_PERCENT    = 6;
    static private inline var _Y_USE_BOTTOM         = 7;
    static private inline var _Y_USE_BOTTOM_PERCENT = 8;


    //Name of section in default settings for this type of widgets
    public var defaults : String = 'Default';

    //Wether this widget creation by <type>UIBuilder</type> is finished
    public var created : Bool = false;

    //Widget width in pixels
    public var w (_getWidth,_setWidth)   : Float;
    //Widget width in % of parent's width
    public var widthPt (_getWpt,_setWpt) : Float;
    private var _width                   : Float;
    private var _widthPercent            : Float;
    private var _widthUsePercent         : Bool = false;

    //Widget height height in pixels
    public var h (_getHeight,_setHeight)  : Float;
    //Widget height in % of parent's height
    public var heightPt (_getHpt,_setHpt) : Float;
    private var _height                   : Float;
    private var _heightPercent            : Float;
    private var _heightUsePercent         : Bool = false;

    //Widget id (unique)
    public var id (default, _setId) : String;

    //position this widget by left border in pixels
    public var left (_getLeft,_setLeft) : Float;
    //position this widget by left border in % of parent's width
    public var leftPt (_getLpt,_setLpt) : Float;
    private var _left                   : Float;
    private var _leftPercent            : Float;

    //position this widget by right border in pixels
    public var right (_getRight,_setRight) : Float;
    //position this widget by right border in % of parent's width
    public var rightPt (_getRpt,_setRpt)   : Float;
    private var _right                     : Float;
    private var _rightPercent              : Float;

    //Wich one to use: left, right, leftPercent or rightPercent
    private var _xUse : Int = _X_USE_LEFT;
    private var _yUse : Int = _Y_USE_TOP;

    //Get parent if it is widget, returns null otherwise
    public var wparent (_getParentWidget,never) : Widget;

    //position this widget by top border in pixels
    public var top (_getTop,_setTop)   : Float;
    //position this widget by top border in % of parent's height
    public var topPt (_getTpt,_setTpt) : Float;
    private var _top                   : Float;
    private var _topPercent            : Float;

    //position this widget by bottom border in pixels
    public var bottom (_getBottom,_setBottom) : Float;
    //position this widget by bottom border in % of parent's height
    public var bottomPt (_getBpt,_setBpt)     : Float;
    private var _bottom                       : Float;
    private var _bottomPercent                : Float;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();

        this.id = UIBuilder.createId();
    }//function new()


    /**
    * returns parent widget
    *
    */
    private inline function _getParentWidget() : Widget {
        return (
            Std.is(this.parent, Widget)
                ? cast(this.parent, Widget)
                : null
        );
    }//function _getParentWidget()


    /**
    * Left setter
    *
    */
    private function _setLeft(l:Float) : Float {
        this._xUse = _X_USE_LEFT;
        this.x     = l;
        return this._left = l;
    }//function _setLeft()


    /**
    * Left getter
    *
    */
    private function _getLeft() : Float {
        return this.x;
    }//function _getLeft()


    /**
    * Right setter
    *
    */
    private function _setRight(r:Float) : Float {
        this._xUse = _X_USE_RIGHT;
        if( this.wparent != null ){
            this.x = this.wparent._width - r - this.w;
        }
        return this._right = r;
    }//function _setRight()


    /**
    * Right getter
    *
    */
    private function _getRight() : Float {
        if( this._xUse == _X_USE_RIGHT ){
            return this._right;
        }

        if( this.wparent != null ){
            return this.wparent._width - this.x - this.w;
        }

        return 0;
    }//function _getRight()


    /**
    * Left percent setter
    *
    */
    private function _setLpt(lp:Float) : Float {
        this._xUse = _X_USE_LEFT_PERCENT;

        if( this.wparent != null ){
            this.x = this.wparent._width * lp / 100;
        }

        return this._leftPercent = lp;
    }//function _setLpt()


    /**
    * Left percent getter
    *
    */
    private function _getLpt() : Float {
        if( this._xUse == _X_USE_LEFT_PERCENT ){
            return this._leftPercent;
        }

        if( this.wparent != null &&  this.wparent._width != 0 ){
            return this.x / this.wparent._width * 100;
        }

        return 0;
    }//function _getLpt()


    /**
    * Right percent setter
    *
    */
    private function _setRpt(rp:Float) : Float {
        this._xUse = _X_USE_RIGHT_PERCENT;

        if( this.wparent != null ){
            this.x = this.wparent._width - this.wparent._width * rp / 100 - this.w;
        }

        return this._rightPercent = rp;
    }//function _setRpt()


    /**
    * Right percent getter
    *
    */
    private function _getRpt() : Float {
        if( this._xUse == _X_USE_RIGHT_PERCENT ){
            return this._rightPercent;
        }

        if( this.wparent != null && this.wparent._width != 0 ) {
            return (this.wparent._width - this.x - this._width) / this.wparent._width * 100;
        }

        return 0;
    }//function _getRpt()


    /**
    * Top setter
    *
    */
    private function _setTop(t:Float) : Float {
        this._yUse = _Y_USE_TOP;
        this.y     = t;
        return this._top = t;
    }//function _setTop()


    /**
    * Top getter
    *
    */
    private function _getTop() : Float {
        return this.y;
    }//function _getTop()


    /**
    * Bottom setter
    *
    */
    private function _setBottom(b:Float) : Float {
        this._yUse = _Y_USE_BOTTOM;
        if( this.wparent != null ){
            this.y = this.wparent._height - b - this.h;
        }
        return this._bottom = b;
    }//function _setBottom()


    /**
    * Bottom getter
    *
    */
    private function _getBottom() : Float {
        if( this._yUse == _Y_USE_BOTTOM ) {
            return this._bottom;
        }

        if( this.wparent != null ){
            return this.wparent._height - this.y - this.h;
        }

        return 0;
    }//function _getBottom()


    /**
    * Top percent setter
    *
    */
    private function _setTpt(tp:Float) : Float {
        this._yUse = _Y_USE_TOP_PERCENT;

        if( this.wparent != null ){
            this.y = this.wparent._height * tp / 100;
        }

        return this._topPercent = tp;
    }//function _setTpt()


    /**
    * Top percent getter
    *
    */
    private function _getTpt() : Float {
        if( this._yUse == _Y_USE_TOP_PERCENT ){
            return this._topPercent;
        }

        if( this.wparent != null &&  this.wparent._height != 0 ){
            return this.y / this.wparent._height * 100;
        }

        return 0;
    }//function _getLpt()


    /**
    * Bottom percent setter
    *
    */
    private function _setBpt(bp:Float) : Float {
        this._yUse = _Y_USE_BOTTOM_PERCENT;

        if( this.wparent != null ){
            this.y = this.wparent._height - this.wparent._height * bp / 100 - this.h;
        }

        return this._bottomPercent = bp;
    }//function _setBpt()


    /**
    * Bottom percent getter
    *
    */
    private function _getBpt() : Float {
        if( this._yUse == _Y_USE_BOTTOM_PERCENT ){
            return this._bottomPercent;
        }

        if( this.wparent != null && this.wparent._height != 0 ) {
            return (this.wparent._height - this.y - this._height) / this.wparent._height * 100;
        }

        return 0;
    }//function _getRpt()


    /**
    * Width setter
    *
    */
    private function _setWidth(w:Float) : Float {
        this._width           = w;
        this._widthUsePercent = false;
        this.onResize();
        return w;
    }//function _setWidth()


    /**
    * Width getter
    *
    */
    private function _getWidth() : Float {
        return this._width;
    }//function _getWidth()


    /**
    * Height setter
    *
    */
    private function _setHeight(h:Float) : Float {
        this._height           = h;
        this._heightUsePercent = false;
        this.onResize();
        return h;
    }//function _setHeight()


    /**
    * Height getter
    *
    */
    private function _getHeight() : Float {
        return this._height;
    }//function _getHeight()


    /**
    * Width percent setter
    *
    */
    private function _setWpt(wp:Float) : Float {
        this._widthPercent    = wp;
        this._widthUsePercent = true;

        if( this.wparent != null ){
            this._width = this.wparent._width * wp / 100;
            this.onResize();
        }

        return wp;
    }//function _setWpt()


    /**
    * Width percent getter
    *
    */
    private function _getWpt() : Float {
        if( this._widthUsePercent ){
            return this._widthPercent;

        }else if( this.wparent != null && this.wparent._width != 0 ){
            return this.w / this.wparent._width * 100;

        }else{
            return 0;
        }
    }//function _getWpt()


    /**
    * Height percent setter
    *
    */
    private function _setHpt(hp:Float) : Float {
        this._heightPercent    = hp;
        this._heightUsePercent = true;

        if( this.wparent != null ){
            this._height = this.wparent._height * hp / 100;
            this.onResize();
        }

        return hp;
    }//function _setHpt()


    /**
    * Height percent getter
    *
    */
    private function _getHpt() : Float {
        if( this._heightUsePercent ){
            return this._heightPercent;

        }else if( this.wparent != null && this.wparent._height != 0 ){
            return this._height / this.wparent._height * 100;

        }else{
            return 0;
        }
    }//function _getHpt()


    /**
    * Id setter
    *
    */
    @:final private function _setId (id:String) : String{
        if( id == null ){
            Err.trigger('Widget id cannot be null');
        }

        //remove reference with old id
        if( this.id != null ){
            UIBuilder.forget(this.id);
        }

        this.id = id;

        //save reference with new id
        UIBuilder.save(this);

        return id;
    }//function _setId()


    /**
    * This method is called automatically after widget was created
    * by <type>UIBuilder</type>.buildFn() or <type>UIBuilder</type>.create()
    *
    */
    public function onCreate () : Void{
        //refresh widget
        this.refresh();

        this.created = true;

        this.dispatchEvent(new WidgetEvent(WidgetEvent.CREATE));
    }//function onCreationComplete()


    /**
    * Free (destroy) widget
    *
    */
    override public function free (recursive:Bool = true) : Void{
        this.dispatchEvent(new WidgetEvent(WidgetEvent.FREE));

        super.free(recursive);

        //remove reference from UIBuilder
        UIBuilder.forget(this.id);
    }//function free()


    /**
    * Refresh widget. This method is called at least once for every widget (on creation)
    *
    */
    public function refresh() : Void {
    }//function refresh()


    /**
    * Before adding to another widget display list
    *
    */
    private function _newParent(newParent:Widget) : Void {
        if( newParent != this.parent) this.onNewParent(newParent);
    }//function _newParent()


    /**
    * Called before adding to new widget display list
    *
    */
    public function onNewParent(newParent:Widget) : Void {
        //Resize if our size is defined in percents
        if( this._widthUsePercent || this._heightUsePercent ){
            this.resize(
                (this._widthUsePercent ? newParent._width * this._widthPercent / 100 : this._width),
                (this._heightUsePercent ? newParent._height * this._heightPercent / 100 : this._height),
                true
            );
        }

        //positioning {
            switch ( this._xUse ) {
                //by right border
                case _X_USE_RIGHT: this.x = newParent._width - this._right - this._width;
                //by right percent
                case _X_USE_RIGHT_PERCENT: this.x = newParent._width - newParent._width * this._rightPercent / 100 - this._width;
                //by left percent
                case _X_USE_LEFT_PERCENT: this.x = newParent._width * this._leftPercent / 100;
            }//switch()

            switch ( this._yUse ) {
                //by bottom border
                case _Y_USE_BOTTOM: this.y = newParent._height - this._bottom - this._height;
                //by bottom percent
                case _Y_USE_BOTTOM_PERCENT: this.y = newParent._height - newParent._height * this._bottomPercent / 100 - this._height;
                //by top percent
                case _Y_USE_TOP_PERCENT: this.y = newParent._height * this._topPercent / 100;
            }//switch()
        //}
    }//function onNewParent()


    /**
    * Process parent widget resizing
    *
    */
    private function _onParentResize(e:WidgetEvent) : Void {
        var parent : Widget = cast(e.currentTarget, Widget);

        //Resize if our size is defined in percents
        if( this._widthUsePercent || this._heightUsePercent ){
            this.resize(
                (this._widthUsePercent ? parent._width * this._widthPercent / 100 : this._width),
                (this._heightUsePercent ? parent._height * this._heightPercent / 100 : this._height),
                true
            );
        }

        //positioning {
            switch ( this._xUse ) {
                //by right border
                case _X_USE_RIGHT: this.x = parent._width - this._right - this._width;
                //by right percent
                case _X_USE_RIGHT_PERCENT: this.x = parent._width - parent._width * this._rightPercent / 100 - this.w;
                //by left percent
                case _X_USE_LEFT_PERCENT: this.x = parent._width * this._leftPercent / 100;
            }//switch()

            switch ( this._yUse ) {
                //by bottom border
                case _Y_USE_BOTTOM: this.y = parent._height - this._bottom - this._height;
                //by bottom percent
                case _Y_USE_BOTTOM_PERCENT: this.y = parent._height - parent._height * this._bottomPercent / 100 - this._height;
                //by top percent
                case _Y_USE_TOP_PERCENT: this.y = parent._height * this._topPercent / 100;
            }//switch()
        //}
    }//function _onParentResize()


    /**
    * Resize width and height simultaneously. Only one <type>ru.stablex.ui.events.WidgetEvent</type>.RESIZE will be dispatched
    *
    */
    public function resize(width:Float, height:Float, keepPercentage:Bool = false) : Void {
        this._width  = width;
        this._height = height;

        if( !keepPercentage ){
            this._heightUsePercent = this._widthUsePercent = false;
        }

        this.onResize();
    }//function resize()


    /**
    * Called every time this object is resized
    *
    */
    public function onResize() : Void {
        //positioning
        if( this.wparent != null ){
            switch( this._xUse ){
                //by right border
                case _X_USE_RIGHT:this.x = this.wparent._width - this._right - this._width;
                //by right percent
                case _X_USE_RIGHT_PERCENT: this.x = this.wparent._width - this.wparent._width * this._rightPercent / 100 - this._width;
            }//switch()

            switch ( this._yUse ) {
                //by bottom border
                case _Y_USE_BOTTOM: this.y = this.wparent._height - this._bottom - this._height;
                //by bottom percent
                case _Y_USE_BOTTOM_PERCENT: this.y = this.wparent._height - this.wparent._height * this._bottomPercent / 100 - this._height;
            }//switch()
        }//if()

        this.dispatchEvent(new WidgetEvent( this.created ? WidgetEvent.RESIZE : WidgetEvent.INITIAL_RESIZE ));
    }//function onResize()


    /**
    * Add child to display list. If child is Widget child.onNewParent() is called
    *
    */
    override public function addChild(child:DisplayObject) : DisplayObject {
        if( child.parent != null ){
            child.parent.removeChild(child);
        }

        if( Std.is(child, Widget) ){
            cast(child, Widget)._newParent(this);
            this.addUniqueListener(WidgetEvent.RESIZE, cast(child, Widget)._onParentResize);
            this.addUniqueListener(WidgetEvent.INITIAL_RESIZE, cast(child, Widget)._onParentResize);
        }

        return super.addChild(child);
    }//function addChild()


    /**
    * Add child to display list at specified index. If child is Widget child.onNewParent() is called
    *
    */
    override public function addChildAt(child:DisplayObject, idx:Int) : DisplayObject {
        if( child.parent != null ){
            child.parent.removeChild(child);
        }

        if( Std.is(child, Widget) ){
            cast(child, Widget)._newParent(this);
            this.addUniqueListener(WidgetEvent.RESIZE, cast(child, Widget)._onParentResize);
            this.addUniqueListener(WidgetEvent.INITIAL_RESIZE, cast(child, Widget)._onParentResize);
        }

        return super.addChildAt(child, idx);
    }//function addChildAt()


    /**
    * Remove child from display list
    *
    */
    override public function removeChild(child:DisplayObject) : DisplayObject {
        if( Std.is(child, Widget) ){
            this.removeEventListener(WidgetEvent.RESIZE, cast(child, Widget)._onParentResize);
            this.removeEventListener(WidgetEvent.INITIAL_RESIZE, cast(child, Widget)._onParentResize);
        }
        return super.removeChild(child);
    }//function removeChild()


    /**
    * Remove child at specified index from display list
    *
    */
    override public function removeChildAt(idx:Int) : DisplayObject {
        var child : DisplayObject = this.getChildAt(idx);
        if( Std.is(child, Widget) ){
            this.removeEventListener(WidgetEvent.RESIZE, cast(child, Widget)._onParentResize);
            this.removeEventListener(WidgetEvent.INITIAL_RESIZE, cast(child, Widget)._onParentResize);
        }
        return super.removeChildAt(idx);
    }//function removeChild()


    /**
    * Recursively looks for child with specified name
    *
    */
    override public function getChildByName(name:String) : DisplayObject {
        var child : DisplayObject = null;

        //check each child
        for(i in 0...this.numChildren){
            child = this.getChildAt(i);

            if( child.name == name ) break;

            //look through this child children
            if( Std.is(child, DisplayObjectContainer) ){
                child = cast(child, DisplayObjectContainer).getChildByName(name);
                if( child != null ) break;
            }

            child = null;
        }

        return child;
    }//function getChildByName()


}//class Widget
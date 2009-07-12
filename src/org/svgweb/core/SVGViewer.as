package org.svgweb.core
{

    import org.svgweb.nodes.SVGSVGNode;

    import flash.display.Sprite;
    import flash.events.ContextMenuEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.net.navigateToURL;

    public class SVGViewer extends Sprite
    {
        public var svgRoot:SVGSVGNode;

        protected var urlLoader:URLLoader;
        private var context:ContextMenu;

        public function SVGViewer() {
            customizeContextMenu();

            XML.ignoreProcessingInstructions = false;
            XML.ignoreComments = false;
            super();
        }

        public function loadURL(url:String):void {
            urlLoader = new URLLoader();
            urlLoader.load(new URLRequest(url));
            urlLoader.addEventListener(Event.COMPLETE, onComplete);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        protected function onComplete(event:Event):void {
            xml = new XML(urlLoader.data);
            urlLoader = null;
        }

        protected function onIOError(event:IOErrorEvent):void {
            trace("IOError: " + event.text);
            urlLoader = null;
        }

        protected function onSecurityError(event:SecurityErrorEvent):void {
            trace("SecurityError: " + event.text);
            urlLoader = null;
        }

        public function getWidth():Number {
            return 0;
        }

        public function getHeight():Number {
            return 0;
        }

        public function set xml(value:XML):void {
            if (svgRoot != null) {
                this.removeChild(svgRoot);
            }
            svgRoot = new SVGSVGNode(null, value);
            this.addChild(svgRoot);
        }

        public function get xml():XML {
            return this.svgRoot.xml;
        }

        public function handleScript(script:String):void {

        }

        public function addActionListener(eventType:String, target:Sprite):void {

        }

        public function removeActionListener(eventType:String, target:Sprite):void {

        } 
        
        public function customizeContextMenu():void {
            context = new ContextMenu();
            
            var itemAbout:ContextMenuItem = new ContextMenuItem("About SVG Web", aboutSVGWeb);
            var itemBug:ContextMenuItem = new ContextMenuItem("Report Issue with SVG Web ");
            itemAbout.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, aboutSVGWeb);
            itemBug.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, reportBug);
            this.contextMenu = context;
            this.contextMenu.customItems.push(itemAbout);
            this.contextMenu.customItems.push(itemBug);

            function aboutSVGWeb():void {
                navigateToURL(new URLRequest("http://code.google.com/p/svgweb/"));
            }
            function reportBug():void {
                navigateToURL(new URLRequest("http://code.google.com/p/svgweb/issues/list"));
            }
        }

        public function debug(debugMessage:String):void {

        }
        
        public function error(message:String):void {
            this.debug(message);
        }

    }
}

package meta.substates;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import lime.app.Application;
import sys.thread.Thread;

//todo: Fix game not responding after calling this substatte
class WebviewSubstate extends MusicBeatSubstate {
    var exit:Bool = false;
    public function new(url:String = "https://google.com/"){
        FlxG.autoPause = true;
        super();
        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        bg.scale.set(1/FlxG.camera.zoom, 1/FlxG.camera.zoom);
        bg.alpha = 0.5;
        add(bg);

        var newText:FlxText = new FlxText(0,0,-1, "A new webview window has opened\nPress ESCAPE to return.");
        newText.setFormat("VCR OSD Mono", 22, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        newText.borderSize = 3;
        add(newText);
        newText.screenCenter();

        Thread.createWithEventLoop(()->{
            if (exit) return;
        });
    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.ESCAPE && !exit){
            exit = true;
        }
        super.update(elapsed);
        if (exit){
            onSubExit();
            close();
        }
    }

    public function onSubExit() {
        exit = true;
        FlxG.autoPause = CDevConfig.saveData.autoPause;
    }
}

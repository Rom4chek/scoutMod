package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.effects.FlxFlicker;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;

using StringTools;

class FreeplayCategoryState extends MusicBeatState
{
	var freeplayCats:Array<String> = ['Main Songs', 'Bonus Songs', 'Crossover Songs', 'Covers', 'Old Songs'];

	var accepted = false;
	var disableInput:Bool = false;
	var allowTransit:Bool = false;

	var grpCats:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	var BG:FlxSprite;
	var sectionImage:FlxSprite;

	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	final ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');

    override function create(){
        BG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		BG.color = 0x44db16;
		BG.updateHitbox();
		BG.screenCenter();
		add(BG);
        grpCats = new FlxTypedGroup<Alphabet>();
		add(grpCats);
        for (i in 0...freeplayCats.length)
        {
			var catsText:Alphabet = new Alphabet(90, 320, freeplayCats[i], true);
            catsText.targetX = i;
            catsText.isMenuItemCool = true;
			grpCats.add(catsText);
		}

		if (leftArrow == null){
			leftArrow = new FlxSprite(10, 300);
			leftArrow.frames = ui_tex;
			leftArrow.animation.addByPrefix('idle', "arrow left");
			leftArrow.animation.addByPrefix('press', "arrow push left");
			leftArrow.animation.play('idle');
			leftArrow.antialiasing = ClientPrefs.antialiasing;
		}
		add(leftArrow);
		
		if (rightArrow == null){
			rightArrow = new FlxSprite(leftArrow.x + 1210, leftArrow.y);
			rightArrow.frames = ui_tex;
			rightArrow.animation.addByPrefix('idle', 'arrow right');
			rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
			rightArrow.animation.play('idle');
			rightArrow.antialiasing = ClientPrefs.antialiasing;
		}
		add(rightArrow);

		add(sectionImage);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Freeplay Category Selection", null);
		#end

		new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				//allowTransit = true;
			});

        changeSelection();
        super.create();
    }

    override public function update(elapsed:Float){
        
		if (!accepted)
		{
			disableInput = false;
		}
		else
		{
			disableInput = true;
		}

		if (!FlxG.sound.music.playing)
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 1);

if (!disableInput)
	{
		if (controls.UI_LEFT_P) 
			changeSelection(-1);
		if (controls.UI_RIGHT_P) 
			changeSelection(1);
		if (controls.BACK /*|| (Main.focused) && allowTransit*/) {
			//allowTransit = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
        if (controls.ACCEPT)
			{
			accepted = true;

			FlxG.sound.play(Paths.sound('confirmMenu'));
			//FreeplayState.fromWeek = -1;

			FlxG.camera.flash(ClientPrefs.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1, true);

			FlxFlicker.flicker(sectionImage, 1, 0.06, false, false);

			remove(grpCats);

			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					switch(curSelected){
						case 0:
							MusicBeatState.switchState(new FreeplayState());
							FreeplayState.freeplayType = 0;
						case 1:
							MusicBeatState.switchState(new FreeplayState());
							FreeplayState.freeplayType = 1;
						case 2:
							MusicBeatState.switchState(new FreeplayState());
							FreeplayState.freeplayType = 2;
						case 3:
							MusicBeatState.switchState(new FreeplayState());
							FreeplayState.freeplayType = 3;
						case 4:
							MusicBeatState.switchState(new FreeplayState());
							FreeplayState.freeplayType = 4;
					}
				});
        }
	}
        super.update(elapsed);
    }

    function changeSelection(change:Int = 0) {

		curSelected += change;

		if (curSelected < 0)
			curSelected = freeplayCats.length - 1;
		if (curSelected >= freeplayCats.length)
			curSelected = 0;

		remove(sectionImage);
		sectionImage = new FlxSprite().loadGraphic(Paths.image('categories/cate'+curSelected));
		sectionImage.y += 180;
		sectionImage.scale.set(0.8, 0.8);
		sectionImage.alpha = 1;
		sectionImage.updateHitbox();
		sectionImage.screenCenter(X);
		add(sectionImage);

		var bullShit:Int = 0;

		for (item in grpCats.members) {
			item.targetX = bullShit - curSelected;
			bullShit++;

			item.alpha = 0;
			if (item.targetX == 0) {
				item.alpha = 1;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
    	}
	}
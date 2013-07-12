/*  This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License
   as published by the Free Software Foundation; either version 2
   of the License, or (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA  02110-1301, USA.
   
   ---
   Copyright (C) 2013, Thibaut Jacob <jacob@lri.fr>

┌───────────────────────────────────────────────────────────────┐
│░░░░░░░░░░ Description ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│
├───────────────────────────────────────────────────────────────┤
│ Textured button GUI element class representation              │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class TexturedButton extends Button {
   
    protected VerticalGradient idleGradient;
    protected VerticalGradient pressedGradient;
    protected color fromIdle = color( 255, 255, 255 );
    protected color toIdle = color( 226, 226, 226 );
    protected color fromPressed = color( 231, 231, 231 );
    protected color toPressed = color( 243, 243, 243 );
	protected Shadow shadow;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedButton  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public TexturedButton( PVector coordinates, int height, 
                           String text, String tooltipText ) {
        super( coordinates, height, text, tooltipText );
        this.width = int( textWidth( text )) + 30;
		this.shadow = new Shadow( color( 0, 0, 0, 20 ), this.coordinates, this.width, this.height, 2, this.roundness );
    }

    public TexturedButton( PVector coordinates, int height, 
                           String text, String tooltipText, boolean shadowed ) {
        super( coordinates, height, text, tooltipText, shadowed );
        this.width = int( textWidth( text )) + 30;
		this.shadow = new Shadow( color( 0, 0, 0, 20 ), this.coordinates, this.width, this.height, 2, this.roundness );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedButton :: draw  ░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            this.idleGradient = 
                new VerticalGradient( fromIdle, toIdle, height, this.width, 
                                      this.coordinates, this.roundness );
            this.pressedGradient = 
                new VerticalGradient( fromPressed, toPressed, height, this.width, 
                                      this.coordinates, this.roundness );
            this.tooltip = new TexturedTooltip( new PVector( this.coordinates.x + 5, 
                                                             this.coordinates.y + this.height ), 
                                                             this.tooltip.text );
            colorMode( RGB, 255 );
            if ( this.pressed ) {
                /* Shadow shadow = new Shadow( color( 0, 0, 0, 20 ), 
                                            new PVector( this.x, this.y ), 
                                            this.width, this.height, 2, this.roundness ); */
                this.shadow.draw();
                noFill();
                this.pressedGradient.draw();
            } else {
                /* Shadow shadow = new Shadow( color( 0, 0, 0, 20 ), 
                                            new PVector( this.x, this.y ), 
                                            this.width, this.height, 2, this.roundness ); */
                shadow.draw();
                noFill();
                this.idleGradient.draw();
            }
            stroke( 0, 0, 0, 50 );
            noFill();
            rect( this.coordinates.x - 1, this.coordinates.y - 1, this.width + 1, this.height + 1, 
                  this.roundness, this.roundness, this.roundness, this.roundness );
            stroke( 255, 255, 255, 100 );
            rect( this.coordinates.x + 1, this.coordinates.y + 1, this.width - 2, this.height - 2, 
                  this.roundness, this.roundness, this.roundness, this.roundness );
            // If mouse over
            if ( this.hovered ) {
                fill( 255, 255, 255, 70 );
                noStroke();
                rect( this.coordinates.x + 1, this.coordinates.y + 1, this.width - 2, this.height - 2, 
                      this.roundness, this.roundness, this.roundness, this.roundness );
                this.tooltip.draw();
            }
            textSize( this.textSize );
            // Draw text with carving
            fill( 255, 255, 255 );
            text( this.text, this.coordinates.x + 15, this.coordinates.y + height / 2 + 6 );
            fill( 100, 100, 100 );
            text( this.text, this.coordinates.x + 15, this.coordinates.y + height / 2 + 5 );
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Events  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void mousePressed() {
        if ( isInside( mouseX, mouseY ) ) {
            this.pressed = true;
        }
    }

    public void mouseReleased() {
        if ( this.pressed ) {
            this.pressed = false;
        }
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedButton :: setCoordinates  ░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
	@Override
	public void setCoordinates( PVector coordinates ) {
	    this.coordinates = coordinates;
	}

}
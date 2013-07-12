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
│ Textured dialog class representation                          │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class TexturedDialog extends Dialog {

    protected color from = color( 230, 230, 230 );
    protected color to = color( 219, 219, 219 );
    protected VerticalGradient vg;
    protected int gradientHeight = 40;
    protected TexturedButton okButton;
    protected TexturedButton cancelButton;
    protected int padding = 30;
	protected Shadow shadow;
    PFont neueBold18 = loadFont("HelveticaNeue-Bold-18.vlw");
    PFont neueBold11 = loadFont("HelveticaNeue-Bold-11.vlw");
    boolean dragging = false;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedDialog  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public TexturedDialog( PVector coordinates, int width, int height, 
                           String title, ArrayList<Control> controls ) {
        super( coordinates, width, height, title, controls );
        this.vg = new VerticalGradient( this.from, this.to, this.gradientHeight, width - 1, 
                                        new PVector( coordinates.x + 1, coordinates.y + height - this.gradientHeight ),
                                        0, 0, roundness, roundness );
        okButton = new TexturedButton( new PVector( this.coordinates.x + this.width - 80, 
                                                    this.coordinates.y + this.height - 32 ), 
                                                    24, "Proceed", "Let's go!" );
        cancelButton = new TexturedButton( new PVector( this.coordinates.x + this.width - 80 - okButton.width, 
                                                        this.coordinates.y + this.height - 32 ), 
                                                        24, "Cancel", "Hummm" );
        this.controls.add( okButton );
        this.controls.add( cancelButton );
		this.shadow = new Shadow( color( 0, 0, 0, 20 ), this.coordinates, this.width, this.height, 2, this.roundness );
    }

    public TexturedDialog( PVector coordinates, int width, int height, 
                           String title, ArrayList<Control> controls, int roundness ) {
        super( coordinates, width, height, title, controls, roundness );
        this.vg = new VerticalGradient( this.from, this.to, this.gradientHeight, width - 1, 
                                        new PVector( coordinates.x + 1, coordinates.y + height - this.gradientHeight ),
                                        0, 0, roundness, roundness );
        okButton = new TexturedButton( new PVector( this.coordinates.x + this.width - 80, 
                                                    this.coordinates.y + this.height - 32 ), 
                                                    24, "Proceed", "Let's go!" );
        cancelButton = new TexturedButton( new PVector( this.coordinates.x + this.width - 80 - okButton.width, 
                                                        this.coordinates.y + this.height - 32 ), 
                                                        24, "Cancel", "Hummm" );
        this.controls.add( okButton );
        this.controls.add( cancelButton );
		this.shadow = new Shadow( color( 0, 0, 0, 20 ), this.coordinates, 
		                          this.width, this.height, 2, this.roundness );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedDialog :: draw  ░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void draw() {
        if ( !this.hidden ) {
            // Shadow shadow = new Shadow( color( 0, 0, 0, 20 ), this.coordinates, this.width, this.height, 2, this.roundness );
            this.shadow.draw();
            fill( 240, 240, 240 );
            stroke( 239, 239, 239 );
            rect( this.coordinates.x, this.coordinates.y, this.width, this.height, 
                  this.roundness, this.roundness, this.roundness, this.roundness );
            noFill();
            stroke( 172, 172, 172 );
            rect( this.coordinates.x - 1, this.coordinates.y - 1, this.width + 2, this.height + 2, 
                  this.roundness, this.roundness, this.roundness, this.roundness );
            fill( 100, 100,100 );

            this.vg.draw();
            stroke( 200, 200, 200 );
            line( this.coordinates.x + 1, this.coordinates.y + height - this.gradientHeight - 1, 
                  this.coordinates.x + this.width - 1, this.coordinates.y + this.height - this.gradientHeight - 1 );
            stroke( 239, 239, 239 );
            line( this.coordinates.x + 1, this.coordinates.y + height - this.gradientHeight, 
                  this.coordinates.x + this.width - 1, this.coordinates.y + this.height - this.gradientHeight );

            // PFont font = loadFont("HelveticaNeue-Bold-18.vlw");
            textFont( neueBold18, 18 );
            // fill( 100, 100, 100 );
            text( this.title, this.coordinates.x + this.padding / 2, this.coordinates.y + this.padding );

            for ( Control control : this.controls ) {
                control.draw();
            }
            // PFont font2 = loadFont("HelveticaNeue-Bold-11.vlw");
            textFont( neueBold11, 11 );
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Events  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    void mouseDragged() {
        if ( isInside( mouseX, mouseY ) || dragging ) {
            this.dragging = true;
            PVector newCoordinates = new PVector( this.coordinates.x - pmouseX + mouseX, 
                                                  this.coordinates.y - pmouseY + mouseY );
            PVector dist = new PVector( this.coordinates.x - newCoordinates.x, 
                                        this.coordinates.y - newCoordinates.y );
            this.coordinates.x = newCoordinates.x;
            this.coordinates.y = newCoordinates.y;
            PVector gradientCoordinates = this.vg.getCoordinates();
            this.vg.setCoordinates( new PVector( gradientCoordinates.x - dist.x, 
                                                 gradientCoordinates.y - dist.y ));
            for ( Control control : this.controls ) {
                control.coordinates.x -= dist.x;
                control.coordinates.y -= dist.y;
                control.mouseDragged();
            }
        }
    }
    
    void mouseReleased() {
        this.dragging = false;
    }

}
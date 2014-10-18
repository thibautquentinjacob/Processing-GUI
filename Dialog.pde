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
│ Color class representation                                    │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class Dialog {

    protected PVector coordinates;
    protected int width, height;
    protected int roundness;
    protected String title;
    protected ArrayList<Control> controls;
    protected boolean hidden;
    protected CSSParser cssParser;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Dialog  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Dialog( PVector coordinates, int width, int height, String title, ArrayList<Control> controls ) {
        this.coordinates = coordinates;
        this.width = width;
        this.height = height;
        this.title = title;
        this.controls = controls;
        this.roundness = 0;
    }

    public Dialog( PVector coordinates, int width, int height, String title, ArrayList<Control> controls, int roundness ) {
        this.coordinates = coordinates;
        this.width = width;
        this.height = height;
        this.title = title;
        this.controls = controls;
        this.roundness = roundness;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Dialog :: draw  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void draw() {
        if ( this.hidden ) {
            colorMode( RGB, 255 );
            background( 229, 229, 229 );
            stroke( 0, 0, 0 );
            fill( 255, 255, 255 );
            rect( this.coordinates.x, this.coordinates.y, 
                  this.width, this.height, this.roundness, 
                  this.roundness, this.roundness, this.roundness );
            for ( Control control : this.controls ) {
                control.draw();
            }
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Dialog :: isInside ░░░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Checks if the cursor is inside the dialog. │
    └────────────────────────────────────────────┘ */
    protected boolean isInside( int mouseX, int mouseY ) {
        float distX = mouseX - this.coordinates.x;
        float distY = mouseY - this.coordinates.y;
        if ( distX >= 0 && distX <= this.width && 
             distY >= 0 && distY <= this.height ) {
            return true;
        } else {
            return false;
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Dialog :: hide  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void hide() {
        this.hidden = true;
        for ( Control control : this.controls ) {
            control.hide();
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Dialog :: show  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void show() {
        this.hidden = false;
        for ( Control control : this.controls ) {
            control.show();
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Dialog :: toggle  ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void toggle() {
        this.hidden = !this.hidden;
        for ( Control control : this.controls ) {
            control.toggle();
        }
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Dialog :: addControl ░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Add given control to this group.           │
    └────────────────────────────────────────────┘ */
    public void addControl( Control control ) {
        this.controls.add( control );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Events  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    void mouseClicked() {
        try {
            for ( Control control : this.controls ) {
                control.mouseClicked();
            }
        } catch ( Exception e ) {}
    }

    void mouseMoved() {
        for ( Control control : this.controls ) {
            control.mouseMoved();
        }
    }

    void mouseReleased() {
        for ( Control control : this.controls ) {
            control.mouseReleased();
        }
    }

    void mousePressed() {
        for ( Control control : this.controls ) {
            control.mousePressed();
        }
    }

    void mouseDragged() {
        if ( isInside( mouseX, mouseY )) {
            PVector dist = new PVector( this.coordinates.x - mouseX, this.coordinates.y - mouseY );
            this.coordinates.x = this.coordinates.x + pmouseX - mouseX;
            this.coordinates.y = this.coordinates.y + pmouseY - mouseY;
            for ( Control control : this.controls ) {
                control.coordinates.x -= dist.x;
                control.coordinates.y -= dist.y;
                control.mouseDragged();
            }
        }
    }

    void keyPressed() {
        for ( Control control : this.controls ) {
            control.keyPressed();
        }
    }

}
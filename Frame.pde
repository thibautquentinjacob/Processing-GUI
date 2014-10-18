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
│ Frame class representation                                    │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class Frame {

    protected int width, height;
    protected ArrayList<Control> controls;
    protected ArrayList<Dialog> dialogs;
    protected String title;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Frame  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Frame( int width, int height, String title ) {
        this.width = width;
        this.height = height;
        this.controls = new ArrayList<Control>();
        this.dialogs = new ArrayList<Dialog>();
        this.title = title;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Frame :: draw  ░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void draw() {
        colorMode( RGB, 255 );
        background( 30 );
        for ( Control control : this.controls ) {
            control.draw();
        }
        for ( Dialog dialog : this.dialogs ) {
            dialog.draw();
        }
        // Draw title bar
        VerticalGradient titleBar = new VerticalGradient( color( 40 ), color( 0 ), 24, this.width, 
                                                          new PVector( 0, 0 ), 5, 5, 0, 0 );
        titleBar.draw();
        stroke( 255, 255, 255, 20 );
        line( 0, 23, this.width, 23 );
        stroke( 0 );
        line( 0, 24, this.width, 24 );
        // title name
        fill( 255 );
        text( this.title, ( this.width - textWidth( this.title )) / 2, 16 );
        // buttons
        fill( 255 );
        // ellipse( 12, 12, 10, 10 );
        // ellipse( 30, 12, 10, 10 );
        // ellipse( 48, 12, 10, 10 );
        VerticalGradient closeButton = new VerticalGradient( color( 100, 100, 100 ), color( 50, 50, 50 ), 10, 10, 
                                                          new PVector( 7, 7 ), 15, 15, 15, 15 );
        VerticalGradient hideButton = new VerticalGradient( color( 100, 100, 100 ), color( 50, 50, 50 ), 10, 10, 
                                                          new PVector( 27, 7 ), 15, 15, 15, 15 );
        VerticalGradient zoomButton = new VerticalGradient( color( 100, 100, 100 ), color( 50, 50, 50 ), 10, 10, 
                                                          new PVector( 47, 7 ), 15, 15, 15, 15 );
        closeButton.draw();
        hideButton.draw();
        zoomButton.draw();
        // frame border
        noFill();
        stroke( 0 );
        rect( 0, 0, this.width - 1, this.height - 1 );

    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Frame :: addControl ░░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Add given control to this frame.           │
    └────────────────────────────────────────────┘ */
    public void addControl( Control control ) {
        this.controls.add( control );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Frame :: getControl ░░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Returns control with input ID.             │
    └────────────────────────────────────────────┘ */
    public Control getControl( int ID ) {
        for ( int i = 0 ; i < this.controls.size() ; i++ ) {
            Control control = this.controls.get( i );
            if ( control.controlID == ID ) {
                return control;
            }
        }
        throw new IllegalArgumentException( "ID Not found: " + ID );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Frame :: printControls ░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Print each controls.                       │
    └────────────────────────────────────────────┘ */
    public void printControls() {
        for ( int i = 0 ; i < this.controls.size() ; i++ ) {
            Control control = this.controls.get( i );
            println( control.controlID );
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Frame :: addDialog ░░░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Add given dialog to this frame.            │
    └────────────────────────────────────────────┘ */
    public void addDialog( Dialog dialog ) {
        this.dialogs.add( dialog );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Frame :: setTitle ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Set the title of the frame.                │
    └────────────────────────────────────────────┘ */
    public void setTitle( String title ) {
        this.title = title;
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
            for ( Dialog dialog : this.dialogs ) {
                dialog.mouseClicked();
            }
        } catch (Exception e) {
        }
    }

    void mouseMoved() {
        for ( Control control : this.controls ) {
            control.mouseMoved();
        }
        for ( Dialog dialog : this.dialogs ) {
            dialog.mouseMoved();
        }
    }

    void mouseReleased() {
        for ( Control control : this.controls ) {
            control.mouseReleased();
        }
        for ( Dialog dialog : this.dialogs ) {
            dialog.mouseReleased();
        }
    }

    void mousePressed() {
        for ( Control control : this.controls ) {
            control.mousePressed();
        }
        for ( Dialog dialog : this.dialogs ) {
            dialog.mousePressed();
        }
    }

    void mouseDragged() {
        // frame.setLocation( pmouseX, pmouseY );
        for ( Control control : this.controls ) {
            control.mouseDragged();
        }
        for ( Dialog dialog : this.dialogs ) {
            dialog.mouseDragged();
        }
    }

    void keyPressed() {
        for ( Control control : this.controls ) {
            control.keyPressed();
        }
        for ( Dialog dialog : this.dialogs ) {
            dialog.keyPressed();
        }
    }

}
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
│ Tabs GUI element class representation                         │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│   √ Add shadow on hover                                     │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class Tabs extends Control {

    protected ArrayList<String>                    titles;      // Tab titles
    protected HashMap<Integer, ArrayList<Control>> controls;    // Control arrays for each tab
    protected int                                  currentTab;  // currently selected tab index
    protected int                                  hoveredTab;  // currently hovered tab index
    protected float                                textLength;  // Total title length
    protected float                                tabLength;   // Total tab length
    protected ArrayList<Float>                     tabLengths;  // Tab lengths
    protected float                                space;       // Starting / Ending space before and after tabs

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Tabs  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Tabs( PVector coordinates,
                 ArrayList<String> titles,
                 HashMap<Integer,
                 ArrayList<Control>> controls,
                 int currentTab ) {
        this.coordinates = coordinates;
        this.titles = titles;
        this.controls = controls;
        this.width = 300;
        this.height = 400;
        this.disabled = false;
        this.type = "Tabs";
        this.roundness = 5;
        this.padding = 10;
        this.currentTab = currentTab;
        this.hoveredTab = -1;
        this.textLength = 0;
        this.tabLengths = new ArrayList<Float>();
        // Sum up titles length
        for ( int i = 0 ; i < this.titles.size() ; i++ ) {
            String title = this.titles.get( i );
            if ( i > 0 ) {
                this.tabLengths.add( this.textLength + 3/2 * this.padding * i );
            } else {
                this.tabLengths.add( 0. );
            }
            println( "tabL: " + this.tabLengths.get( i ));
            this.textLength += textWidth( title );
            println( "textL: " + this.textLength );
        }
        this.tabLength = this.textLength + this.titles.size() * 3/2 * this.padding; // titles + padding
        this.space = ( this.width - this.tabLength ) / 2;
        println( "tabLength: " + this.tabLength );
        println( this.space );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Tabs :: draw  ░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            // Draw tab background
            fill( 20 );
            stroke( 20 );
            rect( this.coordinates.x, this.coordinates.y, this.width, this.height,
                  this.roundness, this.roundness, this.roundness, this.roundness );
            // Draw the tab headers
            for ( int i = 0 ; i < this.titles.size() ; i++ ) {
                String title = this.titles.get( i );
                // There is only one tab
                if ( i == 0 && i == this.titles.size() - 1 ) {
                    fill( 0 );
                    rect( this.coordinates.x + ( this.width - textLength ) / 2, this.coordinates.y - 12,
                          textLength + this.padding, 24, this.roundness, this.roundness, this.roundness, this.roundness );
                    fill( 255 );
                    text( title, this.coordinates.x + ( this.width - textLength ) / 2 + 5, this.coordinates.y + 3 );
                    break;
                }
                // If there are several tabs
                stroke( 0 );
                float textL = textWidth( title );
                // First tab
                if ( i == 0 ) {
                    VerticalGradient tab;
                    // If this tab is not selected
                    if ( i != currentTab ) {
                        tab = new VerticalGradient( color( 40 ), color( 20 ), 24,
                                                          (int)textL + 2 * this.padding,
                                                          new PVector( this.coordinates.x + this.space + this.tabLengths.get( i ),
                                                                       this.coordinates.y - 12 ),
                                                          this.roundness, 0, 0, this.roundness );
                    // If it is selected
                    } else {
                        tab = new VerticalGradient( color( 0 ), color( 20 ), 24,
                                                          (int)textL + 2 * this.padding,
                                                          new PVector( this.coordinates.x + this.space + this.tabLengths.get( i ),
                                                                       this.coordinates.y - 12 ),
                                                          this.roundness, 0, 0, this.roundness );
                    }
                    // if hovered
                    if ( i == this.hoveredTab ) {
                        Shadow shadow = new Shadow( color( 0, 100, 200 ),
                                                    new PVector( this.coordinates.x + this.space + this.tabLengths.get( i ),
                                                                 this.coordinates.y - 12 ),
                                                    (int)textL + 2 * this.padding - 5, 20, 5, this.roundness, 0, 0, this.roundness );
                        shadow.draw();
                    }
                    tab.draw();
                    noFill();
                    rect( this.coordinates.x + this.space + this.tabLengths.get( i ),
                          this.coordinates.y - 12, (int)textL + 2 * this.padding, 24, this.roundness, 0, 0, this.roundness );
                // Last tab
                } else if ( i == this.titles.size() - 1 ) {
                    VerticalGradient tab;
                    // If this tab is not selected
                    if ( i != currentTab ) {
                        tab = new VerticalGradient( color( 40 ), color( 20 ), 24,
                                                          (int)textL + 2 * this.padding,
                                                          new PVector( this.coordinates.x + this.space + this.tabLengths.get( i ),
                                                                       this.coordinates.y - 12 ),
                                                          0, this.roundness, this.roundness, 0 );
                    // If it is selected
                    } else {
                        tab = new VerticalGradient( color( 0 ), color( 20 ), 24,
                                                          (int)textL + 2 * this.padding,
                                                          new PVector( this.coordinates.x + this.space + this.tabLengths.get( i ),
                                                                       this.coordinates.y - 12 ),
                                                          0, this.roundness, this.roundness, 0 );
                    }
                    // if hovered
                    if ( i == this.hoveredTab ) {
                        Shadow shadow = new Shadow( color( 0, 100, 200 ),
                                                    new PVector( this.coordinates.x + this.space + this.tabLengths.get( i ),
                                                                 this.coordinates.y - 12 ),
                                                    (int)textL + 2 * this.padding - 5, 20, 5, 0, this.roundness, this.roundness, 0 );
                        shadow.draw();
                    }
                    tab.draw();
                    noFill();
                    rect( this.coordinates.x + this.space + this.tabLengths.get( i ), this.coordinates.y - 12,
                          (int)textL + 2 * this.padding, 24, 0, this.roundness, this.roundness, 0 );
                // In between tab
                } else {
                    VerticalGradient tab;
                    // If this tab is not selected
                    if ( i != currentTab ) {
                        tab = new VerticalGradient( color( 40 ), color( 20 ), 24,
                                                          (int)textL + 2 * this.padding,
                                                          new PVector( this.coordinates.x + this.space + this.tabLengths.get( i ),
                                                                       this.coordinates.y - 12 ),
                                                          0 );
                    // If it is selected
                    } else {
                        tab = new VerticalGradient( color( 0 ), color( 20 ), 24,
                                                          (int)textL + 2 * this.padding,
                                                          new PVector( this.coordinates.x + this.space + this.tabLengths.get( i ),
                                                                       this.coordinates.y - 12 ),
                                                          0 );
                    }
                    // if hovered
                    if ( i == this.hoveredTab ) {
                        Shadow shadow = new Shadow( color( 0, 100, 200 ),
                                                    new PVector( this.coordinates.x + this.space + this.tabLengths.get( i ),
                                                                 this.coordinates.y - 12 ),
                                                    (int)textL + 2 * this.padding - 5, 20, 5, 0 );
                        shadow.draw();
                    }
                    tab.draw();
                    noFill();
                    rect( this.coordinates.x + this.space + this.tabLengths.get( i ), this.coordinates.y - 12,
                          (int)textL + 2 * this.padding, 24 );
                }

                fill( 255 );
                text( title, this.coordinates.x + this.space + this.tabLengths.get( i ) + this.padding, this.coordinates.y + 3 );

            }
            // Draw all the controls inside the current tab
            ArrayList<Control> tabControls = this.controls.get( this.currentTab );
            for ( Control control: tabControls ) {
                control.draw();
            }
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Tabs :: getTitles  ░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public ArrayList<String> getTitles() {
        return this.titles;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Tabs :: getControls  ░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public HashMap<Integer, ArrayList<Control>> getControls() {
        return this.controls;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Tabs :: addControl  ░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void addControl( Control control, int tabIndex ) {
        this.controls.get( tabIndex ).add( control );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Tabs :: isInside ░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Checks if the cursor is inside a tab.      │
    └────────────────────────────────────────────┘ */
    public boolean isInside( int mouseX, int mouseY ) {
        for ( int i = 0 ; i < this.titles.size() ; i++ ) {
            float distX = mouseX - ( this.coordinates.x + this.space + this.tabLengths.get( i ));
            float distY = mouseY - ( this.coordinates.y - 12 );
            if ( distX >= 0 && distX <= textWidth( this.titles.get( i )) + 20 && distY >= 0 && distY <= 24 ) {
                hoveredTab = i;
                return true;
            }
        }
        hoveredTab = -1;
        return false;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Events  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void mouseClicked() {
        if ( isInside( mouseX, mouseY )) {
            this.currentTab = this.hoveredTab;
        }
        ArrayList<Control> tabControls = this.controls.get( this.currentTab );
        for ( Control control: tabControls ) {
            control.mouseMoved();
        }
    }

    @Override
    public void mouseMoved() {
        isInside( mouseX, mouseY );
        ArrayList<Control> tabControls = this.controls.get( this.currentTab );
        for ( Control control: tabControls ) {
            control.mouseMoved();
        }
    }

    @Override
    public void keyPressed() {
    }
}

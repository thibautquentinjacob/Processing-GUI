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
   Copyright (C) 2013, Thibaut Jacob <jacob@lri.fr> */

/* Description
   ===========
   Main program
   
   TODO
   ==============

   FIXME
   ==============
   
*/

int width = 800;
int height = 800;
Frame newFrame;
ArrayList<Integer> times = new ArrayList<Integer>();
int timeTotal = 0;

TexturedDialog alert;

void draw() {
    int timeStart = millis();
    colorMode( RGB, 255 );
    background( 229, 229, 229 );
    fill( 0 );
    stroke( 0 );
    text( mouseX + " x " + mouseY, 10 , 10 );
    newFrame.draw();
    int timeEnd = millis();
    // println( "Complete drawing: " + ( timeEnd - timeStart ));
    timeTotal += timeEnd - timeStart;
    // times.add( timeEnd - timeStart );
//     for ( int time : times ) {
//         timeTotal += time;
//     }
    println( "Average Drawing time by frame: " + timeTotal / frameCount + " last was: " + ( timeEnd - timeStart ));
}

void setup() {
    size( width, height );
    smooth();
    frameRate( 30 );
    //background( 255 );
    // textFont( createFont( "Helvetica medium", 10, true ));
    PFont neueBold11 = loadFont("HelveticaNeue-Bold-11.vlw");
    textFont( neueBold11, 11 );

    newFrame = new Frame( width, height );
    
    // Controls
    String[] checks = { "Check 1", "Check 2", "Check 3", "Check 4" };
    boolean[] checkSelected = { false, true, false, true };
    String[] options = { "Option 1", "Option 2", "Option 3", "Option 4", "Option 5" };
    TexturedButton but = new TexturedButton( new PVector( 50, 150 ), 24, "Switch test ON", "Switch it on", true );
    TexturedButton but2 = new TexturedButton( new PVector( 50, 190 ), 24, "Quit", "Quit the program", true );
    TexturedCheckBox cb = new TexturedCheckBox( new PVector( 50, 50 ), 11, checks, true, checkSelected );
    TexturedTextField tf = new TexturedTextField( new PVector( 50, 230 ), 100, "sample text" );
    TexturedRadioButton rb = new TexturedRadioButton( new PVector( 50, 300 ), 11, options );
    TexturedSlider ts = new TexturedSlider( new PVector( 50, 400 ), 0, 100, 100 );

    // Actions
    Action addTestButton = new Action( "AddTestButton", new Callable<Integer>() {
        public Integer call() {
            alert.toggle();
            return 1;
        }
    });

    Action quit = new Action( "quit", new Callable<Integer>() {
        public Integer call() {
            exit();
            return 1;
        }
    });

    // Action Bindings
    but.setAction( "mouseClicked", addTestButton );
    but2.setAction( "mouseClicked", quit );

    ArrayList<Control> dialogControls = new ArrayList<Control>();
    String[] optionsDialog = { "Badly Annoyed", "Annoyed", "Normal", "Cheerful" };
    dialogControls.add( new Label( new PVector( 150 + 15, 50 + 50 ), 30, "Describe how you feel. Pick an option below." ));
    dialogControls.add( new TexturedRadioButton( new PVector( 150 + 15, 50 + 90 ), 11, optionsDialog ));
    alert = new TexturedDialog( new PVector( 150, 50 ), 400, 200, "Alert!", dialogControls, 8 );

    // Add controls to frame
    newFrame.addControl( tf );
    newFrame.addControl( cb );
    newFrame.addControl( but );
    newFrame.addControl( but2 );
    newFrame.addControl( rb );
    newFrame.addControl( ts );

    // Add dialog to frame
    newFrame.addDialog( alert );
}

void mouseClicked() {
    newFrame.mouseClicked();
}

void mouseMoved() {
    newFrame.mouseMoved();
}

void mouseReleased() {
    newFrame.mouseReleased();
}

void mousePressed() {
    newFrame.mousePressed();
}

void mouseDragged() {
    newFrame.mouseDragged();
}

void keyPressed() {
    newFrame.keyPressed();
}
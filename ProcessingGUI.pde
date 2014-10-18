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
│ Main program                                                  │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│   * Add handy functions like setBackground, setOuterBorder, │░│
│     etc ...                                                 │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

int width = 800;
int height = 800;
Frame newFrame;

TexturedDialog alert;

void init() {
 
  // trick to make it possible to change the frame properties
  frame.removeNotify(); 
 
  // comment this out to turn OS chrome back on
  frame.setUndecorated(true); 
 
  // comment this out to not have the window "float"
  // frame.setAlwaysOnTop(true); 
 
  frame.setResizable(true);  
  frame.addNotify(); 
  frame.setOpacity( 0.95 );
  frame.setLocation( 1000, 10 );
 
  // making sure to call PApplet.init() so that things 
  // get  properly set up.
  super.init();
}

void draw() {
    int timeStart = millis();
    colorMode( RGB, 255 );
    background( 55, 55, 55 );
    fill( 0 );
    stroke( 0 );
    newFrame.setTitle( "Processing GUI [" + int(frameRate) + " fps]" );
    newFrame.draw();
    Slider ts = (Slider)newFrame.getControl( 7 );
    if ( ts.isBeingDragged()) {
        Label sliderLabel = (Label)newFrame.getControl( 13 );
        sliderLabel.setText( ts.getDragPositions().get( 0 ) + "" );
    }
}

void setup() {
    size( width, height );
    smooth();
    frameRate( 60 );
    PFont neue = createFont( "Helvetica", 14, true );
    textFont( neue, 14 );

    newFrame = new Frame( width, height, "Processing GUI : Demo page" );

    // Controls
    String[] checks = { "Check 1", "Check 2", "Check 3", "Check 4" };
    boolean[] checkSelected = { false, true, false, true };
    String[] options = { "Option 1", "Option 2", "Option 3", "Option 4", "Option 5" };
    Button but = new Button( new PVector( 50, 150 ), "Switch test ON", "Switch it on" );
    Button but2 = new Button( new PVector( 50, 190 ), "Quit", "Quit the program" );
    CheckBox cb = new CheckBox( new PVector( 50, 50 ), 14, checks, checkSelected );
    TextField tf = new TextField( new PVector( 150, 50 ), 100, "sample text" );
    Button assign = new Button( new PVector( 260, 50 ), "Assign ->", "" );
    Label assignLabel = new Label( new PVector( 350, 50 ), 24, "empty" );
    RadioButton rb = new RadioButton( new PVector( 50, 300 ), 14, options );
    Slider ts = new Slider( new PVector( 50, 420 ), 0, 200, 200 );
    ProgressBar pb = new ProgressBar( new PVector( 50, 500 ), 200, 15, 50, 100 );
    Label parse = new Label( new PVector( 50, 475 ), 24, "Parsing file " );
    // TextArea textArea = new TextArea( new PVector( 300, 100 ), 200, 500, "Type some text here" );
    ArrayList<String> tabsTitles = new ArrayList<String>(){{ add( "Tab1" ); add( "Tab2" ); add( "Tab3" ); add( "Fourth" ); add( "Fifth" ); }};
    HashMap<Integer, ArrayList<Control>> tabsControls = new HashMap<Integer, ArrayList<Control>>();
    tabsControls.put( 0, new ArrayList<Control>(){{ add( new Button( new PVector( 500, 250 ), "test", "" )); }});
    tabsControls.put( 1, new ArrayList<Control>(){{ add( new Button( new PVector( 500, 300 ), "test", "" )); }});
    tabsControls.put( 2, new ArrayList<Control>());
    tabsControls.put( 3, new ArrayList<Control>());
    tabsControls.put( 4, new ArrayList<Control>());
    tabsControls.put( 5, new ArrayList<Control>());
    Tabs tabs = new Tabs( new PVector( 400, 200 ), tabsTitles, tabsControls, 1 );
    Label sliderLabel = new Label( new PVector( 310, 400 ), 24, "0" );

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

    Action assignTextFieldValueToLabel = new Action( "assignTextFieldValueToLabel", new Callable<Integer>() {
        public Integer call() {
            final TextField tf = (TextField)newFrame.getControl( 3 );
            final Label assignLabel = (Label)newFrame.getControl( 5 );
            String text = tf.getText();
            assignLabel.setText( text );
            return 1;
        }
    });

    // Action Bindings
    but.addAction( "mouseClicked", addTestButton );
    but2.addAction( "mouseClicked", quit );
    assign.addAction( "mouseClicked", assignTextFieldValueToLabel );

    ArrayList<Control> dialogControls = new ArrayList<Control>();
    String[] optionsDialog = { "Badly Annoyed", "Annoyed", "Normal", "Cheerful" };
    dialogControls.add( new Label( new PVector( 150 + 15, 50 + 50 ), 30, "Describe how you feel. Pick an option below." ));
    dialogControls.add( new RadioButton( new PVector( 150 + 15, 50 + 90 ), 11, optionsDialog ));
    alert = new TexturedDialog( new PVector( 150, 50 ), 400, 200, "Alert!", dialogControls );

    // Add controls to frame
    newFrame.addControl( tf );
    newFrame.addControl( assign );
    newFrame.addControl( assignLabel );
    newFrame.addControl( cb );
    newFrame.addControl( but );
    newFrame.addControl( but2 );
    newFrame.addControl( rb );
    newFrame.addControl( ts );
    newFrame.addControl( pb );
    newFrame.addControl( parse );
    // newFrame.addControl( textArea );
    newFrame.addControl( tabs );
    newFrame.addControl( sliderLabel );

    // newFrame.printControls();

    // Add dialog to frame
    // newFrame.addDialog( alert );
}

void mouseClicked() {
    newFrame.mouseClicked();
}

void mouseMoved() {
    ProgressBar pb = (ProgressBar)newFrame.getControl( 8 );
    pb.setProgress( (float)mouseX / (float)width * 100 );
    Label parse = (Label)newFrame.getControl( 9 );
    parse.setText( "Parsing file number " + int( (float)mouseX / (float)width * 1000 ) + " out of 1000" );
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
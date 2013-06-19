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
   - Linear / Radial gradient

   FIXME
   ==============
   
*/

int width = 800;
int height = 800;
PVector groupPosition = new PVector( 30, 30 );
Group group = new Group( "test", groupPosition );
ArrayList<Integer> sliderPositions;
ArrayList<Integer> sliderPositions2;
Slider slider;
void draw() {
    colorMode( RGB, 255 );
    background( #25282c );
      // if ( frameCount % 30 == 0 ) {
      //   int max = (int)(Math.random() * (200-10)) + 10;
      //   slider.setMax( max );
      //   fill( 0 );
      //   text( "Max " + max, 200, 10 );
      // }
    group.draw();
    fill( 0 );
    stroke( 0 );
    text( mouseX + " x " + mouseY, 10 , 10 );
}

void setup() {
    size( width, height );
    sliderPositions = new ArrayList<Integer>();
    sliderPositions.add( 100 );
    sliderPositions.add( 25 );
    sliderPositions.add( 50 );
    sliderPositions2 = new ArrayList<Integer>();
    sliderPositions2.add( 70 );
    sliderPositions2.add( 25 );
    sliderPositions2.add( 50 );
    String[] checks = { "Check 1", "Check 2", "Check 3", "Check 4" };
    boolean[] checkSelected = { false, true, false, true };
    String[] options = { "Option 1", "Option 2", "Option 3", "Option 4", "Option 5" };
    group.addControl( new CheckBox( 50, 50, 12, checks, true, checkSelected ));
    group.addControl( new Button( 50, 100, 20, "Button", true ));
    group.addControl( new Label( 50, 150, 20, "Label" ));
    group.addControl( new RadioButtons( 50, 190, 12, options, true, 1 ));
    group.addControl( new Slider( 50, 300, 0, 500, 400, sliderPositions ));
    slider = new Slider( 450, 300, 0, 500, 300, sliderPositions2 );
    group.addControl( slider );
}

void mouseClicked() {
    group.mouseClicked();
}

void mouseMoved() {
    group.mouseMoved();
}

void mouseReleased() {
    group.mouseReleased();
}

void mousePressed() {
    group.mousePressed();
}

void mouseDragged() {
    group.mouseDragged();
    slider.mouseDragged();
}
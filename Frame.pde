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
   
   TODO
   ==============

   FIXME
   ==============
   
*/

class Frame {

    protected int width, height;
    protected ArrayList<Control> controls;
    protected ArrayList<Dialog> dialogs;

    public Frame( int width, int height ) {
        this.width = width;
        this.height = height;
        this.controls = new ArrayList<Control>();
        this.dialogs = new ArrayList<Dialog>();
    }

    public void draw() {
        colorMode( RGB, 255 );
        background( 229, 229, 229 );
        for ( Control control : this.controls ) {
            control.draw();
        }
        for ( Dialog dialog : this.dialogs ) {
            dialog.draw();
        }
    }

    public void addControl( Control control ) {
        this.controls.add( control );
    }

    public void addDialog( Dialog dialog ) {
        this.dialogs.add( dialog );
    }

    // Events
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
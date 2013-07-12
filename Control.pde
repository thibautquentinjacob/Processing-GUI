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
│ GUI object super class                                        │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│   Implement disabled state                                  │░│
│   Add scale                                                 │░│
│   Add constructors without coordinates for groups           │░│
│ FIXME                                                       │░│
│   Fix bug when clicking on button in dialog window          │░│
│   Fix radio buttons and checkboxes selection                │░│
└─────────────────────────────────────────────────────────────┴─┘ */

abstract class Control {
    
    protected Color fillColor = new Color( 200, 200, 200 );
    protected Color strokeColor = new Color( 100, 100, 100 );
    protected PVector coordinates;
    protected int width, height;
    protected boolean shadowed;
    protected boolean hovered;
    protected boolean disabled;
    protected boolean hidden = false;
    protected int textSize = 11;
    protected int roundness = 5;
    protected String type;
    protected Tooltip tooltip;
    protected ArrayList<Action> mouseClickedActions = new ArrayList<Action>();
    protected ArrayList<Action> mouseMovedActions = new ArrayList<Action>();
    protected ArrayList<Action> mousePressedActions = new ArrayList<Action>();
    protected ArrayList<Action> mouseReleasedActions = new ArrayList<Action>();
    protected ArrayList<Action> mouseDraggedActions = new ArrayList<Action>();
    protected ArrayList<Action> keyPressedActions = new ArrayList<Action>();

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: draw  ░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void draw() {}
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: isInside ░░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Checks if the cursor is inside the control.│
    └────────────────────────────────────────────┘ */
    public boolean isInside( int mouseX, int mouseY ) {
        float distX = mouseX - this.coordinates.x;
        float distY = mouseY - this.coordinates.y;
        if ( distX >= 0 && distX <= this.width && distY >= 0 && distY <= this.height ) {
            return true;
        } else {
            return false;
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: hide  ░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void hide() {
        this.hidden = true;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: show  ░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void show() {
        this.hidden = false;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: toggle  ░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void toggle() {
        this.hidden = !this.hidden;
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Events  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void mouseClicked() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mouseClickedActions ) {
                action.call();
            }
        }
    }
    public void mouseMoved() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mouseMovedActions ) {
                action.call();
            }
        }
    }
    public void mousePressed() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mousePressedActions ) {
                action.call();
            }
        }
    }
    public void mouseReleased() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mouseReleasedActions ) {
                action.call();
            }
        }
    }
    public void mouseDragged() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mouseDraggedActions ) {
                action.call();
            }
        }
    }
    public void keyPressed() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : keyPressedActions ) {
                action.call();
            }
        }
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: addAction ░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Add an action of the given type to the     │
    │ control.                                   │
    └────────────────────────────────────────────┘ */
    public void addAction( String actionType, Action action ) {
        if ( actionType == "mouseClicked" ) {
            mouseClickedActions.add( action );
        } else if ( actionType == "mouseMoved" ) {
            mouseMovedActions.add( action );
        } else if ( actionType == "mousePressed" ) {
            mousePressedActions.add( action );
        } else if ( actionType == "mouseReleased" ) {
            mouseReleasedActions.add( action );
        } else if ( actionType == "mouseDragged" ) {
            mouseDraggedActions.add( action );
        } else if ( actionType == "keyPressed" ) {
            keyPressedActions.add( action );
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: removeAction ░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Remove target action from the control.     │
    └────────────────────────────────────────────┘ */
    public void removeAction ( String actionType, Action action ) {
        if ( actionType == "mouseClicked" ) {
            mouseClickedActions.remove( action );
        } else if ( actionType == "mouseMoved" ) {
            mouseMovedActions.remove( action );
        } else if ( actionType == "mousePressed" ) {
            mousePressedActions.remove( action );
        } else if ( actionType == "mouseReleased" ) {
            mouseReleasedActions.remove( action );
        } else if ( actionType == "mouseDragged" ) {
            mouseDraggedActions.remove( action );
        } else if ( actionType == "keyPressed" ) {
            keyPressedActions.remove( action );
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: setColor  ░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setColor( Color fillColor, Color strokeColor ) {
        this.fillColor = fillColor;
        this.strokeColor = strokeColor;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: getColor  ░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Color[] getColor() {
        Color[] colors = { this.fillColor, this.strokeColor };
        return colors;
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: getCoordinates  ░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public PVector getCoordinates() {
        return this.coordinates;
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: setCoordinates  ░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setCoordinates( PVector coordinates ) {
        this.coordinates = coordinates;
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: setShadowed  ░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setShadowed( boolean shadowed ) {
        this.shadowed = shadowed;
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: setDisabled  ░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setDisabled( boolean disabled ) {
        this.disabled = disabled;
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: getWidth  ░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public int getWidth() {
        return this.width;
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: getHeight  ░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public int getHeight() {
        return this.height;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Control :: getType  ░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public String getType() {
        return this.type;
    }

}
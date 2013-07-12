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

class Color {
    
    private int red, blue, green, alpha;
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Color  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Color( int red, int blue, int green ) {
        this.red = red;
        this.green = green;
        this.blue = blue;
        this.alpha = 255;
    }
    
    public Color( int red, int blue, int green, int alpha ) {
        this.red = red;
        this.green = green;
        this.blue = blue;
        this.alpha = alpha;
    }
    
    public Color( int mono ) {
        this.red = mono;
        this.green = mono;
        this.blue = mono;
        this.alpha = mono;
    }
    
    public Color( int mono, int alpha ) {
        this.red = mono;
        this.green = mono;
        this.blue = mono;
        this.alpha = alpha;
    }
    
    public Color() {
        this.red = 100;
        this.green = 100;
        this.blue = 100;
        this.alpha = 255;
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Color :: getRed  ░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public int getRed() {
        return this.red;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Color :: getGreen  ░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public int getGreen() {
        return this.green;
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Color :: getBlue  ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public int getBlue() {
        return this.blue;
    }
  
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Color :: getAlpha  ░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public int getAlpha() {
        return this.alpha;
    }
    
}
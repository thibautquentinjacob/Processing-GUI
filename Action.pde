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
   Allows GUI elements to call functions
   
   TODO
   ==============

   FIXME
   ==============

*/

import java.util.concurrent.*;

class Action implements Callable<Integer> {

    String name;
    Callable command;

    public Action( String name, Callable<Integer> command ) {
        this.name = name;
        this.command = command;
    }

    public Integer call() {
        try {
            this.command.call();
        } catch ( Exception e ) {
            println( e.toString() );
        }
        return 1;
    }

}
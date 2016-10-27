/* TNode.vala
 *
 * Copyright (C) 2016  Daniel Espinosa <esodan@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, see <http://www.gnu.org/licenses/>.
 *
 * Authors:
 *      Daniel Espinosa <esodan@gmail.com>
 */

using Gee;

/**
 * {@link Parser} implementation using libxml2 engine
 */
public class GXml.XParser : Object, GXml.Parser {
  DomDocument _document;
  public DomDocument document { get { return _document; } }

  public XParser (DomDocument doc) { _document = doc; }

  public void save (GLib.File f, GLib.Cancellable? cancellable)
   throws GLib.Error {}
  public void read (GLib.File f, GLib.Cancellable? cancellable)
  throws GLib.Error {}
  public string to_string () throws GLib.Error  { return ""; }
  public void to_stream (OutputStream stream) throws GLib.Error {}
  public void from_stream (InputStream stream) throws GLib.Error {}
  public void from_string (string str) {}
}
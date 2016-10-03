/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 2; tab-width: 2 -*- */
/*
 *
 * Copyright (C) 2016  Daniel Espinosa <esodan@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

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


public interface GXml.DomNonElementParentNode : GLib.Object {
  public abstract DomElement? get_element_by_id (string element_id) throws GLib.Error;
}

public interface GXml.DomParentNode : GLib.Object {
  public abstract DomHTMLCollection children { owned get; }
  public abstract DomElement? first_element_child { owned get; }
  public abstract DomElement? last_element_child { owned get; }
  public abstract ulong child_element_count { get; }

  public abstract DomElement? query_selector (string selectors) throws GLib.Error;
  public abstract DomNodeList query_selector_all (string selectors) throws GLib.Error;
}

public interface GXml.DomNonDocumentTypeChildNode : GLib.Object {
  public abstract DomElement? previous_element_sibling { get; }
  public abstract DomElement? next_element_sibling { get; }
}

public interface GXml.DomChildNode : GLib.Object {
  public abstract void remove ();
}


public interface GXml.DomNodeList : GLib.Object, Gee.BidirList<GXml.DomNode>  {
  public abstract DomNode? item (ulong index);
  public abstract ulong length { get; }
}

public interface GXml.DomHTMLCollection : GLib.Object, Gee.BidirList<GXml.DomElement> {
  public abstract new GXml.DomElement? get_element (int index); // FIXME: See bug #768913
  public virtual new GXml.DomElement[] to_array () {
    return (GXml.DomElement[]) ((Gee.Collection<GXml.Element>) this).to_array ();
  }
  public virtual ulong length { get { return (ulong) size; } }
  public virtual DomElement? item (ulong index) { return this.get ((int) index); }
  public virtual DomElement? named_item (string name) {
      foreach (GXml.DomElement e in this) {
          if (e.node_name == name) return e;
      }
      return null;
  }
}


/**
 * No implemented jet. This can lead to API changes in future versions.
 */
public interface GXml.DomNodeIterator {
  public abstract DomNode root { get; }
  public abstract DomNode reference_node { get; }
  public abstract bool pointer_before_reference_node { get; }
  public abstract ulong what_to_show { get; }
  public abstract DomNodeFilter? filter { get; }

  public abstract DomNode? next_node();
  public abstract DomNode? previous_node();

  public abstract void detach();
}

/**
 * No implemented jet. This can lead to API changes in future versions.
 */
public class GXml.DomNodeFilter : Object {
  // Constants for acceptNode()
  public const ushort FILTER_ACCEPT = 1;
  public const ushort FILTER_REJECT = 2;
  public const ushort FILTER_SKIP = 3;

  // Constants for whatToShow
  public const ulong SHOW_ALL = (ulong) 0xFFFFFFFF;
  public const ulong SHOW_ELEMENT = (ulong) 0x1;
  public const ulong SHOW_ATTRIBUTE = (ulong) 0x2; // historical
  public const ulong SHOW_TEXT = (ulong) 0x4;
  public const ulong SHOW_CDATA_SECTION = (ulong) 0x8; // historical
  public const ulong SHOW_ENTITY_REFERENCE = (ulong) 0x10; // historical
  public const ulong SHOW_ENTITY = (ulong) 0x20; // historical
  public const ulong SHOW_PROCESSING_INSTRUCTION = (ulong) 0x40;
  public const ulong SHOW_COMMENT = (ulong) 0x80;
  public const ulong SHOW_DOCUMENT = (ulong) 0x100;
  public const ulong SHOW_DOCUMENT_TYPE = (ulong) 0x200;
  public const ulong SHOW_DOCUMENT_FRAGMENT = (ulong) 0x400;
  public const ulong SHOW_NOTATION = (ulong) 0x800; // historical

  public delegate ushort AcceptNode(Node node); // FIXME: Should be a User defined method
}


/**
 * No implemented jet. This can lead to API changes in future versions.
 */
public interface GXml.DomTreeWalker : Object {
  public abstract DomNode root { get; }
  public abstract ulong what_to_show { get; }
  public abstract DomNodeFilter? filter { get; }
  public abstract DomNode current_node { get; }

  public abstract DomNode? parentNode();
  public abstract DomNode? firstChild();
  public abstract DomNode? lastChild();
  public abstract DomNode? previousSibling();
  public abstract DomNode? nextSibling();
  public abstract DomNode? previousNode();
  public abstract DomNode? nextNode();
}

public interface GXml.DomNamedNodeMap : Object, Gee.Map<string,DomNode> {
  public abstract ulong length { get; }
  public abstract DomNode? item (ulong index);
  public abstract DomNode? get_named_item (string name);
  public abstract DomNode? set_named_item (DomNode node) throws GLib.Error;
  public abstract DomNode? remove_named_item (string name) throws GLib.Error;
  // Introduced in DOM Level 2:
  public abstract DomNode? remove_named_item_ns (string namespace_uri, string localName) throws GLib.Error;
  // Introduced in DOM Level 2:
  public abstract DomNode? get_named_item_ns (string namespace_uri, string local_name) throws GLib.Error;
  // Introduced in DOM Level 2:
  public abstract DomNode? set_named_item_ns (DomNode node) throws GLib.Error;
}

public interface GXml.DomTokenList : GLib.Object, Gee.BidirList<string> {
  public abstract ulong   length   { get; }
  public abstract string? item     (ulong index);
  public abstract bool    contains (string token) throws GLib.Error;
  public abstract void    add      (string[] tokens) throws GLib.Error;
  public abstract void    remove   (string[] tokens);
  /**
   * If @auto is true, adds @param token if not present and removing if it is, @force value
   * is taken in account. If @param auto is false, then @force is considered; if true adds
   * @param token, if false removes it.
   */
  public abstract bool    toggle   (string token, bool force = false, bool auto = true) throws GLib.Error;
  public abstract string  to_string ();
}


/**
 * No implemented jet. This can lead to API changes in future versions.
 */
public interface GXml.DomSettableTokenList : GXml.DomTokenList {
  public abstract string @value { owned get; set; }
}
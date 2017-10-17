/* -*- Mode: vala; indent-tabs-mode: nil; tab-width: 2 -*- */
/**
 *
 *  SerializablePropertyIntTest.vala
 *
 *  Authors:
 *
 *       Daniel Espinosa <esodan@gmail.com>
 *
 *
 *  Copyright (c) 2015 Daniel Espinosa
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
using GXml;
class SerializablePropertyIntTest : GXmlTest {
  public class IntNode : SerializableObjectModel
  {
    [Description (nick="IntegerValue")]
    public SerializableInt  integer { get; set; }
    public string name { get; set; }
    public override string node_name () { return "IntNode"; }
    public override string to_string () { return get_type ().name (); }
    public override bool property_use_nick () { return true; }
  }
  public static void add_tests () {
    Test.add_func ("/gxml/serializable/Int/basic",
    () => {
      try {
        var bn = new IntNode ();
        var doc = new GDocument ();
        bn.serialize (doc);
        Test.message ("XML:\n"+doc.to_string ());
        var element = doc.root as Element;
        var b = element.get_attr ("IntegerValue");
        assert (b == null);
        var s = element.get_attr ("name");
        assert (s == null);
      } catch (GLib.Error e) {
        Test.message (@"ERROR: $(e.message)");
        assert_not_reached ();
      }
    });
    Test.add_func ("/gxml/serializable/Int/changes",
    () => {
      try {
        var bn = new IntNode ();
        var doc = new GDocument ();
        bn.serialize (doc);
        Test.message ("XML:\n"+doc.to_string ());
        var element = doc.root as Element;
        var b = element.get_attr ("IntegerValue");
        assert (b == null);
        var s = element.get_attr ("name");
        assert (s == null);
        // Change values
        bn.integer = new SerializableInt ();
        // set to 233
        bn.integer.set_value (233);
        var doc2 = new GDocument ();
        bn.serialize (doc2);
        Test.message ("XML2:\n"+doc2.to_string ());
        var element2 = doc2.root as Element;
        var b2 = element2.get_attr ("IntegerValue");
        assert (b2 != null);
        assert (b2.value == "233");
        // set to -1
        bn.integer.set_value (-1);
        var doc3 = new GDocument ();
        bn.serialize (doc3);
        Test.message ("XML3:\n"+doc3.to_string ());
        var element3 = doc3.root as Element;
        var b3 = element3.get_attr ("IntegerValue");
        assert (b3 != null);
        assert (b3.value == "-1");
        // set to NULL/IGNORE
        bn.integer.set_serializable_property_value (null);
        var doc4= new GDocument ();
        bn.serialize (doc4);
        Test.message ("XML3:\n"+doc4.to_string ());
        var element4 = doc4.root as Element;
        var b4 = element4.get_attr ("IntegerValue");
        assert (b4 == null);
      } catch (GLib.Error e) {
        Test.message (@"ERROR: $(e.message)");
        assert_not_reached ();
      }
    });
    Test.add_func ("/gxml/serializable/Int/deserialize/basic",
    () => {
      try {
        var doc1 = new GDocument.from_string ("""<?xml version="1.0"?>
                       <IntNode IntegerValue="1416"/>""");
        var i = new IntNode ();
        i.deserialize (doc1);
        Test.message ("Actual value: "+i.integer.get_serializable_property_value ());
        assert (i.integer.get_serializable_property_value () == "1416");
        Test.message ("Actual value parse: "+i.integer.get_value ().to_string ());
        int iv = i.integer.get_value ();
        Test.message ("Use from int, value:"+iv.to_string ());
        assert (i.integer.get_value () == 1416);
      } catch (GLib.Error e) {
        Test.message (@"ERROR: $(e.message)");
        assert_not_reached ();
      }
    });
    Test.add_func ("/gxml/serializable/Int/deserialize/bad-value",
    () => {
      try {
        var doc1 = new GDocument.from_string ("""<?xml version="1.0"?>
                       <IntNode IntegerValue="a"/>""");
        var i1 = new IntNode ();
        i1.deserialize (doc1);
        Test.message ("Actual value: "+i1.integer.get_serializable_property_value ());
        assert (i1.integer.get_serializable_property_value () == "a");
        Test.message ("Actual value parse: "+i1.integer.get_value ().to_string ());
        assert (i1.integer.get_value () == 0);
        var doc2 = new GDocument.from_string ("""<?xml version="1.0"?>
                       <IntNode IntegerValue="1.1"/>""");
        var i2 = new IntNode ();
        i2.deserialize (doc2);
        Test.message ("Actual value: "+i2.integer.get_serializable_property_value ());
        assert (i2.integer.get_serializable_property_value () == "1.1");
        Test.message ("Actual value parse: "+i2.integer.get_value ().to_string ());
        assert (i2.integer.get_value () == 1);
        var doc3 = new GDocument.from_string ("""<?xml version="1.0"?>
                       <IntNode IntegerValue="1a"/>""");
        var i3 = new IntNode ();
        i3.deserialize (doc3);
        Test.message ("Actual value: "+i3.integer.get_serializable_property_value ());
        assert (i3.integer.get_serializable_property_value () == "1a");
        Test.message ("Actual value parse: "+i3.integer.get_value ().to_string ());
        assert (i3.integer.get_value () == 1);
      } catch (GLib.Error e) {
        Test.message (@"ERROR: $(e.message)");
        assert_not_reached ();
      }
    });
  }
}
/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 8; tab-width: 8 -*- */
using GXml.Dom;

/* For testing, based on:
   https://live.gnome.org/Vala/TestSample

   Using an Element subclass of Node to test Node.
*/

class DomNodeTest {
	private static Document get_doc () {
		// TODO: want to create document that is empty, not from a file
		return new Document.for_path ("test.xml");
	}
	private static DomNode get_elem (string name, Document doc) {
		return doc.create_element (name);
	}
	private static DomNode get_elem_new_doc (string name) {
		return get_elem (name, get_doc ());
	}
	private static DomNode get_attr (string name, string value) {
		Document doc = new Document.for_path ("test.xml");
		Attr node = doc.create_attribute (name);
		node.value = value;

		return node;
	}

	public static void add_dom_node_tests () throws DomError {
		Test.add_func ("/gdom/domnode/node_name_get", () => {
				// TODO: should DomNodes never have a null name?
				DomNode node = get_elem_new_doc ("george");

				assert (node.node_name == "george");
			});
		Test.add_func ("/gdom/domnode/node_type_get", () => {
				// TODO: implement commented-out types

				Document doc = get_doc ();

				// Element
				DomNode node;

				node = get_elem ("a", doc);
				assert (node.node_type == NodeType.ELEMENT);

				node = doc.create_attribute ("name");
				assert (node.node_type == NodeType.ATTRIBUTE);

				node = doc.create_text_node ("some text");
				assert (node.node_type == NodeType.TEXT);

				node = doc.create_cdata_section ("cdata");
				assert (node.node_type == NodeType.CDATA_SECTION);

				node = doc.create_entity_reference ("refname");
				assert (node.node_type == NodeType.ENTITY_REFERENCE);

				// node = doc.create_entity ();
				// assert (node.node_type == NodeType.ENTITY);

				node = doc.create_processing_instruction ("target", "data");
				assert (node.node_type == NodeType.PROCESSING_INSTRUCTION);

				node = doc.create_comment ("some comment");
				assert (node.node_type == NodeType.COMMENT);

				assert (doc.node_type == NodeType.DOCUMENT);

				// node = doc.create_document_type ("");
				// assert (node.node_type == NodeType.DOCUMENT_TYPE);

				// node = doc.create_document_fragment ("");
				// assert (node.node_type == NodeType.DOCUMENT_FRAGMENT);

				// node = doc.create_notation ("some notation");
				// assert (node.node_type == NodeType.NOTATION);

			});
		Test.add_func ("/gdom/domnode/node_value_get", () => {

				/* See: http://www.w3.org/TR/DOM-Level-1/level-one-core.html */

				Document doc = get_doc ();

				DomNode node;

				node = doc.create_element ("elem");
				assert (node.node_value == null);

				node = doc.create_attribute ("name");
				((Attr)node).value = "Harry Potter";
				assert (node.node_value == "Harry Potter");

				node = doc.create_text_node ("text content");
				assert (node.node_value == "text content");

				node = doc.create_cdata_section ("cdata content");
				assert (node.node_value == "cdata content");

				node = doc.create_entity_reference ("refname");
				assert (node.node_value == null);

				// TODO: entity

				node = doc.create_processing_instruction ("target", "proc inst data");
				assert (node.node_value == "proc inst data");

				node = doc.create_comment ("some comment");
				assert (node.node_value == "some comment");

				assert (doc.node_value == null);

				/* TODO: Document Type, Document Fragment, Notation */
				// assert (attr.node_value == "harry");
				/* TODO: figure out a solution.
				   Attr's node_value doesn't get used when elem is thought of
				   as a DomNode.
				   DomNode wants to get it from DomNode's Xml.Node* node,
				   while Attr wants to get it from Attr's Xml.Attr* node. :( */
			});
		Test.add_func ("/gdom/domnode/parent_node", () => {
				Document doc = get_doc ();
				DomNode parent = get_elem ("James", doc);
				DomNode child = get_elem ("Harry", doc);

				assert (child.parent_node != parent);
				parent.append_child (child);
				assert (child.parent_node == parent);
			});
		Test.add_func ("/gdom/domnode/child_nodes", () => {
				Document doc = get_doc ();
				DomNode parent = get_elem ("Molly", doc);
				DomNode child_0 = get_elem ("Percy", doc);
				DomNode child_1 = get_elem ("Ron", doc);
				DomNode child_2 = get_elem ("Ginnie", doc);

				assert (parent.child_nodes.length () == 0);
				parent.append_child (child_0);
				parent.append_child (child_1);
				parent.append_child (child_2);
				assert (parent.child_nodes.length () == 3);
				assert (parent.child_nodes.nth_data (0) == child_0);
				assert (parent.child_nodes.nth_data (2) == child_2);
			});
		Test.add_func ("/gdom/domnode/first_child", () => {
			});
		Test.add_func ("/gdom/domnode/last_child", () => {
			});
		Test.add_func ("/gdom/domnode/previous_sibling", () => {
			});
		Test.add_func ("/gdom/domnode/next_sibling", () => {
			});
		Test.add_func ("/gdom/domnode/attributes", () => {
			});
		Test.add_func ("/gdom/domnode/owner_document", () => {
			});
		Test.add_func ("/gdom/domnode/insert_before", () => {
			});
		Test.add_func ("/gdom/domnode/replace_child", () => {
			});
		Test.add_func ("/gdom/domnode/remove_child", () => {
			});
		Test.add_func ("/gdom/domnode/append_child", () => {
			});
		Test.add_func ("/gdom/domnode/has_child_nodes", () => {
			});
		Test.add_func ("/gdom/domnode/clone_nodes", () => {
			});

	}
}

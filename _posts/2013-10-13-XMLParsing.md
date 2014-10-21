---
layout: post
title: XML file parsing in C++
permalink: xml-file-parsing-cpp.html
description: XML files are widely used today so it is great to know how to parse them. One good XML file parsing library is rapidxml. It is distributed as a collection of header files and can be downloaded from it's official site.
tags: [c++, xml, rapidxml, parsing]
keywords: c++, xml, rapidxml, parsing
categories: [c++]
---

## Introduction

XML files are widely used today so it is great to know how to parse them.

One good XML file parsing library is *rapidxml*.
It is distributed as a collection of header files and can be downloaded from it's [official site](http://rapidxml.sourceforge.net/).

## Getting started

So, lets start. First, we'll just read the contents of the simplest ever xml file:

{% highlight xml linenos %}
<?xml version="1.0" encoding="utf-8"?>
<root>
    <node1>
        Contents of node 1
    </node1>
</root>
{% endhighlight %}

Open your favourite text editor or IDE and let's do some coding:

{% highlight cpp linenos %}

    #include <iostream>

    #include "rapidxml/rapidxml.hpp"
    #include "rapidxml/rapidxml_utils.hpp"

    using namespace rapidxml;
    using namespace std;

    int main(void)
    {
        xml_document<> doc; //create xml_document object
        file<> xmlFile("sample.xml"); //open file
        doc.parse<0>(xmlFile.data()); //parse the contents of file
        xml_node<>* root = doc.first_node("root");//find our root node
        xml_node<>* node1 = root->first_node("node1"); //find our node1 node

        cout << node1->value() << "\n"; //print node1 value

        return 0;
    }
{% endhighlight %}

## Compiling

To compile your source under Debian or other Debian-like Linux distro first make sure __g++__ package is installed:
{% highlight bash %}
$sudo apt-get install g++
{% endhighlight %}

After that you can compile your source:

{% highlight bash %}
$g++ -o rapidxml_demo rapidxml_demo.cpp
{% endhighlight %}

To run the executable type:

{% highlight bash %}
$./rapidxml_demo
{% endhighlight %}

The output should be something like that:

    Contents of node 1

## Writing XML file


Except parsing *rapidxml*  features writing in XML format. So, let's look on another example:

{% highlight cpp linenos %}

#include <string>
#include <iostream>
#include <fstream> //for file output
#include <iterator>//for std::back_inserter

#include "rapidxml/rapidxml.hpp"

#include "rapidxml/rapidxml_print.hpp"


using namespace std;


int main(void)
{
 rapidxml::xml_document<> doc;
 ofstream out("sample2.xml");

 // xml declaration node
 rapidxml::xml_node<>* decl = doc.allocate_node(rapidxml::node_declaration); //allocate default xml declaration node
 //apppend special attributes to it
 decl->append_attribute(doc.allocate_attribute("version", "1.0"));
 decl->append_attribute(doc.allocate_attribute("encoding", "utf-8"));
 doc.append_node(decl); //finally, append node

 //allocate root node
 rapidxml::xml_node<>* root = doc.allocate_node(rapidxml::node_element,"root"); //node element is the type of node
 doc.append_node(root);


 //node1
 rapidxml::xml_node<>* node1 = doc.allocate_node(rapidxml::node_element,"node1");
 node1->value("Contents of node1");
 root->append_node(node1);

 //root2
 rapidxml::xml_node<>* root2 = doc.allocate_node(rapidxml::node_element,"root2");
 root2->value("Contetns of root2");
 doc.append_node(root2);


 string xml_as_string;
 rapidxml::print(back_inserter(xml_as_string), doc);//print formatted XML to a string

 out<<xml_as_string;
 out.close();

 return 0;
}
{% endhighlight %}

If you compile this you will have quite a lot compile errors.
That is because of specific behavior of newer versions of g++.
In order to fix the problem add the following code in the *rapidxml_print.hpp* file on line 31:

{% highlight cpp linenos %}

 template<class OutIt, class Ch>
 inline OutIt print(OutIt out, const xml_node<Ch> &amp;node, int flags = 0);
 template<class OutIt, class Ch>
 inline OutIt print_node(OutIt out, const xml_node<Ch> *node, int flags, int indent);
 template<class OutIt, class Ch>
 inline OutIt print_children(OutIt out, const xml_node<Ch> *node, int flags, int indent);
 template<class OutIt, class Ch>
 inline OutIt print_element_node(OutIt out, const xml_node<Ch> *node, int flags, int indent);
 template<class OutIt, class Ch>
 inline OutIt print_data_node(OutIt out, const xml_node<Ch> *node, int flags, int indent);
 template<class OutIt, class Ch>
 inline OutIt print_cdata_node(OutIt out, const xml_node<Ch> *node, int flags, int indent);
 template<class OutIt, class Ch>
 inline OutIt print_declaration_node(OutIt out, const xml_node<Ch> *node, int flags, int indent);
 template<class OutIt, class Ch>
 inline OutIt print_comment_node(OutIt out, const xml_node<Ch> *node, int flags, int indent);
 template<class OutIt, class Ch>
 inline OutIt print_doctype_node(OutIt out, const xml_node<Ch> *node, int flags, int indent);
 template<class OutIt, class Ch>
 inline OutIt print_pi_node(OutIt out, const xml_node<Ch> *node, int flags, int indent);

{% endhighlight %}

This will make the internal rapidxml functions visible to g++.
Now compile the code, run and look at the file generated.
The contents of *sample2.xml* should be like this:

{% highlight xml lineos %}

<?xml version="1.0" encoding="utf-8"?>
<root>
<node1>Contents of node1</node1>
</root>
<root2>Contetns of root2</root2>

{% endhighlight %}

At this point you are able to write and read XML files.
If you have any questions feel free to contact me.

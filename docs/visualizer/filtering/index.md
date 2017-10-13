---
layout: page
title: Filtering for Packets, Interfaces, and Nodes
hidden: true
---

## Goals

There are several visualizer types in INET, suitable for visualizing
many different aspects of network simulations. In general, all
visualizer types create their visualizations in the entire network by
default, and visualize all transmissions, packets, etc. This can make
the visuali
format string: used to customize how information is displayed
zation cluttered in many cases.

However, the extent of visualizations can be narrowed to increase
clarity. Most visualizers have various filters, which can be set by NED
parameters from the ini file. For example, one can set filters to
visualize only certain kinds of packets, at certain nodes.

This showcase demonstrates with examples the filtering features
available in many visualizer modules.

INET version: `3.6`<br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/filtering" target="_blank">`inet/showcases/visualizer/filtering`</a>

## Filter Types in Visualizers

There are five types of filters, and different visualizers feature a
different subset of the five types. The filters are specified by setting
the visualizers' filtering parameters. It is possible to filter for the
following objects:

-   Network nodes
-   Interfaces
-   Modules
-   Packets
-   Ports

## Filter Expressions

The filters use the cMatchExpression class internally (more information
in the OMNeT++ manual). They take an expression string, which can have
elements in the form of `fieldName(value)`. The objects which
match this expression will be considered in the visualization. It is
possible to write a single value without the parentheses. In this case,
the value will be matched against the object's default field, which is
usually its name.
format string: used to customize how information is displayed
 Thus the following two expressions are equivalent:

``` {.snippet}
interfaceFilter = "name(eth*)"
interfaceFilter = "eth*"
```

The expressions can contain regexp-like elements: the `'*'` stands for
any sets of characters, except for a `'.'` (`'**'` stands for any
characters including the `'.'`). A `'?'` stands for one character. It is
also possible to use the `AND`, `OR`, `NOT` boolean operators (case
insensitively). Parentheses can also be used to change the evaluation
order. For example:

``` {.snippet}
packetFilter = "*tcp* and not(*SYN* or *ACK*)"
```

This matches packets that have 'tcp' in their names, but doesn't match
packets with SYN or ACK in their names, basically selecting TCP packets
with a payload data, and excluding ACKs and handshake packets.

TODO: how it is used in visualizers. e.g. someVisualizer.packetFilter =
foo

TODO: you can filter for the fields in the inspector panel, and any
fields in the tree

In the following sections, we give a few example filter expressions for
each filter type.

## Packet filter

-   Packets sent with databitrate (as opposed to controlbitrate), thus
    excluding ACKs. Also, only packets whose protocol is not ICMP:

    <p><div class="snippet">
    "bitrate(54Mbps) and not protocol(ICMP)"
    </div></p>

-   Packets that are TCP payload packets, not ACKs or part of the
    handshake:

    <p><div class="snippet">
    "*tcp* and not(*ACK* or *SYN*)"
    </div></p>

-   Packets that are in a size range:

    <p><div class="snippet">
    "byteLength({2000..1000000})"
    </div></p>

-   Packets carried by radio frames with a transmission power above a
    certain level:

TODO: is it ok like this ?

<!--
What do i want to say in here ?

- there are 5 types of filters in visualizers: network node, node, packet, interface and port
- some visualizers have parameters that are these
- they take an expression ?

They are using cMatchExpression ... is that needed ?

Examples for the 5 filter types, with 3 or 4 examples each

Some examples:

nodeFilter: where componentType.name(StandardHost) and hasIP(192.168.0.*) ?

want to select nodes that has a certain IP and



<!--
What do i want to say here?

That the visualizations in inet tipically, by default, visualize a certain aspect of the simulation
in the entiry network, at all nodes, and all packets are visualized. The scope of the visualization
can be narrowed, by filtering for nodes, network nodes, packets, interfaces, and ports.
There are 5 types of filters, and different visualizers feature a different subset of the 5 types.

Programmatically, they are xyz. Sometimes they are not called that. Is this even needed?
--> <!--
There are filtering features that are available in many visualizers
one can filter for packets, interfaces, network nodes, modules and ports. These are the kinds that are available.
The filtering narrows the scope of the visualization for clarity. In general, these kinds are available,
but sometimes they are not called that. For example, there is the sourceFilter in xy visualizer, but it is essentially
a nodeFilter.

filters can have expressions...one can filter for the stuff that is in the inspector panel
so something like...visualize transmissions whose someField = someValue

for example, wanna visualize transmissions that have a bitrate of 24Mbps and 6Mbps

packetFilter = bitRate(24Mbps) OR bitrate(6Mbps) AND NOT packetname(ICMP)

this would visualize 24mbps and 6mbps transmissions that are not icmp messages
-->

## Discussion

Use <a href="TODO" target="_blank">this page</a>
in the GitHub issue tracker for commenting on this showcase.

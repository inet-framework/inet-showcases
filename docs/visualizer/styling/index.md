---
layout: page
title: Styling and Appearance
---

<script type="text/javascript">
  function swapImage(id,before,after) {
    src=document.getElementById(id).src;
    if (src.match(before)) {
      document.getElementById(id).src=after;
    } else {
      document.getElementById(id).src=before;
    }
  }
</script>

## Goals

In INET simulations, multiple visualizers are used often simultaneously and some
of them have similar default look.  As a result of this, the simulation can become
confusing. INET offers many customization options to make it easier to distinguish
visualizers or to highlight them. Several visualizers have similar options to make
customization easier.

This showcase consists of four examples which demonstrates how to customize
lines, arrows, icons, fonts and annotations.

INET version: <var>3.6</var><br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/styling" target="_blank"><var>inet/showcases/visualizer/styling</var></a>

## Customizing Lines and Arrows

In INET simulations, links and and packet paths are visualized as arrows. When
many links and paths are visualized in the simulation, it can be difficult to
examine the links or paths we are interested in. In this case, arrow customization
can be useful.

A simulation is created for this example. The simulation can be run by selecting
the <var>Line</var> configuration from the ini file.

The network consists of two <var>AdhocHost</var> type nodes,
<var>host1</var> and <var>host2</var>. In this example, we customize data link
activity arrow.

The following configuration is used to customize the visualizer's settings.

``` {.snippet}
*.visualizer.*.dataLinkVisualizer.lineColor = "blue"
*.visualizer.*.dataLinkVisualizer.lineStyle = "dashed"
*.visualizer.*.dataLinkVisualizer.lineWidth = 6
*.visualizer.*.dataLinkVisualizer.lineContactSpacing = 15
*.visualizer.*.dataLinkVisualizer.lineShift = 32
```

Click image to see the differences between the default and the customized visualization.

<img id="lineImg" onclick="swapImage('lineImg','Line_default_v0727.png','Line_custom_v0727.png')" src="Line_default_v0727.png" class="screen" />

Line color can be set to a single color. The color's name or its RGB value can be
used. At <var>NetworkRouteVisualizer</var>,
<var>TransportRouteVisualizer</var> and <var>MobilityVisualizer</var>, line color
can be set also to a list of colors. The list of colors can be set by using the *"dark"*
or *"light"* keywords or by enumerating the colors separated by commas.<br>
The <var>lineStyle</var> parameter can be set to *"solid"*, *"dotted"* or
*"dashed"*.<br> Line width is represented by a number. The bigger the number,
the thicker the line.<br> If there are multiple lines between the same nodes, the
space between the lines can be changed by adjusting the <var>lineShift</var>
parameter. The bigger the number, the larger the space between the lines.<br>
We can adjust the space between the end of the of the arrow and the network
node by setting the <var>lineContactSpacing</var> parameter. The bigger the
number, the larger the space.

## Customizing Fonts

On lines and arrows, there is often a label that displays information about the
visualization. By customizing fonts used in labels you can highlight important
information about the visualization.

A simulation is created for this example, it can be run by choosing the
<var>Font</var> configuration from the ini file.

The network contains two <var>AdhocHost</var> type nodes, <var>host1</var>
and <var>host2</var>. In this example, we customize fonts used in labels on
data link activity arrow.

<!-- Question: all labels can be disabled? -->
Labels are enabled by default. To customize fonts used in labels, we set
<var>DataLinkVisualizer</var> as follows. (Labels can be disabled by setting the
<var>displayLabels</var> parameter to false.)

``` {.snippet}
*.visualizer.*.dataLinkVisualizer.labelFont = "Courier New, 12px, bold"
*.visualizer.*.dataLinkVisualizer.labelColor = "red"
```

Click the image to see the differences between the default and the customized visualization.

<img id="fontsImg" onclick="swapImage('fontsImg','Font_default_v0727.png','Font_custom_v0727.png')" src="Font_default_v0727.png" class="screen" />

Font family, font size and font style can be set by using the <var>labelFont</var>
parameter. You can omit any value from the parameter, if you do not want to
change that value. For example, you can set <var>labelFont</var> to *"bold"* so
that font family and font size remain unchanged.<br> The
<var>labelColor</var> parameter can be set to a single color by using the color's name
or the color's RGB value.

At <var>InterfaceTableVisualizer</var> and <var>StatisticVisualizer</var>, the
<var>font</var> parameter is used instead of <var>labelFont</var>, and
<var>textColor</var> is used instead of <var>labelColor</var>.

## Customizing Icons

If you want to highlight an icon because it is crucial for your simulation, you can
customize its appearance.

The following example shows how to customize icon appearance in INET. A
simulation is created for this example, that can be run by choosing the
<var>Icon</var> configuration from the ini file.

The simulation contains two nodes, <var>host1</var> and <var>host2</var>.
Nodes are of the type <var>AdhocHost</var>. In this simulation, we use
<var>TransportConnectionVisualizer</var>.

We use the following configuration to customize the transport connection icon.

``` {.snippet}
*.visualizer.*.transportConnectionVisualizer.icon = "another_marker"
*.visualizer.*.transportConnectionVisualizer.iconColor = "light"
```

Click image to see the differences before and after the customization.

<img id="iconImg" onclick="swapImage('iconImg','Icon_default_v0727.png','Icon_custom_v0727.png')" src="Icon_default_v0727.png" class="screen" />

In the <var>icon</var> parameter, the path of the icon can be set. For this
simulation, we use the *another\_marker* png image from the *inet/images/*
folder. In INET, this folder is the default location for images so it is not necessary
to write to the <var>icon</var> parameter.<br> The <var>iconColor</var>
parameter can be set to a single color or to a list of colors. A single color can be set
by using the color's name e.g. *"blue"* or by using the color's RGB value e.g.
*"\#0000FF"*. A list of colors can be set by enumerating the colors, for example
*"green, yellow, red"* or the list can be set also to a set of *"dark"* or a set of
*"light"* colors.

At <var>LinkBreakVisualizer</var> and <var>PacketDropVisualizer</var>, icon
color can be set by using the <var>iconTintColor</var> parameter instead of the
<var>iconColor</var> parameter. However, note, that <var>iconTintColor</var>
can be set only to a single color. These visualizers also have an
<var>iconTintAmount</var> parameter. By adjusting <var>iconTintAmount</var>, the
colorization amount of the icon can be adjusted between zero and one. If we set
the parameter to zero, the icon will not be tinted at all. If the parameter is set to
one, the icon will be tinted fully.

## Displacing Annotations

When many annotations are placed in the same position around the node, the
simulation can be confusing. By displacing annotations, you can make the
simulation more understandable.

The following example shows how to displace annotations around network nodes.
A simulation is created for this example, it can be run by selecting the
<var>Annotation</var> configuration from the ini file.

Nodes are type of <var>WirelessHost</var>. In this simulation,
<var>TransportConnectionVisualizer</var> and <var>Ieee80211Visualizer</var> are
used (as a part of <var>IntegratedVisualizer</var>).

We use the following configuration to displace annotations.

``` {.snippet}
*.visualizer.*.transportConnectionVisualizer.displacementHint = "bottom"
```

Click image to see the differences between the default and the customized visualization.

<!--TODO: images -->
<img id="annotImg" onclick="swapImage('annotImg','Annotation_default_v0802.png','Annotation_custom_v0802.png')" src="Annotation_default_v0802.png" class="screen" />

<!-- TODO: explanation -->
The annotations can be placed in eight directions around the node: *topCenter,
left, right, bottomCenter, topLeft, topRight, bottomLeft, bottomRight*. Using the
<var>displacementHint</var> parameter, we can determine where the
annotations will be placed. The parameter has an additional option: *any*. If
*any* is set, annotations will be placed automatically as close as possible to the
node. We can determine the order of annotation positioning by using the
<var>displacementPriority</var> parameter. Zero is the largest priority.

## More Information

For more information refer the visualizers' ned documentations.

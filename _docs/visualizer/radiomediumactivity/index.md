---
layout: page
title: Visualizing Radio Medium Activity
hidden: true
---

TODO: rename
github discussion link
github discussion

## Goals

In a large network, there might be multiple wireless nodes transmitting
simultaneously, resulting in interference at receiving nodes, and
incorrecly received packets. The logs contain the clues as to what
happened to various packets, but scanning through the logs is tedious.

INET contains support for visualizing radio signals as they propagate
through space, making it easy to see which nodes are transmitting and
which are receiving at any given time, and what signals are
present at various nodes.

This showcase contains three configurations of increasing complexity,
each showing different features of the visualization.

INET version: `3.6`<br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/radiomediumactivity" target="_blank">`inet/showcases/visualizer/radiomediumactivity`</a>

## About the visualizer

The `MediumVisualizer` module (included in the networks for this showcase as part
of `IntegratedVisualizer`) can visualize various aspects of
radio communications. `MediumVisualizer` has the following three main features,
and boolean parameters for turning them on/off:

-   **Visualization of propagating signals**: Signals are visualized as animated
disks (`displaySignals` parameter)
-   **Indication of transmitting and receiving nodes**: Icons are placed above nodes
when they are transmitting or receiving (`displayTransmissions` and `displayReceptions` parameters)
-   **Displaying communication and interference ranges**: Ranges are displayed as circles around nodes
`displayCommunicationRanges` and `displayInterferenceRanges` parameters)

The features above will be described in more detail in the following sections.
The scope of the visualization can be adjusted with parameters as well.
By default, all packets, interfaces and nodes are considered for the
visualization. The selection can be narrowed with the visualizer's
`packetFilter`, `interfaceFilter`, and
`nodeFilter` parameters. Note that one `MediumVisualizer` module can only visualize
signals of one radio medium module. For visualizing multiple radio medium modules,
multiple `MediumVisualizer` modules are required.

## Displaying signal propagation, transmissions and receptions

In the example simulation for this section, we enable visualization of propagating signals,
displaying communication/interference ranges, and transmission/reception indication.
We demonstrate the visualization with the visualizer's default settings.
The simulation can be run by choosing the `DisplayingPropagationTransmissionsReceptions`
configuration from the ini file. The simulation uses the following network:

<img class="screen" src="simplenetwork.png">

The playground size is about 900x600 meters.
The network contains two `WirelessHosts`. `host1` is
configured to send UDP packets to `host2`. Displaying of
transmissions and receptions, propagating signals, communication and
interference ranges are enabled with the following visualizer settings:

```
*.visualizer.*.mediumVisualizer.displaySignals = true
*.visualizer.*.mediumVisualizer.displayReceptions = true
*.visualizer.*.mediumVisualizer.displayTransmissions = true
*.visualizer.*.mediumVisualizer.displayCommunicationRanges = true
*.visualizer.*.mediumVisualizer.displayInterferenceRanges = true
```

When the simulation is run the network looks like this:

<img class="screen" src="simple.png" width="850px">

Parts of the communication range circles are visible in the image.
With the current radio settings, the interference ranges are much larger than the communication ranges.
One has to zoom out for them to be visible:

<img class="screen" src="interferencerange.png">

The communication and interference ranges are estimated for each node, from the node's
maximum transmitter power and the lowest receiver sensitivity setting in the network.
The communication range represents the "best case" for signal reception
(i.e. the range in which a signal would be correctly receivable by the most sensitive
receiver in the network, if the given node transmitted with its maximum transmitter power.)
Transmissions are not correctly receivable beyond the communication range,
but this does not imply that they are always correctly receivable in range.
The interference range is similarly calculated from the maximum transmission power of the node,
but it takes the minimum interference sensitivity level of all receivers in the network into account.
As the communication range, the interference range is an estimation, and means that signals beyond
the interference range don't cause reception errors due to interference
(note that this is an optimization.)

The following video illustrates the visualization of propagating signals:

<p><video autoplay loop controls src="propagation9.mp4" onclick="this.paused ? this.play() : this.pause();" width="852" height="591"></video></p>

The `host1` sends an ARP request packet to `host2`,
which sends an ARP reply. The `host1` ACKs it, then sends the
first UDP packet. This is followed by `host2's` ACK. The transmissions
are visualized with animated disks. The disk have an opacity gradient,
which correlates with the decrease in signal power as the distance from
the transmitter increases. The opacity indicates how strong the signal is compared to
the maximum power near the transmitter (but not compared to other signals.)
The blue transmission indicator icons are displayed
above nodes when they are transmitting. Similarly, the red reception indicators
are displayed above them when they are receiving. The transmission power and power of
the received signal is indicated on the transmission/reception icons in
dBW. Note that the reception indicator icon is display even when the
receiving node cannot receive the transmission correctly.
(The reception icons are placed above nodes when there is a signal present at the
location of the node. It does not imply that the signal is receivable or that the node
attempts reception. Basically the icon is displayed above all nodes that use the
same radio medium module.)

(The `RadioVisualizer` module can be used for displaying radio states,
including when the radio is idle, sensing a signal, attempting reception, etc.)

### The propagating signal

Regarding the visualization of radio signals, the density of interesting events varies
on the simulation time scale. For example, we would like to visualize radio signals
in a wifi network. The nodes are placed about 100 meters apart. When the signal starts
propagating, it quickly reaches all nodes in the network, in about a few microseconds.
The duration of the transmission is in the order of a few hundred microseconds
(potentially up to milliseconds.) The visualizer changes the simulation speed,
so that events that happen quickly don't appear to be so fast as not to be observable
(e.g. a signal's edge propagating from a node), and other events that take longer
on the timescale don't appear to be slow and boring (e.g. the duration of a radio frame.)
When there is a signal boundary (either at the beginning or at the end of a transmission)
travelling on the playground, the simulation is slowed down, and the rippling wave pattern
is visible as the signal is propagating. When the signal is "everywhere" on the playground,
i.e. its "first bit" has travelled past the farthest node, but its last bit has not been
transmitted yet, the simulation is faster (the ripples are no longer visible,
because of the increased simulation speed.)

The following three images illustrate that generally there are three different phases
of signal propagation animation. The first is "expansion"; it starts when the signal's
"first bit" begins propagating from the transmitter node, and lasts until the "first bit"
has travelled past the node farthest from the transmitter. In this phase, the simulation
slows down. The second one is "presence"; it's when the signal is "present" on the
entire playground, at all nodes, and the simulation speeds up. The third one is "recession";
it starts when the signal's "last bit" begins receding from the transmitter node,
and lasts until the "last bit" has travelled past the farthest node. In this phase,
the simulation slows down again. The transition between the two simulation speeds is smooth.

<img class="screen" src="phases.png">

Also, it can happen that the simulation doesn't slow down, because the signal's
"last bit" gets transmitted before its "first bit" leaves the farthest node
(basically, the signal looks like a thin ring.) Such a situation can happen
if the transmission is very short, or if there are large distances between nodes,
e.g. a few kilometers.

By default, the animation of all three phases have a duration of 1 second,
wall clock time. Thus, as per the default settings, all signal propagation animations
have a duration of 3 seconds, regardless of their actual simulated duration.
To make the visualization more realistic, the visualizer's animation speeds need to be set.
When the animation speeds are set, the signal propagation animation becomes proportional
to the transmission's actual duration, thus transmission durations of packets can be compared
(e.g. a smaller packet's transmission animation takes less time than that of a larger packet.)
The animation settings can be configured with the visualizer's parameters,
more on this in the next section.

## Multiple nodes

This section describes the propagation animation settings of the visualizer.
The example simulation for this section contains three nodes as opposed to two
in the previous one, and the visualizer's animation speeds are specified
for more realistic, proportional animation durations.
The example simulation can be run by choosing the `MultipleNodes` configuration
from the ini file.

### Animation speed

The simulation speed during signal propagation animation is determined by the
visualizer's animation speed parameters. The two parameters are
`signalPropagationAnimationSpeed` and
`signalTransmissionAnimationSpeed` (not specified by default).
The propagation animation speed pertains to the expansion/recession phase,
when a signal boundary is propagating on the playground. The transmission animation speed
refers to the presence phase, when no signal boundary is visible.
If no value is specified for these parameters, the `signalPropagationAnimationTime` and
`signalTransmissionAnimationTime` parameters take effect. These parameters
set a fixed duration for the corresponding phases of the transmission
animation (this is the default setting, and both parameters are 1 second).
When the duration is fixed, all transmission animations take the same amount of time,
and NOT proportional to their actual duration. A rule of thumb for setting the
animation speed parameters is given with the following example (assumes a wifi network
with typical node distances):

-   Setting the propagation animation speed to 300/c, where c is the
speed of light, results in the animation speed value of 10<sup>-6</sup>, and
the animation of the propagating signal traveling 300 meters on the
playground in one second (when the playback speed is set to 1.)
-   The transmission animation speed should be about two magnitudes
larger, as the time it takes for the propagating signal to reach the
node farthest from the transmitter is two magnitudes smaller than
the time it takes to transmit the signal. Thus in this example, it
should be about 10<sup>-4</sup>.

The speed of the signal animation can be adjusted at runtime with the
playback speed slider.

By default, the animation switches from the expansion phase to
presence phase when the propagating signal reaches the node farthest
from the signal source. The `signalPropagationAdditionalTime`
parameter can specify how long to continue the expansion/recession animation
after the edge of the signal has left the farthest node, to avoid flickering
and rapid changes in the animation.

### The configuration

The example configuration for this section uses the following network:

<img class="screen" src="multiplenodesnetwork.png">

The playground size is 1000x500 meters.
The network contains three `AdhocHosts`. The `source` is
configured to ping the `destination`. The communication ranges
are configured so that hosts can reach only the adjacent hosts. The
center host is configured to relay packets between the hosts on the two sides.

To demonstrate that the animation duration is proportional to the real duration of the transmissions,
`relay` is configured to use 24 Mbps bitrate when transmitting, while the other hosts will use 54Mbps.

The visualizer's configuration keys are the following:

```
*.visualizer.*.mediumVisualizer.signalPropagationAnimationSpeed = 500/3e8
*.visualizer.*.mediumVisualizer.signalTransmissionAnimationSpeed = 50000/3e8
*.visualizer.*.mediumVisualizer.displaySignals = true
*.visualizer.*.mediumVisualizer.displayTransmissions = true
*.visualizer.*.mediumVisualizer.displayReceptions = true
```

The visualization of propagating radio signals is turned on.
The animation speed for the expansion and recession specified so that the expanding signal
will travel 500 meters per second on the playground.
The indication of transmitting and receiving nodes are also turned on. The communication and
interference range circles are not enabled in this simulation; the following screenshot
illustrates where the communication range circles would be if they were enabled:

<img class="screen" src="relay_ranges.png">

When the simulation is run, this happens:

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" src="MultipleNodes14.mp4"></video></p>
<!--internal video recording, animation speed none, playback speed 1.00-->

The video above depicts a UDP packet from `source` as it makes its way to
`destination`. When a node starts to transmit a frame, the simulation is slower
than during the propagation phase. As per the parameters, the transmission travels 500 meters
per second on the playground. The animation durations of the transmissions are different for certain
packets. The UDP packet transmission from `relay` takes more time than the one from `source` because
of the different bitrate. Transmission of the ACKs are the shortest, because they are smaller packets.
(Even though though they are transmitted with the slower control bitrate, instead of data bitrate.)

## Interfering signals

This configuration demonstrates how the visualization of interfering
signals looks like. It uses the following network:

<img class="screen" src="interferencenetwork.png" width="850px">

The playground size is 1000x500 meters.
The network contains three `AdhocHosts` laid out in a chain, just like
in the previous configuration. The hosts on the two sides,
`source1` and `source2`, are configured to ping the
host in the middle, `destination`. There is a wall positioned
between the two hosts on the sides. The obstacle loss model is
`IdealObstacleLoss`, thus the wall blocks transmissions
completely. Both source hosts can reach the destination, but cannot
reach each other, and cannot detect whatsoever when the other source is
transmitting. Thus the collision avoidance mechanism can't work
effectively.

Here is what happens when the simulation is run:

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" src="interference.mp4" width="819" height="472"></video></p>

The two sources can't detect each other's transmission, but they receive
the ACKs and ping replies of the destination. This helps with collision
avoidance, but they often transmit simulataneously. When they do, both
signals are present at the destination concurrently, visualized by the
transmission disks overlapping. Since both sources are in communication
range with the destination, the simulatenous transmissions result in
collisions.

The simulation slows down whenever there is a signal boundary propagating on
the playground, even when there is also a signal with no boundary present.
Such is the case in the above video. `source1` starts transmitting,
and the signal edge is propagating. When it reaches the farthest node,
`source2`, the signal is present on the entire playground, and the simulation speeds up.
When `source2` starts transmitting, the simulation slows down again,
despite that `source1`'s signal is still present on the entire playground.

Generally, several signals being present at a receiving node doesn't necessarily
cause collision. One of the signals might not be strong enough to garble
the other transmission.

## More information

For further information, refer to the `MediumVisualizer` NED
documentation.

## Discussion

Use <a href="TODO"
target="_blank">this page</a> in the GitHub issue tracker for commenting on
this showcase.

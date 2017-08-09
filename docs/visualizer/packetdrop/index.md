---
layout: page
title: Visualizing Packet Drops
---

## Goals

Several network problems manifest themselves as excessive packet drops, for
example poor connectivity, congestion, or misconfiguration. Visualizing packet
drops helps identifying such problems in simulations, thereby reducing time
spent on debugging and analysis. Poor connectivity in a wireless network can
cause senders to drop unacknowledged packets after the retry limit is exceeded.
Congestion can cause queues to overflow in a bottleneck router, again resulting in
packet drops.

This example contains several simulation models demonstrating typical causes of
packet drops.

INET version: `3.6`<br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/packetdrop" target="_blank">`inet/showcases/visualizer/packetdrop`</a>

## About the visualizer

Packet drops can be visualized by including a `PacketDropVisualizer`
module in the simulation. The `PacketDropVisualizer` module
indicates packet drops by displaying an animation effect at the node where the
packet drop occurs. In the animation, a packet icon gets thrown out from the node
icon, and fades away.

The visualization of packet drops can be enabled with the visualizer's
`displayPacketDrops` parameter. By default, packet drops at all nodes are
visualized. This selection can be narrowed with the `nodeFilter`,
`interfaceFilter` and `packetFilter` parameters.

One can click on the packet drop icon to display information about the packet
drop in the inspector panel.

Packets are dropped for the following reasons:

* queue overflow
* retry limit exceeded
* unroutable packet
* network address resolution failed
<!--li>packet lifetime expired</li-->
* interface down
<!--li>fragmentation reassebly failed</li-->
<!--li>duplicate packet</li-->
<!--li>incorrect checksum</li-->
<!--li>frame not addressed to receiver</li-->

<!--
TODO:
The color of the icon indicates the reason for the packet drop
-->

## Queue overflow

In this section we present an example for demonstrating packet drops due to queue overflow.
This simulation can be run by choosing the `QueueFull` configuration from the ini file.
The network contains a bottleneck link where packets will be dropped due to an overflowing queue:

<img class="screen" src="queuefullnetwork.png">

It contains a `StandardHost` named `source`, an
`EtherSwitch`, a `Router`, an `AccessPoint`, and a
`WirelessHost` named `destination`. The
`source` is configured to send a stream of UDP packets to
`destination`. The packet stream starts at two seconds, after
`destination` got associated with the access point. The `source`
is connected to the `etherSwitch` via a high speed, 100 Gbit/s
ethernet cable, while the `etherSwitch` and the `router` is
connected with a low speed, 10 MBit/s cable. This creates a bottleneck in the
network, between the switch and the router. The source host is configured to
generate more UDP traffic than the 10Mbit/s channel can carry. The cause of
packet drops in this case is that the queue in `etherSwitch` fills up.

The queue types in the switch's ethernet interfaces are set to
`DropTailQueue`, with a default length of 100 packets (by default, the
queues have infinite lengths). The packets are dropped at the ethernet queue of
the switch.

The visualization is activated with the `displayPacketDrops`
parameter. The fade out time is set to three seconds, so that the packet drop
animation is more visible:

``` {.snippet}
*.visualizer.*.packetDropVisualizer.displayPacketDrops = true
*.visualizer.*.packetDropVisualizer.fadeOutTime = 3s
```

When the simulation is run, the UDP stream starts at around two seconds, and
packets start accumulating in the queue of the switch. When the queue fills up,
the switch starts dropping packets. This is illustrated in this animation:

<p><video autoplay="" loop="" controls="" onclick="this.paused ? this.play() : this.pause();" src="packetdrop4.mp4" width="628" height="260"></video></p>

Here is the queue in the switch's eth1 interface, showing the number of packet drops:

<img class="screen" src="ethqueue.png">

This log excerpt shows the packet drop:

<img class="screen" src="log_queuefull_3.png">

## ARP resolution failed

In this example, a host tries to ping a non-existent destination. The configuration
for this example is `ArpResolutionFailed` in the ini file. Packets will be
dropped because the MAC address of the destination cannot be resolved. The
network for this configuration is the following:

<img class="screen" src="arpfailednetwork.png">

It contains only one host, an `AdhocHost`.

The host is configured to ping the IP address 10.0.0.2. It will try to resolve the
destination's MAC address with ARP. Since there are no other hosts, the ARP
resolution will fail, and the ping packets will be dropped.

The following animation illustrates this:

<p><video id="vid" autoplay loop controls onclick="this.paused ? this.play() : this.pause();" src="packetdrop18.mp4" width="366" height="386"></video></p>

This excerpt shows this in the log:

<img class="screen" src="log_arpfailed_2.png">

## MAC retry limit reached

In this example, packet drops occur due to two wireless hosts trying to
communicate while out of communication range. The simulation can be run by
selecting the `MACRetryLimitReached` configuration from the ini file.
The configuration uses the following network:

<img class="screen" src="maclimitnetwork.png">

It contains two `AdhocHosts`, named `source` and
`destination`. The hosts' communication ranges are set up so they are out of
range of each other. The source host is configured to ping the destination host.
The reason for packet drops in this case is that the hosts are not in range, thus
they can't reach each other. The `source` transmits the ping packets,
but it doesn't receive any ACK in reply. The `source's` MAC module
drops the packets after the retry limit has been reached.

This is illustrated in the following animation:

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" src="packetdrop14.mp4" width="512" height="385"></video></p>

This looks like the following in the logs:

<img class="screen" src="log_macretrylimit_2.png">

## No route to destination

In this example, packets will be dropped due to the lack of static routes. The
configuration is `NoRouteToDestination` in the ini file. The network is
the following:

<img class="screen" src="noroutenetwork.png">

It contains two connected `StandardHosts`. The
`IPv4NetworkConfigurator` is instructed not to add any static routes, and
`host1` is configured to ping `host2`.

The ping packets can't be routed, thus the IP module drops them. This is
illustrated on the following video:

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" src="packetdrop21.mp4" width="416" height="482"></video></p>

Here is also a log excerpt illustrating this:

<img class="screen" src="log_noroute_2.png">

## Interface not connected

In this example (`InterfaceNotConnected` configuration in the ini file),
packet drops occur due to a disabled wired connection between the hosts:

<img class="screen" src="unroutablenetwork.png">

It contains two `StandardHosts`, connected with an ethernet cable.
The ethernet cable is configured in the NED file to be disabled. Additionally,
`host1` is configured to ping `host2`.

Since the cable between the hosts is configured to be disabled, the MAC module is
unable to send the packets, and drops them. This is illustrated on the following
animation:

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" src="packetdrop22.mp4" width="414" height="477"></video>

Note the packet drop animation at `host1`. The packet drops are also
evidenced in the log:

<img class="screen" src="log_notconnected_2.png">

## Further information

For more information, refer to the `PacketDropVisualizer` NED documentation.

## Discussion

Use <a href="https://github.com/inet-framework/inet-showcases/issues/1" target="_blank">this page</a>
in the GitHub issue tracker for commenting on this showcase.

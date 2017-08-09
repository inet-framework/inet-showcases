---
layout: page
title: Hidden Node Example
hidden: true
---

## Goals

This showcase demonstrates the hidden node problem in 802.11 wireless
networks, and the RTS/CTS mechanism that addresses it.

Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/wireless/hiddennode" target="_blank"><var>inet/showcases/wireless/hiddennode</var></a>

### Description of the hidden node problem

For example, the hidden node problem occurs in a wireless network when two
transmitting nodes are out of range of each other, and cannot detect when the
other is transmitting. They simultaneously transmit to an intermediate node that
is in transmission range of both. Since they don't know when the other is
transmitting, normal collision avoidance is not effective, and their transmissions
will often interfere at the intermediate node. Note that this is the simplest hidden
node problem, there are more complicated ones (see <a
href="https://en.wikipedia.org/wiki/Hidden_node_problem" target="blank">
Hidden node problem</a> on wikipedia.)

The solution employed in 802.11 networks is to use Request to send/Clear to send
frames (RTS/CTS). Before transmitting a frame, hosts send an RTS frame
addressed to the target node. The target node then replies with a CTS frame if the
channel is idle. In response to the CTS frame, the transmitting node transmits the
original frame.

A nearby hidden node cannot receive the RTS, but it receives the CTS, which
indicates that there is another node out of range, about to transmit. It defers from
transmitting, until the ongoing transmission is over. It knows the exact time the
transmission will take from the duration field of the CTS frame. The CTS, RTS and
ACK frames each have a duration field, which indicate how much time is left until
the entire packet exchange (RTS, CTS, payload frame, and ACK) is completed.
Thus any node that receives one of the frames knows when the channel will
become available for transmission.

### Demonstrating the hidden node problem

The showcase contains four simulation models. The first one doesn't use the
RTS/CTS mechanism, so effectively the hidden node problem is not addressed
here. The second one adds the RTS/CTS mechanism, which addresses the
problem, adding some overhead to the transmissions in the process. The third
and forth are for reference, showing what would happen if there were no hidden
nodes in the first place.

## The model

The network for all simulations contains three hosts, arranged in a triangle. Host A
and C are separated by a wall which completely blocks transmissions, thus the
nodes cannot transmit to each other, and cannot sense when the other is
transmitting. The wall is enabled or disabled in the various simulations. They both
send UDP packets to Host B, which can receive the transmissions of both hosts.

<img class="screen" src="network.png">

The RTS/CTS mechanism can be enabled or disabled by setting the
`rtsThresholdBytes` parameter in the `MAC` module of hosts.
The RTS/CTS mechanism is used before packets whose size exceeds the size of the
threshold.

In the first configuration (`WallOnRTSoff`), the RTS/CTS mechanism is
disabled. Host A and C will likely transmit at the same time very often. This will
result in collisions at Host B. In the `WallOnRTSoff` configuration, the
RTS/CTS mechanism is enabled. This is expected to reduce the number of
collisions, and Host B will receive more packets correctly than in the previous
configuration. In the third model the wall is removed, and RTS/CTS is disabled.
This model will highlight the effect of the RTS/CTS mechanism and the RTS/CTS
overhead. In the `WallOffRtsOn` configuration, the wall is disabled
and RTS/CTS is enabled. Again, this configuration will show the effects of the
RTS/CTS mechanism. This way the four models can be compared by the number of
packets received at Host B.

## Results

**RTS/CTS disabled**

Both Host A and C frequently transmit simultaneously, thus the number of
collisions at Host B is high.

The animation above depicts such a collision. Host C starts transmitting, and Host
A starts transmitting as well, before Host C's transmission is over. As neither
packet can be received correctly by Host B (and thus they are not ACKed), Hosts A
and C retry transmitting the same packet multiple times after the backoff period.
The retransmitted packets also collide, because the packets are long compared to
the backoff period. Finally, Host C manages to send its packet without
interference.

<p><video autoplay loop controls src="WallOnRtsOff2.mp4" onclick="this.paused ? this.play() : this.pause();" width="760" height="650"></video></p> <!-- 8ms-21ms, run, animation speed 1, built-in video recording -->

Here is what a collision looks like in the log:

<img src="collision.png" class="screen" />

The number of packets received by Host B (Wall on, RTS/CTS off): **1402**

**RTS/CTS enabled**

With RTS/CTS enabled, there are no more collisions, except for between RTS
frames. RTS and CTS frames are much shorter than data frames (about 50ns vs
2ms), thus the probability of RTS frames colliding is less than for data frames. The
result is that a low number of RTS frames collide, and since they are short, the
collisions don't take up much time.

<img src="rtscollision.png" class="screen" />

The following animation shows the RTS/CTS and data frame exchange.

<img src="hiddennode11.gif" class="screen" /> <!--TODO: remove, left here to compare to video-->

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" src="WallOnRtsOn.mp4" width="756" height="640"></video>

The following sequence chart illustrates that the RTS/CTS mechanism makes the
communication more orderly, as the nodes know when to transmit in order to
avoid collisions. It also illustrates that RTS and CTS frames are much shorter than
data frames.

<img src="rts-seq.png" class="screen" width="900" />

The number of received packets at Host B (Wall on, RTS/CTS off): **1987**

**Wall removed**

With the wall removed, hidden nodes are no longer a problem. When the RTS/CTS
mechanism is not used, collision avoidance mechanisms can work, and the
number of collisions is low. The RTS/CTS mechanism stops data frame collisions,
so only the RTS and CTS frames can collide. The RTS and CTS frames are much
shorter than data frames, thus retrasmitting them takes less time. Even though
the RTS/CTS frames contribute some overhead, more packets are received
correctly at Host B. When RTS/CTS is used, the number of packets received
correctly at Host B is the same regardless of the presence of the wall.

The number of received packets at Host B (RTS/CTS off): **1936**
The number of received packets at Host B (RTS/CTS off): **1987**

## Further information

More information can be found in the <a href="https://omnetpp.org/doc/inet/api-current/neddoc/index.html" target="_blank">INET Reference</a>.

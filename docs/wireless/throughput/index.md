---
layout: page
title: IEEE 802.11 Throughput
---

## Goals

This example analyzes how application-level throughput changes as a function of
nominal bitrate in a 802.11g network.

INET version: `3.6`<br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/wireless/throughput" target="_blank">`inet/showcases/wireless/throughput`</a>

## The model

### Application-level throughput

802.11 modes are denoted by the nominal data bitrate (e.g. 54 Mbps). However,
the bitrate available for an application is less than the nominal bitrate because of
protocol overhead like preamble, physical and MAC headers, TCP and IP headers,
interframe spaces and backoff periods. In this model, the actual application-level
throughput is measured.

### Configuration

The network contains two `WirelessHosts`, at a distance of 1 meter,
one of them acting as traffic source, the other one as traffic sink. The source host
sends a UDP stream of 1000-byte packets to the destination host in ad-hoc mode.
The simulation will be run several times, with different bitrates. The UDP
application in the source host is configured to saturate the channel at all bitrates.
There will be no packets lost in the physical layer, because the hosts are close to
each other, and background noise is configured to be very low.

The parameter study iterates over the following 802.11g bitrates: 6, 9, 12, 18, 24,
36, 48, and 54 Mbps. Each simulation runs for 1 second, and the UDP throughput
is averaged for this interval.

## Results

Measured throughput is compared to analytically obtained values. The frame
exchange duration can be calculated from the nominal bitrate and the payload
size, for example using this <a href="https://sarwiki.informatik.hu-
berlin.de/Packet_transmission_time_in_802.11" target="_blank">frame exchange
duration calculation formula</a>. It takes the DIFS, data frame duration, SIFS and
ACK duration into account (but not the backoff period.) By assuming an average
backoff time that is half of the minimal contention window, the theoretical
throughput can be calculated.

The following plot compares the computed throughput to the results of the
simulation for all bitrates.

<img src="throughput2.png" class="screen" />

The two curves match almost exactly. The curve is not linear: throughput doesn't
increase in a linear way with the bitrate, especially at higher bitrates. The reason
is that faster bitrates have more overhead. For example, at 6 Mbps the
application-level throughput is 5 Mbps (16% overhead), whereas at 54 Mbps it is
only about 24.5 Mbps (54% overhead). Faster modes only transmit the MAC
header and content part of frames at higher bitrates, the preamble, physical
header, interframe spaces and backoff stay the same, thus the overhead gets
larger as the bitrate increases.

The following sequence chart excerpt illustrates overhead increasing with bitrate.
It shows frame exchanges with bitrates of 6, 18, and 54 Mbps, on the same linear
timescale. One can see how the proportion of data parts shrinks compared to the
duration of the frame exchange as bitrates increase.

<img src="seqchart3.png" class="screen" width="850" />

The following sequence chart illustrates the relative sizes of the preamble,
physical header, and data part of a 54 Mbps frame exchange. The preamble and
the physical header has the same duration regardless of the bitrate, further
increasing overhead at higher bitrates.

<img src="seqchart5.png" class="screen" width="850" />

There are techniques that increase application-level throughput by reducing
overhead. For example, in 802.11n, overhead at high bitrates is reduced by using
block acknowledgement and frame aggregation. When block acknowledgement is
used, multiple data frames can be acknowledged with a single block
acknowledgement frame (instead of ACKing each data frame one-by-one.) Frame
aggregation allows multiple data frames to be sent following a preamble and a
physical header in a single transmission. Recent versions of the INET Framework
support these 802.11 features, but they are out of scope for this simulation
example.

## Further information

More information can be found in the <a href="https://omnetpp.org/doc/inet/api-current/neddoc/index.html" target="_blank">INET Reference</a>.

## Discussion

Use <a href="https://github.com/inet-framework/inet-showcases/issues/6" target="_blank">this page</a>
in the GitHub issue tracker for commenting on this showcase.

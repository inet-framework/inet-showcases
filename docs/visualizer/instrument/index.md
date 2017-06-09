---
layout: page
title: Visualizing Information with Instrument Figures
---

Goals
-----

In a complex simulation, there can be many statistics that are important
to understand what is happening in the network. These are available in
the depts of the inspector panel, and submodules of network nodes might
display them, many levels down. However, it is convenient to visualize
this data at the top level canvas. This information can be intuitively
visualized with instrument figures, which can display important states
and numeric data in the form of various gauges and meters. There are
multiple instrument types available, each suited for displaying
particular kinds of data.

This example contains a configuration that demonstrates multiple
instrument figures.

TODO: this works with what inet version ?

About the instrument figures
----------------------------

There are several types of instrument figures available in INET. Some of
them are the following:

-   <p><var>gauge:</var> A circular gauge similar to a speedometer or
    pressure indicator

    <img class="screen" src="gauge.png"></p>

-   <p><var>linearGauge:</var> A horizontal linear gauge similar to a vu
    meter

    <img class="screen" src="linear.png"></p>

-   <p><var>progressMeter:</var> A horizontal progress bar

    <img class="screen" src="progress.png"></p>

-   <p><var>couter:</var> An integer counter

    <img class="screen" src="counter.png"></p>

-   <p><var>thermometer:</var> A vertical meter similar to a thermometer

    <img class="screen" src="thermometer.png"></p>

-   <p><var>indexedImage:</var> A figure displaying images corresponding to
    different states

    <center>
    <img class="border" src="idle.png" width="100px">
    <img class="border" src="listen.png" width="100px">
    <img class="border" src="clock.png" width="100px">
    </center></p>

-   <p><var>plot:</var> A graph figure that can plot a statistic vs. time

    <img class="screen" src="plot.png"></p>

There are three components needed for the figures to work: a signal, a
statistic, and a figure.

-   Various submodules in the network emit <var>signals</var> during
    the simulation. The signals carry numeric data and information about
    state changes.

-   <var>Statistics</var> are derived from the signals, often through
    mathematical operations on the signal data.

-   <var>Figures</var> display the value of the statistics.

Figures are configured in NED files. The configuration is illustrated by
the following example:

-   A signal called <var>rcvdPk</var> is defined in a submodule (e.g. a
    TCP application). The signal is emitted whenever a packet arrives:

    <p><div class="snippet">
    @signal[rcvdPk](type=cPacket);
    </div></p>

-   A statistic called <var>numRcvdPk</var> and a figure called
    <var>numRcvdPkCounter</var> is declared in the simulation's
    NED file. This statistic counts how many times the <span
    style="font-family: monospace;">rcvdPk</span> signal is emitted. It
    records the value in the <span
    style="font-family: monospace;">numRcvdPkCounter</span> figure. The
    type of the figure is specified to be <var>counter</var>, which is a
    figure type well suited for counting packets.

    <p><div class="snippet">
    @statistic[numRcvdPk](source=count(rcvdPk); record=figure; targetFigure=numRcvdPkCounter);
    @figure[numRcvdPkCounter](type=counter);
    </div></p>

TODO: this seems redundant

Instrument figures visualize statistics derived from signals emited by
modules in the network. This statistic is declared in the NED file, with
the <var>@statistic</var> property. The property's <var>source</var>
attribute is an expression that specifies the source signal and
mathematical operations to derive the statistic. The property's
<var>source</var> attribute is an expression that specifies which
signals to use from which modules, and the mathematical operations on
it, to derive the statistic. The <var>record</var> attribute specifies
where the values of the statistic is recorded into. In the case of
instrument figures, this is set to <var>figure</var>, i.e. <span
class="snippet" style="padding: 1px 6px;">record=figure</span>. This
records the values of the statistic into a figure, instead of vectors or
histograms used in post simulation analysis. The <var>targetFigure</var>
property selects which figure should display the statistic. The
instrument figure is specified in the NED file with the
<var>@figure</var> property. The property's <var>type</var> attribute
selects the type of the instrument figure. Here is an example from this
configuration's NED file:

<p><pre class="snippet">
@figure[numRcvdPkCounter](type=counter; pos=413,327; label="Packets received"; decimalPlaces=4);
@statistic[numRcvdPk](source=count(client.tcpApp[0].rcvdPk); record=figure; targetFigure=counter);
</pre></p>

This creates a figure named <var>numRcvdPkCounter</var>, which is a
counter type figure. The statistic <var>numRcvdPk</var> counts the
number of packets received by <var>client's TCP app</var>, and records
it in the <var>numRcvdPkCounter</var> figure.

Instrument figures have various attributes that can customize their
position, size, appearence, label text and font, minimum and maximum
values, and so on.

Using instrument figures
------------------------

The configuration for this example demonstrates the use of several
instrument figures. It uses this network:

<img class="screen" src="network3.png">

There are two <var>AdhocHosts</var>. The visualizer is needed only to
display the server's communication range. The scenario is that the
<var>client</var> connects to the <var>server</var> via wifi, and
downloads a one megabyte file. The following statistics are displayed by
instrument figures:

-   Application level throughput is displayed by a
    <var>gauge</var> figure. Throughput is averaged over 0.1s or
    100 packets.
-   Wifi bit rate determined by automatic rate control is displayed by a
    <var>linearGauge</var> figure and a <var>plot</var> figure
-   Packet error rate estimated at the physical layer from signal to
    noise ratio at the client, is displayed by a <var>thermometer</var>
    figure and a <var>plot</var> figure
-   The Wifi MAC channel access contention state of the server is
    displayed by an <var>indexedImage</var> figure. IDLE means nothing
    to send, DEFER means the channel is in use, IFS\_AND\_BACKOFF means
    channel is free and contending to acquire channel
-   Download progress is displayed by a <var>progessMeter</var> figure
-   The number of socket data transfers to the client application is
    displayed by a <var>counter</var> figure

The client is configured to move horiztontally back and forth, initially
moving away from the server. The hosts are configured to use
<var>AARFRateControl</var>, so the wifi speed and the application level
throughput are expected to gradually drop as the client moves away from
the server.

The gauge, linear gauge, and the thermometer figures have <var>minValue,
maxValue and tickSize</var> parameters, which can be used to customize
the range and the granularity of the figures.

-   The <var>gauge</var> figure ticks are configured to go from 0 to 25
    Mbps in 5 Mbps increments - the maximum theoretical application
    level throughput of g mode wifi is about 25 Mbps. The application
    level throughput is computed from the the received packets at the
    client, using the <var>throughput</var> result filter. It is divided
    by 1 million to get the values in Mbps instead of Bps.
-   The <var>linear gauge</var> figure ticks are configured to go from 0
    to 54 Mbps in increments of 6, thus all modes in 802.11g falls at a
    mark, e.g. 54, 48, 36, 24 Mbps and so on. It is driven by the
    <var>databitrate</var> signal, again divided by 1 million to get the
    values in Mbps.
-   The <var>thermometer</var> figure displays the packet error rate
    estimation as computed by the client's radio. The ticks go from 0 to
    1, in increments 0.2. It is driven by the <var>packetErrorRate</var>
    signal of the client's radio.
-   There are two <var>plot figures</var> in the network. The
    <var>perPlot</var> figure displays the packet error rate in the
    client's radio over time. The time window is set to three seconds,
    so data from the entire simulation fits in the graph. The
    <var>bitratePlot</var> figure displays the Wifi bit rate over time.
    Its value goes from 0 to 54, and the time window is 3 seconds.
-   The <var>counter</var> figure displays the number of data transfers
    received by the client. It takes about 2000 packets to transmit the
    file, thus the number of decimal places to display is set to 4,
    instead of the default 3. It is driven by the <var>rcvdPk</var>
    signal of the client's TCP app, using the <var>count</var> result
    filter to count the packets.
-   The <var>progress</var> figure is used to display the progress of
    the file transfer. The bytes recieved by the client's TCP app is
    summed, and divided by the total size of the file. The result is
    multiplied by 100 to get the value of progress in percent.
-   The <var>indexedImage</var> figure is used to display the contention
    state of the server's MAC. An image is assigned to each contention
    state - IDLE, DEFER, IFS\_AND\_BACKOFF. The images are specified by
    the figure's <var>images</var> attribute. Images are listed in the
    order of the contention states as defined in Contention.h file.
    Images must be on the IMAGE\_PATH? The custom images we use TODO:
    its possible to use custom images, we're using custom images here

This video illustrates what happens when the simulation is run:

<p><video controls autoplay loop src="indicator16.mp4" onclick="this.paused ? this.play() : this.pause();" width="854" height="485"></video></p>

The client starts moving away from the server. At the beginning, the
server transmits with 54 Mbps bit rate. The transmissions are received
correctly, because the two nodes are close. As the client moves further
away, signal to noise ratio drops and packet error rate goes up. As
packet loss increases, the rate control in the server lowers the bit
rate, because lower bit rates are more tolerant to noise. When the
client gets to the edge of the communication range, the bit rate is only
24 Mbps. When it leaves the communicaton range, successful reception is
impossible, so the rate quickly reaches its lowest. After the client
turns around and re-enters communication range, the rate starts to rise,
eventually reaching 54Mbps again.

The download progress stops when the client is out of range, since it is
driven by correctly received packets at the application. Due to the
reliable delivery service of TCP, lost packets are automatically
retransmitted by the server. Thus the progress meter figure measures
progress accurately.

As the rate control changes the wifi bit rate, the application level
throughput changes accordingly. The packet error rate fluctuates as the
rate control switches between higher and lower bit rates back and forth.
The following picture (a zoomed in view of the <var>plot1</var> figure)
clearly shows these fluctuations. It also shows packet error rate as a
function of distance (due to constant speed).

    TODO: or not to do? In some ranges where the wifi bit rate is quasy-constant, the figure is similar to the one in such example.

<img class="screen" src="per.png" width="850px">

    TODO: about the throughput, the contention state, more about the packet error rate fluctuation

TODO: why does the simulation speed up when the client is out of the
communication range?

Further information
-------------------

For more information, refer to the documentation of the figures.

TODO: ...which are non existent now? the omnet manual has information
about figures in general

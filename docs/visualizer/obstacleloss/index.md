---
layout: page
title: Visualizing Obstacle Loss
---

Goals
-----

Physical objects interacting with transmissions can lead to packet loss. When radio signals pass through objects in the physical environment, the objects reflect and absorb electromagnetic energy. The loss of energy often results in incorrectly received packets. It's not immediately obvious where the loss of energy happens, so visualizing it can significantly facilitate understanding what happens in the simulation.

INET can visualize the intersections of obstacles and signals, with several details.

This showcase contains two simulations, which demonstrate the visualization of obstacle loss. The showcase works with INET 3.6. The source files are located in the <var>inet/showcases/visualizer/obstacleloss</var> directory.

About the visualizer
--------------------

The <var>ObstacleLossVisualizer</var> module (part of the <var>IntegratedVisualizer</var> included in the network) can display the intersection between physical objects and propagating radio signals. It can display the magnitude of power loss in dB. Additionally, the face normal vectors can be displayed at both ends of the intersection.

The visualization is enabled with the <var>displayIntersections</var> parameter.

Enabling the visualization
--------------------------

The configuration uses the following network:

<img src="simplenetwork.png" class="screen" />

It contains two <var>AdhocHosts</var>, and a wall between them. The hosts are stationary, and one of them is configured to ping the other. The wall obstructs the signals.

The visualization is enabled with the <var>displayIntersections</var> parameter. The <var>displayFaceNormalVectors</var> parameter enables the face normal vectors. The default color of the intersection lines is red, which is hardly visible against the brick wall. Thus the color is changed to yellow with the <var>intersectionLineColor</var> parameter:

<p><div class="snippet">
*.visualizer.*.obstacleLossVisualizer.displayIntersections = true
*.visualizer.*.obstacleLossVisualizer.displayFaceNormalVectors = true
*.visualizer.*.obstacleLossVisualizer.intersectionLineColor = "yellow"
</div></p>

When the simulation is run, and <var>source</var> starts pinging <var>destination</var>, the signals go through the wall:

<img src="simple2.png" class="screen" />

The intersection of the wall and the transmission is indicated with a yellow line. The magnitude of power loss is indicated in decibels.

Multiple Obstacles
------------------

The following configuration uses a more complex network:

<img src="advancednetwork.png" class="screen" />

It contains two <var>AdhocHosts</var>. In the middle of the playground, there is a rectangular brick structure, with a hollow interior. The hosts are configured to go around the structure on a rectangular path. The <var>destinationHost</var> is configured to move with a higher speed than the <var>sourceHost</var>. The <var>sourceHost</var> is configured to ping <var>destinationHost</var>. The following animation illustrates what happens when the simulation is run:

<p><video controls autoplay loop onclick="this.paused ? this.play() : this.pause();" src="obstacleloss2_5.mp4" width="614" height="470"></video></p>

The hosts send ping packets through the structure. Even when the obstacles are not contiguous, the yellow lines are drawn wherever transmissions and the obstacles intersect. The power loss values are indicated in decibels, at each section of the wall the signals go through. The face normal vectors are displayed at both ends of the intersections, their relative length indicate the length of the intersection.

By default, the intersection lines do not disappear immediatelly at the end of the transmission, but gradually fade away. This allows you to see all recent transmissions at once. This is demonstrated in the following video, that shows the simulation running in fast mode:

<p><video controls autoplay loop onclick="this.paused ? this.play() : this.pause();" src="obstacleloss3.mp4" width="586px" height="440px"></video></p>

The fading time, as well several other parameters can be configured.

Further information
-------------------

For more information, refer to the <var>ObstacleLossVisualizer</var> NED documentation.

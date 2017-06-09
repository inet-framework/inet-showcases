---
layout: page
title: Visualizing Physical Environment
---

Goals
-----

The physical environment has a profound effect on the communication of
wireless devices. For example, physical objects like walls inside
buildings constraint mobility. They also obstruct radio signals often
resulting in packet loss. It's difficult to make sense of the simulation
without actually seeing where physical objects are.

The visualization of physical objects present in the physical
environment is essential. This showcase contains two example
simulations, which demonstrate the visualization of physical objects.

INET version: <var>3.6</var><br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/environment" target="_blank"><var>inet/showcases/visualizer/environment</var></a>

About the visualizer
--------------------

The <var>PhysicalEnvironmentVisualizer</var> (also part of
<var>IntegratedVisualizer</var>) is responsible for displaying the
physical objects. The objects themselves are provided by the
<var>PhysicalEnvironment</var> module; their geometry, physical and
visual properties are defined in the XML configuration of the
<var>PhysicalEnvironment</var> module.

The two-dimensional projection of physical objects is determined by the
<var>SceneCanvasVisualizer</var> module. (This is because the projection
is also needed by other visualizers, for example
<var>MobilityVisualizer</var>.) The default view is top view (z axis),
but you can also configure side view (x and y axes), or isometric or
ortographic projection.

The default view
----------------

This example configuration (<var>DefaultView</var> in the ini file)
demonstrates the default visualization of objects. The objects are
defined in the <var>indoor.xml</var> file, which depicts an apartment
with three rooms. The network contains just two modules, a
<var>PhysicalEnvironment</var> and an <var>IntegratedVisualizer</var>
module. When the simulation is run, the network looks like this:

<img class="screen" src="default.png">

The isometric view
------------------

In this example configuration (<var>IsometricView</var> in the ini
file), the view is set to isometric projection. This is done by setting
the <var>viewAngle</var> parameter in <var>SceneVisualizer</var>:

<p><div class="snippet">
*.visualizer.canvasVisualizer.sceneVisualizer.viewAngle = "isometric"
</div></p>

When the simulation is run, the network looks like the following.

<img class="screen" src="isometric.png">

3D visualization
----------------

The visualizer also supports OpenGL-based 3D rendering using the
OpenSceneGraph (OSG) library. If your OMNeT++ installation has been
compiled with OSG support, you can switch to 3D view using the toolbar.
The result will look like the following. Note that the
<var>SceneVisualizer</var> view settings have no effect on the 3D view,
you can use the mouse to move the camera and change the view angle.

<img class="screen" src="3d.png">

Further information
-------------------

For more information, refer to the NED documentation of
<var>PhysicalEnvironmentVisualizer</var> and
<var>SceneCanvasVisualizer</var>.

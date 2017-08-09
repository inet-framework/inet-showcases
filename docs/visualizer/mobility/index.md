---
layout: page
title: Visualizing Mobility
hidden: true
---

## Goals

In INET simulations, movements of mobile nodes are often as important as the
communication between nodes. When mobile nodes are roaming in the network, it
is difficult to follow their movement.

INET provides a visualizer which visualize informations about nodes' mobility.
Using this visualizer, mobile nodes can be tracked easily.

This showcase consists of one simulation model, that demonstrates important
features of mobility visualization.

INET version: `3.6`<br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/mobility" target="_blank">`inet/showcases/visualizer/mobility`</a>

## About the Visualizer

In INET, mobility of nodes can be visualized by `MobilityVisualizer`
module (included in the network as part of `IntegratedVisualizer`). By
default, mobility visualization is enabled, it can be disabled by setting
`displayMovements` parameter to false.

By default, all mobilities are considered for the visualization. This selection can be
narrowed with the visualizer's `moduleFilter` parameter.

The visualizer has several important features:

-   **Movement Trail**: It displays a line along the recent path of movements. The trail gradually fades out as time passes. Color, trail length and other graphical properties can be changed with parameters of the visualizer.
-   **Velocity Vector**: Velocity is represented visually by an arrow. Its starting point is the node and its direction coincides with the movement's direction. The arrow's length is proportional to the node's speed, but it can be multiplied.
-   **Orientation Arc**: Orientation is represented by an arc whose size is specified by the `orientationArcSize` parameter. This value is the relative size of the arc compared to a full circle. The arc's default value is 0.25, i.e. a quarter or a circle.

These features are disabled by default, they can be enabled by setting the
visualizer's `displayMovementTrails`, `displayVelocities`
and `displayOrientations` parameters to true.

## Visualizing Mobility Features

The following example shows how to enable mobility visualization features. We
create a simulation for this example that can be run by choosing the
`VisualizingFeatures` configuration from the ini file.

Three `AdhocHost` type nodes (`host1`,
`host2` and `host3`) are placed in the playground. They are
roaming within predefined borders.

The following video is captured from the simulation. The default settings of
mobility visualization are used.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="822" height="702" src="NoFeatures_v0620.m4v"></video>

It is difficult to track the nodes, because they are moving randomly and quite fast.
In our next experiment, we enable movement trails, velocity vectors and
orientation arcs. We expect that nodes can be tracked easier.

``` {.snippet}
# Movement trail
*.visualizer.*.mobilityVisualizer.displayMovementTrails = true
*.visualizer.*.mobilityVisualizer.trailLength = 300

# Velocity vector
*.visualizer.*.mobilityVisualizer.displayVelocities = true

# Orientation arc
*.visualizer.*.mobilityVisualizer.displayOrientations = true
```

When we start the simulation, here is what happens.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="822" height="702" src="VisualizingFeatures_v0627.m4v"></video>

Compare this video to the previous one! The first thing you can notice is that
hosts' movements are the same as in the previous video. However, note, that
`host3` does not move randomly, but in a circular arc. The
`host1` and `host2` nodes can also be easily tracked because of
mobility visualization.

## More Information

This example only demonstrated the key features of mobility visualization. For
more information, refer to the `MobilityVisualizer` NED
documentation.

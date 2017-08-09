---
layout: page
title: Path Loss Models
hidden: true
---

## Goals

INET features various path loss models for simulating radio propagation, ranging
from simple ones like free space path loss to more complex ones like Rician and
Rayleigh fading. This showcase demonstrates some of the available path loss
models and how to use them in simulations.

The showcase contains an example simulation, which computes received power
vs. distance using several path loss model types.

Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/wireless/pathloss" target="_blank">`inet/showcases/wireless/pathloss`</a>

## About path loss models

Path loss models are used to compute the decrease in the power of a radio signal
as it propagates away from the transmitter. The default path loss model in INET is
free space path loss, which only computes attenuation due to the inverse square
law along a single line-of-sight propagation path. This is a simple model, and
realistic in the case of satellite-to-satellite communications. Because of its low
computing requirement, it is also useful if the emphasis of the simulation is not on
the accuracy of radio propagation (e.g. testing protocols.) However, there are
more path loss models available in INET, suitable to many scenarios. Here is a list
of the path loss models featured in the example simulation, along with brief
descriptions:

-   `FreeSpacePathLoss:` Computes loss of signal power in a single line-of-sight propagation path, without any reflections or shadowing.
-   `TwoRayGroundReflection:` Computes loss of signal power by assuming a line-of-sight wave and another wave reflected from the ground between the transmitter and the receiver. This model differs from free space path loss in the far-field only, after a certain crossover distance.
-   `TwoRayInterference:` This is the same as the two-ray ground reflection model in the far-field, but it models the near-field more accurately.
-   `RicianFading:` It's a stochastic path loss model which assumes a dominant line-of-sight signal and multiple reflected signals between the transmitter and the receiver. It is useful for modeling radio propagation in an urban environment.
-   `LogNormalShadowing:` It's a stochastic path loss model, where power levels follow a lognormal distribution. It is useful for modeling shadowing caused by objects such as trees.

Other path loss models in INET include `RayleighFading`,
`NakagamiFading`, `UWBIRStochasticPathLoss`,
`BreakpointPathLoss`, and `SUIPathLoss`.

The various path loss models each have sets of parameters to fine-tune their
behavior. In this showcase we leave the parameters at their defaults.

About the setup...two nodes communicating with increasing distance, received
power vs. distance, using various path loss models

## The model

<pre>
- The network and what it contains
- It will be a parameter study where the two nodes will communicate; the source node will send one UDP packet
- The distance will be a parameter
- So as the path loss type

- The ground model is needed for some models (just for two-ray ground ?)
- The ground is at 0, the nodes are at 2 meters -> required for the two-ray ground model
</pre>

The example simulation uses the following network:

<img src="network.png" class="screen" />

The network contains two `adhocHosts` named `source`
and `destination`. It also contains a `PhysicalEnvironment`
module, in addition to `IPv4NetworkConfigurator` and
`Ieee80211ScalarRadioMedium`.

The physical environment module is required because it contains the ground
model used by some path loss models. By default, the physical environment
doesn't use a ground model, but it is set in the configuration to use
`FlatGround`:

``` {.snippet}
*.physicalEnvironment.groundType = "FlatGround"
```

TODO
The ground model contains the elevation of the ground. It is used by the two-ray
ground model, the two-ray interference model assumes the ground elevation to be 0.

We will leave the ground's elevation parameter at default, which is 0. The z co-
ordinate of both hosts is set to 2 meters, thus both antenna heights are 2 meters
above the ground. (The hosts have isotropic antennas, which lack directionality.)

The simulation is a parameter study, where `source` is configured to
send a UDP packet to `destination`. The x co-ordinate of
`source's` position is 0, thus the x co-ordinate of `destination's`
position equals the distance between the two nodes. This distance is a parameter,
which changes from 0 to 1000 meters. The distance changes with smaller steps
near 0, where the change in power will be more rapid.

Here are the keys from the configuration relevant for positioning the hosts:

``` {.snippet}
# mobility settings
*.*.mobility.initFromDisplayString = false
*.*.mobilityType = "StationaryMobility"
*.*.mobility.initialY = 200m
*.*.mobility.initialZ = 2m

*.source.mobility.initialX = 0m
*.destination.mobility.initialX = ${distance=0..50 step 0.25, 51..100 step 1, 105..200 step 5, 220..1000 step 20}m
```

TODO: should be more brief...the parameter is the distance between the the two
nodes

The other variable in the parameter study is the path loss type, which takes on the
following values: FreeSpacePathLoss, TwoRayGroundReflection,
TwoRayInterference, RicianFading, LogNormalShadowing.

The source host will transmit with the default power of 20mW. We will record the
power of the received transmission (`receptionPower` signal in the
transmitter module.)

## Results

The power of the received signal vs. distance, using
`FreeSpacePathLoss`, `TwoRayGroundReflection` and
`TwoRayInterference` path loss models, is displayed on the following plot:

<a href="tworay.svg" target="_blank"><img class="screen" src="tworay.png"></a>

Here is the same plot zoomed in:

<a href="tworay2.svg" target="_blank"><img class="screen" src="tworay2.png"></a>

It is apparent that the two-ray ground reflection model yields the same values as
the free space path loss model up until the crossover distance. After that point,
the two curves diverge. The power of the two-ray interference model fluctuates in
the near-field, and converges to the two-ray ground reflection model in the far-
field. Thus the two-ray interference model can be used for more realistic two-ray
propagation simulations.

The next plot displays the power of the received signal vs. distance using the
`RicianFading` and `LogNormalShadowing` models, and
the `FreeSpacePathLoss` model for reference:

<a href="ricianlognormal.svg" target="_blank"><img class="screen" src="ricianlognormal.png"></a>

TODO whats on the plot

The curves don't fluctuate as much after a while, because the data points are less
dense. TODO: about the stochastic nature of the curves

Here is the same plot zoomed in on the near-field:

<a href="ricianlognormal2.svg" target="_blank"><img class="screen" src="ricianlognormal2.png"></a>

    There are various path loss models available in INET, and they help make the simulation more realistic.
    This showcase demonstrates some of the available path loss models and their usage.

## Further information


---
layout: page
title: Level of Detail Example
hidden: true
---

## Goals

This example demonstrates a hypothetical layered radio. The radio can simulate
transmissions at multiple levels of detail. These are 'packet', 'bit' and 'symbol'
level. The example examines packet loss as a function of distance when using
various modulations and levels of detail.

Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/wireless/levelofdetail" target="_blank"><var>inet/showcases/wireless/levelofdetail</var></a>

## The model

### Layered radio

The model uses `APSKScalarRadio` with
`APSKLayeredTransmitter` and `APSKLayeredReceiver`. The
latter two implements the layered radio features. When operating in 'packet'
domain, the error model computes packet errors, bits are not computed. In 'bit'
domain, the error model computes erroneous bits. In the 'symbol' domain, the
encoding and decoding of symbols are simulated, the error model computes
erroneous symbols. Simulations with different levels of detail are expected to
produce similar curves.

### Configuration

There are two hosts, and one host is pinging the other. The there are 4 axes in the parameter study, resulting in 24 different curves:

-   **Distance** runs from 210m to 710m in steps of 5m
-   **Level of detail** for the transmissions are 'packet', 'bit' and 'symbol'
-   **Forward error correction** (FEC) is either `ConvolutionalCoder` or not using forward error correction
-   **Modulations** used are 'BPSK', 'QPSK', 'QAM-16' and 'QAM-64'

### Forward error correction

The used convolutional code has a code rate R = 1 / 2, memory m = 1, and
generator matrix G(D) = (1 1+D). To keep the net bitrate constant across all
simulations, the gross bitrate is increased two-fold when using forward error
correction (36 Mbps instead of 18 Mbps).

## Results

Packet loss vs distance is displayed on the following plot. In general, the three
detail levels produce similar curves for the same modulation and forward error
correction. Except when using forward error correction and the modulation has
more than 1 bits per symbol, the symbol domain curves are different from the
packet and bit domain ones. In these cases, the demodulation process results in a
non-independent distribution of bit errors, which is decoded differently. Simpler
modulations and the use of forward error correction increase the communication
range.

<a href="General.svg" target="_blank"><img class="screen" src="results.png">


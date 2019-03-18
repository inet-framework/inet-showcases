//
// Copyright (C) 2005 Andras Varga
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//

package inet.showcases.wireless.ratecontrol;

import inet.environment.common.PhysicalEnvironment;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.WirelessHost;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.integrated.IntegratedCanvasVisualizer;


network RateControlShowcase
{
    parameters:
        @display("bgb=1300,460");
        @statistic[bitrate](source=sourceHost.wlan[0].mac.dcf.rateControl.datarateChanged/1000000; record=figure; targetFigure=bitrateLinearGauge);
        @figure[bitrateLinearGauge](type=linearGauge; pos=1000,200; size=225,30; minValue=0; maxValue=54; tickSize=6; label="Data Bitrate [Mbps]");
        @statistic[throughput](source=liveThroughput(sinkHost.app[0].packetReceived)/1000000; record=figure; targetFigure=throughputPlot);
        @figure[throughputPlot](type=plot; pos=1000,50; size=225,80; timeWindow=25; maxValue=30; valueTickSize=30; timeTickSize=5; label="App Level Throughput [Mbps] vs Time [s]"; labelOffset=10);
        
        
    submodules:
        sourceHost: WirelessHost {
            parameters:
                @display("r=,,#707070");
        }
        sinkHost: WirelessHost {
            parameters:
                @display("p=200,200;r=,,#707070");
        }
        physicalEnvironment: PhysicalEnvironment {
            parameters:
                @display("p=131.53847,86.15385");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=130.76924,168.46155");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=131.53847,253.84616");
        }
        visualizer: IntegratedCanvasVisualizer {
            @display("p=131.53847,336.15387");
        }
}


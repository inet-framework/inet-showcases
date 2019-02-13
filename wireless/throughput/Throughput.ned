//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package inet.showcases.wireless.throughput;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.WirelessHost;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;


network Throughput
{
    @display("bgb=6,4");
    @statistic[throughput](source=liveThroughput(sourceHost.app[0].packetReceived)/1000000; record=figure; targetFigure=throughputGauge; checkSignals=false);
    @figure[throughput](type=gauge; pos=1,1; size=100,100; minValue=0; maxValue=25; tickSize=5; label="App level throughput [Mbps]");
    submodules:
        sourceHost: WirelessHost {
            @display("p=3,2");
        }
        destinationHost: WirelessHost {
            @display("p=4,2");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=0.64914656,0.43572852");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=0.64914656,1.10266");
        }
}

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

package inet.showcases.visualizer.advanced;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10G;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.integrated.IntegratedCanvasVisualizer;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.visualizer.networklayer.RoutingTableCanvasVisualizer;
import inet.visualizer.networklayer.RoutingTableOsgVisualizer;


network advanced
{
    @display("bgb=846,526");
    submodules:
        router1: Router {
            @display("p=319.8125,375.0625");
        }
        router3: Router {
            @display("p=427.125,241.1875");
        }
        router2: Router {
            @display("p=530.1875,375.0625");
        }
        switch2: EtherSwitch {
            @display("p=643.875,374");
        }
        switch3: EtherSwitch {
            @display("p=427.125,167.875");
        }
        switch1: EtherSwitch {
            @display("p=210.375,374");
        }
        host4: StandardHost {
            @display("p=745.875,308.125");
        }
        host5: StandardHost {
            @display("p=745.875,434.5625");
        }
        host1: StandardHost {
            @display("p=365.5,78.625");
        }
        host2: StandardHost {
            @display("p=522.75,78.625");
        }
        host3: StandardHost {
            @display("p=574.8125,168.9375");
        }
        server: StandardHost {
            @display("p=110.5,375.0625;i=device/server");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=60,60");
        }
        visualizer1: IntegratedCanvasVisualizer {
            @display("p=60,120");
        }
        visualizer2: IntegratedCanvasVisualizer {
            @display("p=60,180");
        }
    connections:
        router1.ethg++ <--> Eth10G <--> router3.ethg++;
        router1.ethg++ <--> Eth10G <--> router2.ethg++;
        router3.ethg++ <--> Eth10G <--> router2.ethg++;
        router2.ethg++ <--> Eth100M <--> switch2.ethg++;
        router3.ethg++ <--> Eth100M <--> switch3.ethg++;
        switch1.ethg++ <--> Eth100M <--> router1.ethg++;
        switch3.ethg++ <--> Eth100M <--> host1.ethg++;
        switch3.ethg++ <--> Eth100M <--> host2.ethg++;
        switch3.ethg++ <--> Eth100M <--> host3.ethg++;
        switch2.ethg++ <--> Eth100M <--> host4.ethg++;
        switch2.ethg++ <--> Eth100M <--> host5.ethg++;
        switch1.ethg++ <--> Eth100M <--> server.ethg++;
}

network advanced2 extends advanced
{
    submodules:
        visualizer11: IntegratedVisualizer {
            @display("p=58.4375,244.375");
        }
        visualizer22: IntegratedVisualizer {
            @display("p=54.1875,312.375");
        }
}

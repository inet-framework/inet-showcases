//
// This program is property of its copyright holder. All rights reserved.
//

package inet.showcases.wireless.multiradio;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.integrated.IntegratedMultiCanvasVisualizer;


network MultiRadioShowcase
{
    parameters:
        @display("bgb=500,300");
    submodules:
        visualizer: IntegratedMultiCanvasVisualizer {
            parameters:
                @display("p=39.644974,101.18344");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=39.053257,68.63906");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=39.644974,27.218937");
        }
        host1: WirelessHost {
            parameters:
                @display("p=85,203");
        }
        host2: WirelessHost {
            parameters:
                @display("p=454,203");
        }
        accessPoint1: AccessPoint {
            parameters:
                @display("p=150,99");
        }
        accessPoint2: AccessPoint {
            parameters:
                @display("p=354,99");
        }
        router: Router {
            parameters:
                @display("p=255,168");
        }
}

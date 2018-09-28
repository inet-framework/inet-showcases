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

package inet.showcases.mobility.spatial;

import inet.node.inet.StandardHost;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.environment.common.PhysicalEnvironment;
import inet.common.geometry.common.OsgGeographicCoordinateSystem;

import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;

network MobilityShowcase3D
{
    parameters:
        int numHosts;
        @display("bgb=1000,1000");
    submodules:
        visualizer: IntegratedVisualizer {
            parameters:
                @display("p=100,50");
        }
        physicalEnvironment: PhysicalEnvironment {
            parameters:
                @display("p=100,150");
        }
		host[numHosts]: StandardHost {
		    parameters:
            	@display("i=misc/node_vs");
        }
}

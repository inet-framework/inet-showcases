package inet.showcases.routing.manetprotocols;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.ManetRouter;
import inet.node.gpsr.GpsrRouter;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.integrated.IntegratedMultiVisualizer;


network ManetprotocolsShowcaseA
{
    @display("bgb=1500,1000;bgl=2");
    @figure[forest](type=image; image="forest"; pos=0,0; transform=scale(0.7),translate(1100,450));
    @figure[tree1](type=image; image="tree"; pos=0,0; transform=scale(0.1),translate(1000,350));
    @figure[tree2](type=image; image="tree"; pos=0,0; transform=scale(0.1),translate(1065,260));
    //    @figure[tree3](type=image; image="tree"; pos=0,0; transform=scale(0.1),translate(1150,320));
    @figure[tree3](type=image; image="tree"; pos=0,0; transform=scale(0.1),translate(1140,380));
    @figure[tree4](type=image; image="tree"; pos=0,0; transform=scale(0.1),translate(1080,470));
    @figure[tree5](type=image; image="tree"; pos=0,0; transform=scale(0.1),translate(990,530));
    @figure[tree6](type=image; image="tree"; pos=0,0; transform=scale(0.1),translate(1050,600));
    @figure[tree7](type=image; image="tree"; pos=0,0; transform=scale(0.1),translate(1170,620));
    submodules:
        source: ManetRouter {
            @display("p=394,189;i=misc/solarpanel");
        }
        destination: ManetRouter {
            @display("p=1230,492;i=misc/sensorgateway");
        }
        node6: ManetRouter {
            @display("p=851,573;i=misc/solarpanel");
        }
        node5: ManetRouter {
            @display("p=890,430;i=misc/solarpanel");
        }
        node4: ManetRouter {
            @display("p=1331,391;i=misc/solarpanel");
        }
        node1: ManetRouter {
            @display("p=1064.24,824.82465;i=misc/solarpanel");
        }
        node3: ManetRouter {
            @display("p=1304,253;i=misc/solarpanel");
        }
        node2: ManetRouter {
            @display("p=940,718;i=misc/solarpanel");
        }
        node7: ManetRouter {
            @display("p=1046,112;i=misc/solarpanel");
        }
        node8: ManetRouter {
            @display("p=901,157;i=misc/solarpanel");
        }
        node9: ManetRouter {
            @display("p=862,286;i=misc/solarpanel");
        }
        node10: ManetRouter {
            @display("p=1200,156;i=misc/solarpanel");
        }
        node11: ManetRouter {
            @display("p=701,373;i=misc/solarpanel");
        }
        node12: ManetRouter {
            @display("p=529,286;i=misc/solarpanel");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=100,100");
        }
        visualizer: IntegratedMultiVisualizer {
            @display("p=100,200");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=100,300");
        }
}

network ManetprotocolsShowcaseB
{
    parameters:
        @display("bgb=400,400");
    submodules:
        source: ManetRouter {
            @display("p=104,335");
        }
        node1: ManetRouter {
            @display("p=104,226");
        }
        node2: ManetRouter {
            @display("p=175,140");
        }
        node3: ManetRouter {
            @display("p=238,276");
        }
        node4: ManetRouter {
            @display("p=312,196");
        }
        node6: ManetRouter {
            @display("p=147,67");
        }
        node7: ManetRouter {
            @display("p=60,125");
        }
        destination: ManetRouter {
            @display("p=292,80");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=38,28");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=38.461544,66.863914");
        }
        visualizer: IntegratedMultiVisualizer {
            @display("p=38.461544,106.50889");
        }
}

network ManetprotocolsShowcaseMoreNodes
{
    parameters:
        @display("bgb=400,400");
    submodules:
        source: ManetRouter {
            @display("p=104,335");
        }
        node1: ManetRouter {
            @display("p=104,226");
        }
        node2: ManetRouter {
            @display("p=175,140");
        }
        node3: ManetRouter {
            @display("p=238,276");
        }
        node4: ManetRouter {
            @display("p=312,196");
        }
        node6: ManetRouter {
            @display("p=147,67");
        }
        node7: ManetRouter {
            @display("p=60,125");
        }
        destination: ManetRouter {
            @display("p=292,80");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=38,28");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=33,78");
        }
        visualizer: IntegratedMultiVisualizer {
            @display("p=28,127");
        }
        node5: ManetRouter {
            @display("p=175,252");
        }
        node8: ManetRouter {
            @display("p=251,187");
        }
        node9: ManetRouter {
            @display("p=322,325");
        }
        node10: ManetRouter {
            @display("p=218,57");
        }
        node11: ManetRouter {
            @display("p=38,213");
        }
        node12: ManetRouter {
            @display("p=49,308");
        }
}

network ManetprotocolsShowcaseSmallerPlayground
{
    parameters:
        @display("bgb=320,304");
    submodules:
        source: ManetRouter {
            @display("p=124,261");
        }
        node1: ManetRouter {
            @display("p=104,172");
        }
        node2: ManetRouter {
            @display("p=175,86");
        }
        node3: ManetRouter {
            @display("p=217,211");
        }
        node4: ManetRouter {
            @display("p=272,149");
        }
        node6: ManetRouter {
            @display("p=144,32");
        }
        node7: ManetRouter {
            @display("p=84,86");
        }
        destination: ManetRouter {
            @display("p=262,55");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=38,28");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=33,78");
        }
        visualizer: IntegratedMultiVisualizer {
            @display("p=28,127");
        }
}


//network ManetProtocolsShowcase
//{
//    @display("bgb=968,400;bgl=2");
//    submodules:
//        source: GpsrRouter {
//            @display("p=85,84;i=misc/solarpanel");
//        }
//        destination: GpsrRouter {
//            @display("p=799,183;i=misc/sensorgateway");
//        }
//        node6: GpsrRouter {
//            @display("p=603,212;i=misc/solarpanel");
//        }
//        node5: GpsrRouter {
//            @display("p=506,128;i=misc/solarpanel");
//        }
//        node4: GpsrRouter {
//            @display("p=420,277;i=misc/solarpanel");
//        }
//        node1: GpsrRouter {
//            @display("p=100,172;i=misc/solarpanel");
//        }
//        node3: GpsrRouter {
//            @display("p=271,172;i=misc/solarpanel");
//        }
//        node2: GpsrRouter {
//            @display("p=248,64;i=misc/solarpanel");
//        }
//        radioMedium: Ieee80211ScalarRadioMedium {
//            @display("p=92,312");
//        }
//        visualizer: IntegratedMultiVisualizer {
//            @display("p=204,312");
//        }
//        configurator: Ipv4NetworkConfigurator {
//            @display("p=291.6,312.255");
//        }
//}
//
//network ManetProtocolsShowcaseB
//{
//    @display("bgb=968,400;bgl=2");
//    submodules:
//        source: GpsrRouter {
//            @display("p=85,84;i=misc/solarpanel");
//        }
//        destination: GpsrRouter {
//            @display("p=799,183;i=misc/sensorgateway");
//        }
//        node6: GpsrRouter {
//            @display("p=603,212;i=misc/solarpanel");
//        }
//        node5: GpsrRouter {
//            @display("p=506,128;i=misc/solarpanel");
//        }
//        node4: GpsrRouter {
//            @display("p=420,277;i=misc/solarpanel");
//        }
//        node1: GpsrRouter {
//            @display("p=100,172;i=misc/solarpanel");
//        }
//        node3: GpsrRouter {
//            @display("p=271,172;i=misc/solarpanel");
//        }
//        node2: GpsrRouter {
//            @display("p=248,64;i=misc/solarpanel");
//        }
//        radioMedium: Ieee80211ScalarRadioMedium {
//            @display("p=92,312");
//        }
//        visualizer: IntegratedMultiVisualizer {
//            @display("p=204,312");
//        }
//        configurator: Ipv4NetworkConfigurator {
//            @display("p=291.6,312.255");
//        }
//}
//
//network ManetProtocolsShowcaseC
//{
//    @display("bgb=1694.925,658.53;bgl=2");
//    submodules:
//        source: GpsrRouter {
//            @display("p=673.11,520.02;i=misc/solarpanel");
//        }
//        destination: GpsrRouter {
//            @display("p=1359.5851,243;i=misc/sensorgateway");
//        }
//        node6: GpsrRouter {
//            @display("p=1218.645,95.985;i=misc/solarpanel");
//        }
//        node5: GpsrRouter {
//            @display("p=1211.355,561.33;i=misc/solarpanel");
//        }
//        node4: GpsrRouter {
//            @display("p=1360.8,422.82;i=misc/solarpanel");
//        }
//        node1: GpsrRouter {
//            @display("p=902.745,479.92502;i=misc/solarpanel");
//        }
//        node3: GpsrRouter {
//            @display("p=1050.975,217.485;i=misc/solarpanel");
//        }
//        node2: GpsrRouter {
//            @display("p=1081.35,382.725;i=misc/solarpanel");
//        }
//        radioMedium: Ieee80211ScalarRadioMedium {
//            @display("p=92,312");
//        }
//        visualizer: IntegratedMultiVisualizer {
//            @display("p=204,312");
//        }
//        configurator: Ipv4NetworkConfigurator {
//            @display("p=291.6,312.255");
//        }
//}
//
//network ManetProtocolsShowcaseD
//{
//    @display("bgb=1000,500;bgl=2");
//    submodules:
//        source: GpsrRouter {
//            @display("p=85,84;i=misc/solarpanel");
//        }
//        destination: GpsrRouter {
//            @display("p=947.6923,244.61539;i=misc/sensorgateway");
//        }
//        node6: GpsrRouter {
//            @display("p=867.6923,79.230774;i=misc/solarpanel");
//        }
//        node5: GpsrRouter {
//            @display("p=647.6923,118.46154;i=misc/solarpanel");
//        }
//        node4: GpsrRouter {
//            @display("p=647.6923,389.23077;i=misc/solarpanel");
//        }
//        node1: GpsrRouter {
//            @display("p=303.07693,118.46154;i=misc/solarpanel");
//        }
//        node3: GpsrRouter {
//            @display("p=647.6923,258.46155;i=misc/solarpanel");
//        }
//        node2: GpsrRouter {
//            @display("p=475.38464,176.15385;i=misc/solarpanel");
//        }
//        radioMedium: Ieee80211ScalarRadioMedium {
//            @display("p=92,312");
//        }
//        visualizer: IntegratedMultiVisualizer {
//            @display("p=204,312");
//        }
//        configurator: Ipv4NetworkConfigurator {
//            @display("p=291.6,312.255");
//        }
//}
//
//network ManetProtocolsShowcaseE
//{
//    @display("bgb=1000,500;bgl=2");
//    submodules:
//        source: GpsrRouter {
//            @display("p=556.9231,19.23077;i=misc/solarpanel");
//        }
//        destination: GpsrRouter {
//            @display("p=947.6923,244.61539;i=misc/sensorgateway");
//        }
//        node6: GpsrRouter {
//            @display("p=577.6923,299.23077;i=misc/solarpanel");
//        }
//        node5: GpsrRouter {
//            @display("p=630.7692,391.53848;i=misc/solarpanel");
//        }
//        node4: GpsrRouter {
//            @display("p=875.38464,343.84616;i=misc/solarpanel");
//        }
//        node1: GpsrRouter {
//            @display("p=722.30774,98.46154;i=misc/solarpanel");
//        }
//        node3: GpsrRouter {
//            @display("p=760.7693,422.3077;i=misc/solarpanel");
//        }
//        node2: GpsrRouter {
//            @display("p=647.6923,190;i=misc/solarpanel");
//        }
//        radioMedium: Ieee80211ScalarRadioMedium {
//            @display("p=92,312");
//        }
//        visualizer: IntegratedMultiVisualizer {
//            @display("p=204,312");
//        }
//        configurator: Ipv4NetworkConfigurator {
//            @display("p=291.6,312.255");
//        }
//}


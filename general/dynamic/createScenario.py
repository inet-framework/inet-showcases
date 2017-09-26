import random
import sys

if (sys.argv[1] == '-h'):
    print("arguments: filename, number of elements, period, lifetime")
elif(len(sys.argv) == 5):
    filename = sys.argv[1]
    numberOfElements = int(sys.argv[2])
    period = int(sys.argv[3])
    lifetime = int(sys.argv[4])

    def createElement(create, time, index, submodule="sourceNode", type="inet.showcases.wireless.dynamic.DynamicHost", parent="."):
        atTagStart = '<at t="' + str(time) + '">'
        atTagEnd = '</at>'
        if(create == True):
            createTag = '    <create-module type="' + type + '" parent="' + parent + '" submodule="' + submodule + str(index) + '"/>'
        elif(create == False):
            createTag = '    <delete-module module="' + submodule + str(index) + '"/>'
        else:
            print("some kind of error")
            return 0;

        element = atTagStart + '\n' + createTag + '\n' + atTagEnd + '\n'
        return element

    def createScenario(numberOfElements, period, lifetime):
        # randomize period only once
        i = 0;
        period = random.expovariate(1.0/period)
        scenario = "<!-- period: " + str(period) + "s -->\n"
        scenario += "<scenario>\n"
        print("period: " + str(period) + "s")
        while i < numberOfElements:
            scenario += createElement(True, i * period, i)
            scenario += createElement(False, i * period + lifetime, i)
            i += 1
        scenario += '</scenario>'
        return scenario

    def createScenario2(numberOfElements, period, lifetime):
        # randomize period at each creation/destruction
        i = 0;
        scenario = "<scenario>\n"
        while i < numberOfElements:
            randomPeriod = random.expovariate(1.0/period)
            scenario += createElement(True, i * randomPeriod, i)
            scenario += createElement(False, i * randomPeriod + lifetime, str(i))
            i += 1
        scenario += '</scenario>'
        return scenario

    with open(filename, 'w') as f:
        f.write(createScenario(numberOfElements, period, lifetime))

else:
    print("argument error")

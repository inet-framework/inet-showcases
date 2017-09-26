import random
import sys

class element:

    def __init__(self, create, time, index, moduleType, parent, name):
        self.create = create
        self.time = time
        self.index = index
        self.moduleType = moduleType
        self.parent = parent
        self.name = name

if (sys.argv[1] == '-h'):
    print("arguments: filename, number of elements, period, lifetime")
elif(len(sys.argv) == 5):
    filename = sys.argv[1]
    numberOfElements = int(sys.argv[2])
    period = int(sys.argv[3])
    lifetime = int(sys.argv[4])

    def createElement(create, time, index, submodule="sourceNode", type="inet.examples.wireless.dynamic.DynamicHost", parent="."):
        atTagStart = '<at t="' + str(time) + '">'
        atTagEnd = '</at>'
        if(create == True):
            createTag = '    <create-module type="' + type + '" parent="' + parent + '" submodule="' + submodule + str(index) + '"/>'
        elif(create == False):
            createTag = '    <delete-module module="' + submodule + str(index) + '[0]' + '"/>'
        else:
            print("some kind of error")
            return 0;

        element = atTagStart + '\n' + createTag + '\n' + atTagEnd + '\n'
        return element

    def createElement2(create, time, index, submodule="sourceNode", moduleType="inet.examples.wireless.dynamic.DynamicHost", parent="."):
        return element(create, time, index, moduleType, parent, submodule)

    def createScenario2(numberOfElements, period, lifetime):
        i = 0;
        scenario = []
        period = random.expovariate(1.0/period)
        while i < numberOfElements:
            scenario.append(createElement2(True, i * period, i))
            scenario.append(createElement2(False, i * period + lifetime, str(i)))
            i += 1
        return scenario

    def createScenario(numberOfElements, period, lifetime):
        i = 0;
        scenario = "<scenario>\n"
        period = random.expovariate(1.0/period)
        while i < numberOfElements:
            scenario += createElement(True, i * period, i)
            scenario += createElement(False, i * period + lifetime, str(i))
            i += 1
        scenario += '</scenario>'
        return scenario

    with open(filename, 'w') as f:
        f.write(createScenario(numberOfElements, period, lifetime))

else:
    print("argument error")

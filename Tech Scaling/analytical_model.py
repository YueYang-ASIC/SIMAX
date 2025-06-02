import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Reference values at 45nm (normalized)
ref_delay = 1.0       # normalized FO4 delay
ref_power_dyn = 1.0   # normalized dynamic power
ref_leakage = 1.0     # normalized leakage
ref_area = 1.0        # normalized gate area
ref_vdd = 1.0         # normalized Vdd

# Initialize a dictionary to store reference values
fourxfour = {
    "dimension": "4x4",
    "delay": 1.42,
    "power_dyn": 4.3148,
    "leakage": 0.6080585,
    "area": 9511.09617,
}

eightxeight = {
    "dimension": "8x8",
    "delay": 1.48,
    "power_dyn": 15.0353,
    "leakage": 2.3796,
    "area": 37340.8146,
}

sixteenxsixteen = {
    "dimension": "16x16",
    "delay": 1.52,
    "power_dyn": 55.0406,
    "leakage": 9.5688,
    "area": 148715.017,
}

thirtytwoxthirtytwo = {
    "dimension": "32x32",
    "delay": 1.66,
    "power_dyn": 195.5922,
    "leakage": 37.4595,
    "area": 589456.011,
}

fourxfour_data = {
    "dimension": "4x4",
    "nodes": [45, 32, 28, 22, 16],
    "vdd": [1.0, 0.9, 0.9, 0.8, 0.7],
    "delay": [],
    "power_dyn": [],
    "leakage": [],
    "area": []
}

eightxeight_data = {
    "dimension": "8x8",
    "nodes": [45, 32, 28, 22, 16],
    "vdd": [1.0, 0.9, 0.9, 0.8, 0.7],
    "delay": [],
    "power_dyn": [],
    "leakage": [],
    "area": []
}

sixteenxsixteen_data = {
    "dimension": "16x16",
    "nodes": [45, 32, 28, 22, 16],
    "vdd": [1.0, 0.9, 0.9, 0.8, 0.7],
    "delay": [],
    "power_dyn": [],
    "leakage": [],
    "area": []
}

thirtytwoxthirtytwo_data = {
    "dimension": "32x32",
    "nodes": [45, 32, 28, 22, 16],
    "vdd": [1.0, 0.9, 0.9, 0.8, 0.7],
    "delay": [],
    "power_dyn": [],
    "leakage": [],
    "area": []
}

# Dimension list
dimensions = [fourxfour, eightxeight, sixteenxsixteen, thirtytwoxthirtytwo]
dimensions_data = [fourxfour_data, eightxeight_data, sixteenxsixteen_data, thirtytwoxthirtytwo_data]

# Scaling trends (rough approximations)
vdd_scaling = [1.0, 0.9, 0.9, 0.8, 0.7]  # Vdd typically drops
nodes_nm = [45, 32, 28, 22, 16]

data = []
for i, object in enumerate(dimensions):
    dimension_object = dimensions_data[i]
    ref_delay = object["delay"]
    ref_power_dyn = object["power_dyn"]
    ref_leakage = object["leakage"]
    ref_area = object["area"]
    
    data.append({
        "Dimension (row x column)": object["dimension"]
    })

    # Calculate scaled values
    for i in range(len(nodes_nm)):
        L = nodes_nm[i]
        Vdd = vdd_scaling[i]

        delay = ref_delay * L * Vdd
        power_dyn = ref_power_dyn * L * Vdd**2 / delay
        leakage = ref_leakage * np.exp(1.2 * (1 - Vdd)) * Vdd  # Exponential leakage model
        area = ref_area * L**2
        
        data.append({
            "Node (nm)": L,
            "Vdd (V)": round(Vdd, 3),
            "Delay (ns)": round(delay, 3),
            "Area (um^2)": round(area, 3),
            "Dynamic Power (mW)": round(power_dyn, 3),
            "Leakage Power (mW)": round(leakage, 3)
        })
        
        dimension_object["delay"].append(round(delay, 3))
        dimension_object["power_dyn"].append(round(power_dyn, 3))
        dimension_object["leakage"].append(round(leakage, 3))
        dimension_object["area"].append(round(area, 3))

x = fourxfour_data["nodes"]
delay_4 = fourxfour_data["delay"]
delay_8 = eightxeight_data["delay"]
delay_16 = sixteenxsixteen_data["delay"]
delay_32 = thirtytwoxthirtytwo_data["delay"]

plt.figure(figsize=(10, 8))

plt.subplot(1, 2, 1)
plt.plot(x, delay_4, label='4x4', marker='o', color='blue', linestyle=':')
plt.plot(x, delay_8, label='8x8', marker='o', color='orange', linestyle=':')
plt.plot(x, delay_16, label='16x16', marker='o', color='green', linestyle=':')
plt.plot(x, delay_32, label='32x32', marker='o', color='red', linestyle=':')

plt.xlabel('Node Size (nm)')
plt.ylabel('Delay (ns)')
plt.legend()
plt.title('Delay vs Node Size for Different Dimensions')


area_4 = fourxfour_data["area"]
area_8 = eightxeight_data["area"]
area_16 = sixteenxsixteen_data["area"]
area_32 = thirtytwoxthirtytwo_data["area"]

plt.subplot(1, 2, 2)
plt.plot(x, area_4, label='4x4', marker='o', color='blue', linestyle=':')
plt.plot(x, area_8, label='8x8', marker='o', color='orange', linestyle=':')
plt.plot(x, area_16, label='16x16', marker='o', color='green', linestyle=':')
plt.plot(x, area_32, label='32x32', marker='o', color='red', linestyle=':')
plt.xlabel('Node Size (nm)')
plt.ylabel('Area (um^2)')
plt.title('Area vs Node Size for Different Dimensions')
plt.legend()

plt.show()

dynamic_power_4 = fourxfour_data["power_dyn"]
dynamic_power_8 = eightxeight_data["power_dyn"]
dynamic_power_16 = sixteenxsixteen_data["power_dyn"]
dynamic_power_32 = thirtytwoxthirtytwo_data["power_dyn"]

plt.subplot(1, 2, 1)
plt.plot(x, dynamic_power_4, label='4x4', marker='o', color='blue', linestyle=':')
plt.plot(x, dynamic_power_8, label='8x8', marker='o', color='orange', linestyle=':')
plt.plot(x, dynamic_power_16, label='16x16', marker='o', color='green', linestyle=':')
plt.plot(x, dynamic_power_32, label='32x32', marker='o', color='red', linestyle=':')
plt.xlabel('Node Size (nm)')
plt.ylabel('Dynamic Power (mW)')
plt.title('Dynamic Power vs Node Size for Different Dimensions')
plt.legend()


leakage_power_4 = fourxfour_data["leakage"]
leakage_power_8 = eightxeight_data["leakage"]
leakage_power_16 = sixteenxsixteen_data["leakage"]
leakage_power_32 = thirtytwoxthirtytwo_data["leakage"]

plt.subplot(1, 2, 2)
plt.plot(x, leakage_power_4, label='4x4', marker='o', color='blue', linestyle=':')
plt.plot(x, leakage_power_8, label='8x8', marker='o', color='orange', linestyle=':')
plt.plot(x, leakage_power_16, label='16x16', marker='o', color='green', linestyle=':')
plt.plot(x, leakage_power_32, label='32x32', marker='o', color='red', linestyle=':')
plt.xlabel('Node Size (nm)')
plt.ylabel('Leakage Power (mW)')
plt.title('Leakage Power vs Node Size for Different Dimensions')
plt.legend()

plt.show()



        
        
    



df = pd.DataFrame(data)
file_path = "data/Scaling_Model_45nm.xlsx"
df.to_excel(file_path, index=False)

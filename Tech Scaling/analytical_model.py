import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Define technology nodes and corresponding voltages
nodes_nm = [45, 32, 28, 22, 16, 14, 7, 3]  # in nm
voltages = [1.0, 0.9, 0.9, 0.9, 0.9, 0.8, 0.65, 0.5]  # in V

# Assume reference values at 45nm
ref_node = 45  # nm
ref_voltage = 1.0  # V
ref_delay = 1.0  # normalized
ref_leakage = 1.0  # normalized leakage
ref_freq = 1 / ref_delay  # normalized
ref_power_dyn = 1

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

dimensions = [fourxfour, eightxeight, sixteenxsixteen, thirtytwoxthirtytwo]

# Use simple scaling models
data = []

for object in dimensions:
    dimension = object["dimension"]

    for node, vdd in zip(nodes_nm, voltages):
        scale_L = node / ref_node
        leakage = ref_leakage * np.exp(1.2 * (1 - vdd)) * vdd  # Exponential leakage model
        delay = ref_delay * scale_L * (vdd / ref_voltage)
        area = scale_L**2
        power_dyn = ref_power_dyn * scale_L * (vdd / ref_voltage)**2 / delay
        
        data.append({
            "Dimension": dimension,
            "Node (nm)": node,
            "Vdd (V)": vdd,
            "Area (um^2)": round(area * object["area"], 4),
            "Gate Delay (ns)": round(delay * object["delay"], 4),
            "Leakage Power (mW)": round(leakage * object["leakage"], 4),
            "Dynamic Power (mW)": round(power_dyn * object["power_dyn"], 4),
        })

df = pd.DataFrame(data)
file_path = f"data/analytical_model_results.xlsx"
df.to_excel(file_path, index=False)

# Plot Node Size

plt.figure(figsize=(10, 8))

delay_4 = df[df['Dimension'] == '4x4']['Gate Delay (ns)'].values
delay_8 = df[df['Dimension'] == '8x8']['Gate Delay (ns)'].values
delay_16 = df[df['Dimension'] == '16x16']['Gate Delay (ns)'].values
delay_32 = df[df['Dimension'] == '32x32']['Gate Delay (ns)'].values
x = nodes_nm

print(delay_4)

plt.plot(x, delay_4, label='4x4', marker='o', color='blue', linestyle=':')
plt.plot(x, delay_8, label='8x8', marker='o', color='orange', linestyle=':')
plt.plot(x, delay_16, label='16x16', marker='o', color='green', linestyle=':')
plt.plot(x, delay_32, label='32x32', marker='o', color='red', linestyle=':')

plt.xlabel('Node Size (nm)')
plt.ylabel('Delay (ns)')
plt.legend()
plt.title('Delay vs Node Size for Different Dimensions')

plt.show()

plt.figure(figsize=(10, 8))

area_4 = df[df['Dimension'] == '4x4']['Area (um^2)'].values
area_8 = df[df['Dimension'] == '8x8']['Area (um^2)'].values
area_16 = df[df['Dimension'] == '16x16']['Area (um^2)'].values
area_32 = df[df['Dimension'] == '32x32']['Area (um^2)'].values

plt.plot(x, area_4, label='4x4', marker='o', color='blue', linestyle=':')
plt.plot(x, area_8, label='8x8', marker='o', color='orange', linestyle=':')
plt.plot(x, area_16, label='16x16', marker='o', color='green', linestyle=':')
plt.plot(x, area_32, label='32x32', marker='o', color='red', linestyle=':')
plt.xlabel('Node Size (nm)')
plt.ylabel('Area (um^2)')
plt.title('Area vs Node Size for Different Dimensions')
plt.legend()

plt.show()

dynamic_power_4 = df[df['Dimension'] == '4x4']['Dynamic Power (mW)'].values
dynamic_power_8 = df[df['Dimension'] == '8x8']['Dynamic Power (mW)'].values
dynamic_power_16 = df[df['Dimension'] == '16x16']['Dynamic Power (mW)'].values
dynamic_power_32 = df[df['Dimension'] == '32x32']['Dynamic Power (mW)'].values

plt.plot(x, dynamic_power_4, label='4x4', marker='o', color='blue', linestyle=':')
plt.plot(x, dynamic_power_8, label='8x8', marker='o', color='orange', linestyle=':')
plt.plot(x, dynamic_power_16, label='16x16', marker='o', color='green', linestyle=':')
plt.plot(x, dynamic_power_32, label='32x32', marker='o', color='red', linestyle=':')
plt.xlabel('Node Size (nm)')
plt.ylabel('Dynamic Power (mW)')
plt.title('Dynamic Power vs Node Size for Different Dimensions')
plt.legend()

plt.show()

leakage_power_4 = df[df['Dimension'] == '4x4']['Leakage Power (mW)'].values
leakage_power_8 = df[df['Dimension'] == '8x8']['Leakage Power (mW)'].values
leakage_power_16 = df[df['Dimension'] == '16x16']['Leakage Power (mW)'].values
leakage_power_32 = df[df['Dimension'] == '32x32']['Leakage Power (mW)'].values
plt.plot(x, leakage_power_4, label='4x4', marker='o', color='blue', linestyle=':')
plt.plot(x, leakage_power_8, label='8x8', marker='o', color='orange', linestyle=':')
plt.plot(x, leakage_power_16, label='16x16', marker='o', color='green', linestyle=':')
plt.plot(x, leakage_power_32, label='32x32', marker='o', color='red', linestyle=':')
plt.ylabel('Leakage Power (mW)')
plt.title('Leakage Power vs Node Size for Different Dimensions')
plt.legend()

plt.show()

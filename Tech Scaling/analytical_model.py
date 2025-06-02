import pandas as pd
import numpy as np

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

# Dimension list
dimensions = [fourxfour, eightxeight, sixteenxsixteen, thirtytwoxthirtytwo]


# Scaling trends (rough approximations)
vdd_scaling = [1.0, 0.9, 0.9, 0.8, 0.7]  # Vdd typically drops
nodes_nm = [45, 32, 28, 22, 16]

data = []
for object in dimensions:
    
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

df = pd.DataFrame(data)
file_path = "data/Scaling_Model_45nm.xlsx"
df.to_excel(file_path, index=False)

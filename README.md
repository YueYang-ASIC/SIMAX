## SIMAX Synthesis README



Makefile-driven flow to run **Synopsys Design Compiler** on SIMAX and capture QoR/power summaries.



---



## Prerequisites



* Synopsys **Design Compiler** (`dc\\\_shell` or `dc\\\_shell -tcl`) in your `PATH`
* Standard-cell libraries (Liberty `.lib`/`.db`) referenced by your DC script
* GNU Make



---



## Project Layout



```

.

├─ rtl/                   # RTL sources

├─ filelists/

│  ├─ simax.vfs          # Verilog Filelist for Synthesis (no testbench)

│  └─ simax.vfv          # Verilog Filelist for Verification (with testbench)

├─ scripts/

│  └─ dc-template.tcl    # DC script (edit clk\\\_period here)

├─ reports/              # Generated reports (created by the flow)

├─ Makefile

└─ README.md

```



### Filelists



* **`.vfs` — Verilog Filelist for Synthesis**

  For Design Compiler. Include **RTL only**, exclude testbenches and sim-only models.

* **`.vfv` — Verilog Filelist for Verification**

  For simulation. Include **RTL + testbenches/models**.



**Examples**



```

# filelists/simax.vfs

rtl/top.v

rtl/pe.v

rtl/mesh.v

```



```

# filelists/simax.vfv

rtl/top.v

tb/top\\\_tb.v

models/sram\\\_model.v

```



---



## Configure SIMAX Parameters



Before running synthesis, confirm your SIMAX template dimensions (e.g., **rows**, **columns**, **clock cycles/latency**).

Set them via:



* Verilog `parameter` values
* `+define+MACROS` in your Makefile/DC script
* A shared config header (e.g., `config.vh`)



---



## Quick Start (Synthesis)



1\. **Navigate** to your synthesis folder (project root with the `Makefile`).

2\. **Edit** `filelists/\\\*.vfs` (synthesis) and `filelists/\\\*.vfv` (verification) as needed.

3\. **Check** SIMAX dimensions (rows/cols/cycles) match your intended configuration.

4\. **Run**:



   ```bash

   make NAME=top synth

   ```



   Replace `top` with your top-level module name if different.

5\. **Review output**: QoR and power are printed to terminal **and** saved to:



   ```

   reports/top.rpt

   ```

6\. **Adjust clock** based on slack. Edit `scripts/dc-template.tcl`:



   ```tcl

   set clk\_period 1.500   ;# ns

   ```



   \* Negative slack ⇒ increase `clk\\\_period` (slow down).

   \* Comfortable positive slack ⇒ try decreasing `clk\\\_period` (speed up).

     Re-run `make NAME=top synth`.



---



## Outputs



Typical artifacts (paths may vary by Makefile):



```

reports/top.rpt        # Combined QoR + power summary

reports/area.rpt       # Detailed area

reports/timing.rpt     # Detailed timing

out/top.ddc            # Compiled design (DC database)

```



Quick peek:



```bash

grep -E "WNS|TNS|Violating|Total Power|Cell Leakage" reports/top.rpt

```



---



## Notes on Power



* Without SAIF/VCD, DC reports **vectorless** power.
* For better fidelity, annotate activity (SAIF/VCD) in `dc-template.tcl` before `report\\\_power`.



---



## Common Make Targets



```bash

make NAME=top synth     # run synthesis

make NAME=top clean     # remove generated outputs

```



---



## Troubleshooting



* **Unresolved modules**: Fix paths/entries in `.vfs`.
* **Top not found**: Ensure `NAME=<top\\\_module>` matches your RTL top.
* **Negative slack**: Relax `clk\\\_period` or optimize constraints/RTL.
* **No power report**: Confirm libraries include power data and script calls `report\\\_power`.



---



## (Optional) Append a Compact Summary to `top.rpt`



Add near the end of `scripts/dc-template.tcl`:



```tcl

redirect -append reports/top.rpt {

\\\&nbsp; puts ""

\\\&nbsp; puts "\\\\\\\[clock format \\\\\\\[clock seconds] -format {%Y-%m-%d %H:%M:%S}] Summary"

\\\&nbsp; report\\\_qor -nosplit

\\\&nbsp; catch { report\\\_power -analysis\\\_effort low -significant\\\_digits 3 -nosplit }

}

```



This keeps a human-readable snapshot (QoR and power) in one place for each run.


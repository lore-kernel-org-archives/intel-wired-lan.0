From: Koehrer Mathias (ETAS/ESW5) <mathias.koehrer@etas.com>
Date: Fri, 14 Oct 2016 08:58:22 +0000
Subject: [Intel-wired-lan] Kernel 4.6.7-rt13: Intel Ethernet driver igb
 causes huge latencies in cyclictest
In-Reply-To: <20161013161839.GV10625@jcartwri.amer.corp.natinst.com>
References: <487032ca81f84e70bdacc39a024eff5e@FE-MBX1012.de.bosch.com>
 <20161004193445.GF10625@jcartwri.amer.corp.natinst.com>
 <584755c2766e4b94a604ece16760fe14@FE-MBX1012.de.bosch.com>
 <20161005155959.GH10625@jcartwri.amer.corp.natinst.com>
 <13c3cd3ffee4490fb22b8de383e51361@FE-MBX1012.de.bosch.com>
 <AAEA33E297BCAC4B9BB20A7C2DF0AB8D8045E418@FMSMSX113.amr.corp.intel.com>
 <29250f87b1d84aacb8aa312935582291@FE-MBX1012.de.bosch.com>
 <20161010193958.GE22235@jcartwri.amer.corp.natinst.com>
 <e9661abf93194ad3849e3864a8361993@FE-MBX1012.de.bosch.com>
 <b77ea8ab312149d2b20a717d3ab0a8dc@FE-MBX1012.de.bosch.com>
 <20161013161839.GV10625@jcartwri.amer.corp.natinst.com>
Message-ID: <f395ea6cd1274fac83d2744121da7441@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Julia,
> Have you tested on a vanilla (non-RT) kernel?  I doubt there is anything RT specific
> about what you are seeing, but it might be nice to get confirmation.  Also, bisection
> would probably be easier if you confirm on a vanilla kernel.
> 
> I find it unlikely that it's a kernel config option that changed which regressed you, but
> instead was a code change to a driver.  Which driver is now the question, and the
> surface area is still big (processor mapping attributes for this region, PCI root
> complex configuration, PCI brige configuration, igb driver itself, etc.).
> 
> Big enough that I'd recommend a bisection.  It looks like a bisection between 3.18
> and 4.8 would take you about 18 tries to narrow down, assuming all goes well.
> 

I have now repeated my tests using the vanilla kernel.
There I got the very same issue.
Using kernel 4.0 is fine, however starting with kernel 4.1, the issue appears.


Here is my exact (reproducible) test description:
I applied the following patch to the kernel to get the igb trace.
This patch instruments the igb_rd32() function to measure the call
to readl() which is used to access registers of the igb NIC.


++++++++++++++++++ BEGIN PATCH ++++++++++++++++++++++++++++++++++++

Index: linux-4.8/drivers/net/ethernet/intel/igb/trace.h
===================================================================
--- /dev/null
+++ linux-4.8/drivers/net/ethernet/intel/igb/trace.h
@@ -0,0 +1,34 @@
+
+#if !defined(_TRACE_IGB_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IGB_H_ 
+
+#include <linux/tracepoint.h>
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM igb
+
+
+#define _TRACE_H_
+
+
+TRACE_EVENT(igb,
+        TP_PROTO(u32 val),
+        TP_ARGS(val),
+        TP_STRUCT__entry(
+                __field(u32, val)
+        ),
+        TP_fast_assign(
+                __entry->val = val;
+        ),
+        TP_printk("val: %u",
+                   __entry->val)
+);
+
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH drivers/net/ethernet/intel/igb 
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
Index: linux-4.8/drivers/net/ethernet/intel/igb/Makefile
===================================================================
--- linux-4.8.orig/drivers/net/ethernet/intel/igb/Makefile
+++ linux-4.8/drivers/net/ethernet/intel/igb/Makefile
@@ -28,6 +28,7 @@
 #
 # Makefile for the Intel(R) 82575 PCI-Express ethernet driver
 #
+ccflags-y += -I.
 
 obj-$(CONFIG_IGB) += igb.o
 
Index: linux-4.8/drivers/net/ethernet/intel/igb/igb_main.c
===================================================================
--- linux-4.8.orig/drivers/net/ethernet/intel/igb/igb_main.c
+++ linux-4.8/drivers/net/ethernet/intel/igb/igb_main.c
@@ -57,6 +57,9 @@
 #include <linux/i2c.h>
 #include "igb.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 #define MAJ 5
 #define MIN 3
 #define BUILD 0
@@ -753,7 +756,9 @@ u32 igb_rd32(struct e1000_hw *hw, u32 re
 	if (E1000_REMOVED(hw_addr))
 		return ~value;
 
+        trace_igb(801);
 	value = readl(&hw_addr[reg]);
+        trace_igb(802);
 
 	/* reads should not return all F's */
 	if (!(~value) && (!reg || !(~readl(hw_addr)))) {


++++++++++++++++++ END PATCH ++++++++++++++++++++++++++++++++++++


I build the kernel with this patch applied, rebooted the PC to run this kernel and used the 
following script for my test.

++++++++++++++++++ BEGIN SCRIPT  +++++++++++++++++++++++++++++++++
#!/bin/bash

for f in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_governor ; do
    if [ -w $f ]; then
        echo "performance" > $f
    fi
done

if true; then
    rmmod igb
    modprobe igb
    ethtool -L eth2 combined 1
    ifconfig eth2 up 192.168.100.111
fi

ifconfig

mount /sys/kernel/debug

( cd /sys/kernel/debug/tracing
  echo 0 > tracing_on
  echo 0 > events/enable
  echo 1 > events/igb/enable
  echo "print-parent" > trace_options
  echo "latency-format" > trace_options
  echo 1 > tracing_on

  sleep 4
  cat trace
)
++++++++++++++++++ END SCRIPT  +++++++++++++++++++++++++++++++++

The results of this for kernel 4.0:
[...]
kworker/-1239    3...1 49699046us : igb: val: 801
kworker/-1239    3...1 49699047us : igb: val: 802
kworker/-1239    3...1 49699047us : igb: val: 801
kworker/-1239    3...1 49699048us+: igb: val: 802
kworker/-1239    3...1 49699099us : igb: val: 801
kworker/-1239    3...1 49699100us : igb: val: 802
kworker/-1239    3...1 49699100us : igb: val: 801
kworker/-1239    3...1 49699102us : igb: val: 802
kworker/-1239    3...1 49699102us : igb: val: 801
kworker/-1239    3...1 49699103us : igb: val: 802
kworker/-1239    3...1 49699103us : igb: val: 801
kworker/-1239    3...1 49699104us : igb: val: 802
kworker/-1239    3...1 49699104us : igb: val: 801
kworker/-1239    3...1 49699105us : igb: val: 802
kworker/-1239    3...1 49699105us : igb: val: 801
kworker/-1239    3...1 49699107us : igb: val: 802
kworker/-1239    3...1 49699107us : igb: val: 801
kworker/-1239    3...1 49699108us : igb: val: 802
kworker/-1239    3...1 49699108us : igb: val: 801
kworker/-1239    3...1 49699109us : igb: val: 802
kworker/-1239    3...1 49699109us : igb: val: 801
kworker/-1239    3...1 49699110us : igb: val: 802
kworker/-1239    3...1 49699110us : igb: val: 801
kworker/-1239    3...1 49699111us : igb: val: 802
kworker/-1239    3...1 49699111us : igb: val: 801
kworker/-1239    3...1 49699113us+: igb: val: 802
kworker/-1239    3...1 49699163us : igb: val: 801
kworker/-1239    3...1 49699164us : igb: val: 802
kworker/-1239    3...1 49699164us : igb: val: 801
kworker/-1239    3...1 49699166us : igb: val: 802
kworker/-1239    3...1 49699166us : igb: val: 801
kworker/-1239    3...1 49699167us : igb: val: 802
kworker/-1239    3...1 49699167us : igb: val: 801
kworker/-1239    3...1 49699168us : igb: val: 802
kworker/-1239    3...1 49699168us : igb: val: 801
kworker/-1239    3...1 49699169us : igb: val: 802
kworker/-1239    3...1 49699169us : igb: val: 801
kworker/-1239    3...1 49699170us : igb: val: 802
kworker/-1239    3...1 49699171us : igb: val: 801
kworker/-1239    3...1 49699173us : igb: val: 802
kworker/-1239    3...1 49699173us : igb: val: 801
kworker/-1239    3...1 49699174us : igb: val: 802





The results of this for kernel 4.1:
[...]
kworker/-1333    2...1 75697302us+: igb: val: 801
kworker/-1333    2...1 75697323us+: igb: val: 802
kworker/-1333    2...1 75697373us+: igb: val: 801
kworker/-1333    2...1 75697395us : igb: val: 802
kworker/-1333    2...1 75697395us+: igb: val: 801
kworker/-1333    2...1 75697415us : igb: val: 802
kworker/-1333    2...1 75697416us+: igb: val: 801
kworker/-1333    2...1 75697436us : igb: val: 802
kworker/-1333    2...1 75697436us+: igb: val: 801
kworker/-1333    2...1 75697457us : igb: val: 802
kworker/-1333    2...1 75697457us+: igb: val: 801
kworker/-1333    2...1 75697478us : igb: val: 802
kworker/-1333    2...1 75697478us+: igb: val: 801
kworker/-1333    2...1 75697499us : igb: val: 802
kworker/-1333    2...1 75697499us+: igb: val: 801
kworker/-1333    2...1 75697520us : igb: val: 802
kworker/-1333    2...1 75697520us+: igb: val: 801
kworker/-1333    2...1 75697541us : igb: val: 802
kworker/-1333    2...1 75697541us+: igb: val: 801
kworker/-1333    2...1 75697562us : igb: val: 802
kworker/-1333    2...1 75697562us+: igb: val: 801
kworker/-1333    2...1 75697583us : igb: val: 802
kworker/-1333    2...1 75697583us+: igb: val: 801
kworker/-1333    2...1 75697604us+: igb: val: 802
kworker/-1333    2...1 75697654us+: igb: val: 801
kworker/-1333    2...1 75697675us : igb: val: 802
kworker/-1333    2...1 75697675us+: igb: val: 801
kworker/-1333    2...1 75697696us : igb: val: 802
kworker/-1333    2...1 75697696us+: igb: val: 801
kworker/-1333    2...1 75697717us : igb: val: 802
kworker/-1333    2...1 75697717us+: igb: val: 801
kworker/-1333    2...1 75697738us : igb: val: 802
kworker/-1333    2...1 75697738us+: igb: val: 801
kworker/-1333    2...1 75697759us : igb: val: 802
kworker/-1333    2...1 75697759us+: igb: val: 801
kworker/-1333    2...1 75697780us : igb: val: 802
kworker/-1333    2...1 75697781us+: igb: val: 801
kworker/-1333    2...1 75697801us : igb: val: 802
kworker/-1333    2...1 75697801us+: igb: val: 801
kworker/-1333    2...1 75697822us : igb: val: 802


It can be cleary seen that with the kernel 4.1 the time for the execution of the "readl"
function is much slower! It tasks always about 21us!
In comparison to that the kernel 4.0 is fast. Here the time for "readl" is about
1-2 us.
All measurements have been done on the very same PC.
The PC is an HP EliteDesk 800 G1, 
a dual port Intel i350-T2 server adapter has been plugged in.
CPU: Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
x86_64 bit mode.

Please find attached the kernel configuration for the 4.1 kernel.

I had a look at the generated .o file of igb_main.o.
However, in both cases - kernel 4.0 and kernel 4.1 - the code for the 
igb_rd32 function looks the same.
Especially the call to the readl() function is the very same.

This means, that I think that some other stuff in kernel 4.1 has changed,
which has impact on the igb accesses.

Any idea what component could cause this kind of issue?

Thanks for any feedback!

Regards

Mathias

-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/x-gzip
Size: 23977 bytes
Desc: config.gz
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161014/40092abf/attachment-0001.bin>

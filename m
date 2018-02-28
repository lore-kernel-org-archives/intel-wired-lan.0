From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 28 Feb 2018 09:50:26 -0800
Subject: [Intel-wired-lan] [PATCH 2/8] Documentation: igb: Update kernel
 documentation
In-Reply-To: <20180228175032.11148-1-jeffrey.t.kirsher@intel.com>
References: <20180228175032.11148-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180228175032.11148-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Updated the igb.txt kernel documentation with the latest information.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 Documentation/networking/igb.txt | 282 +++++++++++++++++++++++++++------------
 1 file changed, 196 insertions(+), 86 deletions(-)

diff --git a/Documentation/networking/igb.txt b/Documentation/networking/igb.txt
index f90643ef39c9..11521b14c247 100644
--- a/Documentation/networking/igb.txt
+++ b/Documentation/networking/igb.txt
@@ -2,7 +2,7 @@ Linux* Base Driver for Intel(R) Ethernet Network Connection
 ===========================================================
 
 Intel Gigabit Linux driver.
-Copyright(c) 1999 - 2013 Intel Corporation.
+Copyright(c) 1999-2018 Intel Corporation.
 
 Contents
 ========
@@ -12,118 +12,228 @@ Contents
 - Support
 
 Identifying Your Adapter
-========================
+------------------------
+For information on how to identify your adapter, and for the latest Intel
+network drivers, refer to the Intel Support website:
+http://www.intel.com/support
 
-This driver supports all 82575, 82576 and 82580-based Intel (R) gigabit network
-connections.
-
-For specific information on how to identify your adapter, go to the Adapter &
-Driver ID Guide at:
-
-    http://support.intel.com/support/go/network/adapter/idguide.htm
 
 Command Line Parameters
-=======================
-
+-----------------------
+If the driver is built as a module, the following optional parameters are used
+by entering them on the command line with the modprobe command using this
+syntax:
+modprobe igb [<option>=<VAL1>,<VAL2>,...]
+
+There needs to be a <VAL#> for each network port in the system supported by
+this driver. The values will be applied to each instance, in function order.
+For example:
+modprobe igb InterruptThrottleRate=16000,16000
+
+In this case, there are two network ports supported by igb in the system.
 The default value for each parameter is generally the recommended setting,
 unless otherwise noted.
 
-max_vfs
--------
-Valid Range:   0-7
-Default Value: 0
-
-This parameter adds support for SR-IOV.  It causes the driver to spawn up to
-max_vfs worth of virtual function.
-
-Additional Configurations
-=========================
-
-  Jumbo Frames
-  ------------
-  Jumbo Frames support is enabled by changing the MTU to a value larger than
-  the default of 1500.  Use the ip command to increase the MTU size.
-  For example:
+NOTE: For more information about the command line parameters, see the
+application note at: http://www.intel.com/design/network/applnots/ap450.htm.
 
-       ip link set dev eth<x> mtu 9000
+NOTE: A descriptor describes a data buffer and attributes related to the data
+buffer. This information is accessed by the hardware.
 
-  This setting is not saved across reboots.
 
-  Notes:
-
-  - The maximum MTU setting for Jumbo Frames is 9216.  This value coincides
-    with the maximum Jumbo Frames size of 9234 bytes.
+max_vfs
+-------
+This parameter adds support for SR-IOV. It causes the driver to spawn up to
+max_vfs worth of virtual functions.
+Valid Range: 0-7
+If the value is greater than 0 it will also force the VMDq parameter to be 1 or
+more.
+
+The parameters for the driver are referenced by position. Thus, if you have a
+dual port adapter, or more than one adapter in your system, and want N virtual
+functions per port, you must specify a number for each port with each parameter
+separated by a comma. For example:
+
+  modprobe igb max_vfs=4
+
+This will spawn 4 VFs on the first port.
+
+  modprobe igb max_vfs=2,4
+
+This will spawn 2 VFs on the first port and 4 VFs on the second port.
+
+NOTE: Caution must be used in loading the driver with these parameters.
+Depending on your system configuration, number of slots, etc., it is impossible
+to predict in all cases where the positions would be on the command line.
+
+NOTE: Neither the device nor the driver control how VFs are mapped into config
+space. Bus layout will vary by operating system. On operating systems that
+support it, you can check sysfs to find the mapping.
+
+NOTE: When either SR-IOV mode or VMDq mode is enabled, hardware VLAN filtering
+and VLAN tag stripping/insertion will remain enabled. Please remove the old
+VLAN filter before the new VLAN filter is added. For example,
+ip link set eth0 vf 0 vlan 100	// set vlan 100 for VF 0
+ip link set eth0 vf 0 vlan 0	// Delete vlan 100
+ip link set eth0 vf 0 vlan 200	// set a new vlan 200 for VF 0
+
+
+QueuePairs
+----------
+Valid Range: 0-1
+If set to 0, when MSI-X is enabled, the Tx and Rx will attempt to occupy
+separate vectors.
+This option can be overridden to 1 if there are not sufficient interrupts
+available. This can occur if any combination of RSS, VMDQ, and max_vfs results
+in more than 4 queues being used.
+
+
+Node
+----
+Valid Range: 0-n
+0 - n: where n is the number of the NUMA node that should be used to allocate
+memory for this adapter port.
+-1: uses the driver default of allocating memory on whichever processor is
+running modprobe.
+The Node parameter allows you to choose which NUMA node you want to have the
+adapter allocate memory from. All driver structures, in-memory queues, and
+receive buffers will be allocated on the node specified. This parameter is
+only useful when interrupt affinity is specified; otherwise, part of the
+interrupt time could run on a different core than where the memory is
+allocated causing slower memory access and impacting throughput, CPU, or both.
+
+
+EEE
+---
+Valid Range: 0-1
+0 = Disables EEE
+1 = Enables EEE
+A link between two EEE-compliant devices will result in periodic bursts of
+data followed by periods where the link is in an idle state. This Low Power
+Idle (LPI) state is supported in both 1 Gbps and 100 Mbps link speeds.
+
+
+DMAC
+----
+Valid Range: 0, 1, 250, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000,
+9000, 10000
+This parameter enables or disables DMA Coalescing feature. Values are in
+microseconds and set the internal DMA Coalescing internal timer.
+DMA (Direct Memory Access) allows the network device to move packet data
+directly to the system's memory, reducing CPU utilization. However, the
+frequency and random intervals at which packets arrive do not allow the system
+to enter a lower power state. DMA Coalescing allows the adapter to collect
+packets before it initiates a DMA event. This may increase network latency but
+also increases the chances that the system will enter a lower power state.
+Turning on DMA Coalescing may save energy with kernel 2.6.32 and newer. DMA
+Coalescing must be enabled across all active ports in order to save platform
+power.
+
+
+Additional Features and Configurations
+-------------------------------------------
+
+Jumbo Frames
+------------
+Jumbo Frames support is enabled by changing the Maximum Transmission Unit (MTU)
+to a value larger than the default value of 1500.
+
+Use the ifconfig command to increase the MTU size. For example, enter the
+following where <x> is the interface number:
+
+   ifconfig eth<x> mtu 9000 up
+Alternatively, you can use the ip command as follows:
+   ip link set mtu 9000 dev eth<x>
+   ip link set up dev eth<x>
+
+This setting is not saved across reboots. The setting change can be made
+permanent by adding 'MTU=9000' to the file:
+/etc/sysconfig/network-scripts/ifcfg-eth<x> for RHEL or to the file
+/etc/sysconfig/network/<config_file> for SLES.
+
+NOTE: The maximum MTU setting for Jumbo Frames is 9216. This value coincides
+with the maximum Jumbo Frames size of 9234 bytes.
+
+NOTE: Using Jumbo frames at 10 or 100 Mbps is not supported and may result in
+poor performance or loss of link.
+
+
+ethtool
+-------
+The driver utilizes the ethtool interface for driver configuration and
+diagnostics, as well as displaying statistical information. The latest ethtool
+version is required for this functionality. Download it at:
+http://ftp.kernel.org/pub/software/network/ethtool/
 
-  - Using Jumbo frames at 10 or 100 Mbps is not supported and may result in
-    poor performance or loss of link.
 
-  ethtool
-  -------
-  The driver utilizes the ethtool interface for driver configuration and
-  diagnostics, as well as displaying statistical information. The latest
-  version of ethtool can be found at:
+Enabling Wake on LAN* (WoL)
+---------------------------
+WoL is configured through the ethtool* utility. ethtool is included with all
+versions of Red Hat after Red Hat 7.2. For other Linux distributions, download
+and install ethtool from the following website:
+http://ftp.kernel.org/pub/software/network/ethtool/.
 
-  https://www.kernel.org/pub/software/network/ethtool/
+For instructions on enabling WoL with ethtool, refer to the website listed
+above.
 
-  Enabling Wake on LAN* (WoL)
-  ---------------------------
-  WoL is configured through the ethtool* utility.
+WoL will be enabled on the system during the next shut down or reboot. For
+this driver version, in order to enable WoL, the igb driver must be loaded
+prior to shutting down or suspending the system.
 
-  For instructions on enabling WoL with ethtool, refer to the ethtool man page.
+NOTES:
+- Wake on LAN is only supported on port A of multi-port devices.
+- Wake On LAN is not supported for the Intel(R) Gigabit VT Quad Port Server
+  Adapter.
 
-  WoL will be enabled on the system during the next shut down or reboot.
-  For this driver version, in order to enable WoL, the igb driver must be
-  loaded when shutting down or rebooting the system.
 
-  Wake On LAN is only supported on port A of multi-port adapters.
+Multiqueue
+----------
+In this mode, a separate MSI-X vector is allocated for each queue and one for
+"other" interrupts such as link status change and errors. All interrupts are
+throttled via interrupt moderation. Interrupt moderation must be used to avoid
+interrupt storms while the driver is processing one interrupt. The moderation
+value should be at least as large as the expected time for the driver to
+process an interrupt. Multiqueue is off by default.
 
-  Wake On LAN is not supported for the Intel(R) Gigabit VT Quad Port Server
-  Adapter.
+REQUIREMENTS: MSI-X support is required for Multiqueue. If MSI-X is not found,
+the system will fallback to MSI or to Legacy interrupts. This driver supports
+multiqueue in kernel versions 2.6.24 and newer. This driver supports receive
+multiqueue on all kernels that support MSI-X.
 
-  Multiqueue
-  ----------
-  In this mode, a separate MSI-X vector is allocated for each queue and one
-  for "other" interrupts such as link status change and errors.  All
-  interrupts are throttled via interrupt moderation.  Interrupt moderation
-  must be used to avoid interrupt storms while the driver is processing one
-  interrupt.  The moderation value should be at least as large as the expected
-  time for the driver to process an interrupt. Multiqueue is off by default.
+NOTES:
+- Do not use MSI-X with the 2.6.19 or 2.6.20 kernels.
+- On some kernels a reboot is required to switch between single queue mode
+and multiqueue mode or vice-versa.
 
-  REQUIREMENTS: MSI-X support is required for Multiqueue. If MSI-X is not
-  found, the system will fallback to MSI or to Legacy interrupts.
 
-  MAC and VLAN anti-spoofing feature
-  ----------------------------------
-  When a malicious driver attempts to send a spoofed packet, it is dropped by
-  the hardware and not transmitted.  An interrupt is sent to the PF driver
-  notifying it of the spoof attempt.
+MAC and VLAN anti-spoofing feature
+----------------------------------
+When a malicious driver attempts to send a spoofed packet, it is dropped by the
+hardware and not transmitted.
 
-  When a spoofed packet is detected the PF driver will send the following
-  message to the system log (displayed by  the "dmesg" command):
+An interrupt is sent to the PF driver notifying it of the spoof attempt. When a
+spoofed packet is detected, the PF driver will send the following message to
+the system log (displayed by the "dmesg" command):
+Spoof event(s) detected on VF(n), where n = the VF that attempted to do the
+spoofing
 
-  Spoof event(s) detected on VF(n)
 
-  Where n=the VF that attempted to do the spoofing.
 
-  Setting MAC Address, VLAN and Rate Limit Using IProute2 Tool
-  ------------------------------------------------------------
-  You can set a MAC address of a Virtual Function (VF), a default VLAN and the
-  rate limit using the IProute2 tool. Download the latest version of the
-  iproute2 tool from Sourceforge if your version does not have all the
-  features you require.
+Setting MAC Address, VLAN and Rate Limit Using IProute2 Tool
+------------------------------------------------------------
+You can set a MAC address of a Virtual Function (VF), a default VLAN and the
+rate limit using the IProute2 tool. Download the latest version of the
+IProute2 tool from Sourceforge if your version does not have all the features
+you require.
 
 
 Support
-=======
-
+-------
 For general information, go to the Intel support website at:
-
-    www.intel.com/support/
+http://www.intel.com/support/
 
 or the Intel Wired Networking project hosted by Sourceforge at:
-
-    http://sourceforge.net/projects/e1000
-
-If an issue is identified with the released source code on the supported
-kernel with a supported adapter, email the specific information related
-to the issue to e1000-devel at lists.sf.net
+http://sourceforge.net/projects/e1000
+If an issue is identified with the released source code on a supported kernel
+with a supported adapter, email the specific information related to the issue
+to e1000-devel at lists.sf.net.
-- 
2.14.3


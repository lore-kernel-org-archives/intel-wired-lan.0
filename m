From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 19 Jul 2019 11:33:14 -0700
Subject: [Intel-wired-lan] [PATCH] Documentation: iavf: Update the Intel LAN
 driver doc for iavf
Message-ID: <20190719183314.31728-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update the LAN driver documentation to include the latest feature
implementation and driver capabilities.

Singed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 .../networking/device_drivers/intel/iavf.rst  | 331 ++++++++++++++++--
 1 file changed, 298 insertions(+), 33 deletions(-)

diff --git a/Documentation/networking/device_drivers/intel/iavf.rst b/Documentation/networking/device_drivers/intel/iavf.rst
index 2d0c3baa1752..c587a3609c1c 100644
--- a/Documentation/networking/device_drivers/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/intel/iavf.rst
@@ -10,11 +10,15 @@ Copyright(c) 2013-2018 Intel Corporation.
 Contents
 ========
 
+- Overview
 - Identifying Your Adapter
 - Additional Configurations
 - Known Issues/Troubleshooting
 - Support
 
+Overview
+========
+
 This file describes the iavf Linux* Base Driver. This driver was formerly
 called i40evf.
 
@@ -27,6 +31,7 @@ The guest OS loading the iavf driver must support MSI-X interrupts.
 
 Identifying Your Adapter
 ========================
+
 The driver in this kernel is compatible with devices based on the following:
  * Intel(R) XL710 X710 Virtual Function
  * Intel(R) X722 Virtual Function
@@ -50,9 +55,10 @@ Link messages will not be displayed to the console if the distribution is
 restricting system messages. In order to see network driver link messages on
 your console, set dmesg to eight by entering the following::
 
-  dmesg -n 8
+    # dmesg -n 8
 
-NOTE: This setting is not saved across reboots.
+NOTE:
+  This setting is not saved across reboots.
 
 ethtool
 -------
@@ -72,11 +78,11 @@ then requests from that VF to set VLAN tag stripping will be ignored.
 To enable/disable VLAN tag stripping for a VF, issue the following command
 from inside the VM in which you are running the VF::
 
-  ethtool -K <if_name> rxvlan on/off
+    # ethtool -K <if_name> rxvlan on/off
 
 or alternatively::
 
-  ethtool --offload <if_name> rxvlan on/off
+    # ethtool --offload <if_name> rxvlan on/off
 
 Adaptive Virtual Function
 -------------------------
@@ -91,21 +97,21 @@ additional features depending on what features are available in the PF with
 which the AVF is associated. The following are base mode features:
 
 - 4 Queue Pairs (QP) and associated Configuration Status Registers (CSRs)
-  for Tx/Rx.
-- i40e descriptors and ring format.
-- Descriptor write-back completion.
-- 1 control queue, with i40e descriptors, CSRs and ring format.
-- 5 MSI-X interrupt vectors and corresponding i40e CSRs.
-- 1 Interrupt Throttle Rate (ITR) index.
-- 1 Virtual Station Interface (VSI) per VF.
+  for Tx/Rx
+- i40e descriptors and ring format
+- Descriptor write-back completion
+- 1 control queue, with i40e descriptors, CSRs and ring format
+- 5 MSI-X interrupt vectors and corresponding i40e CSRs
+- 1 Interrupt Throttle Rate (ITR) index
+- 1 Virtual Station Interface (VSI) per VF
 - 1 Traffic Class (TC), TC0
 - Receive Side Scaling (RSS) with 64 entry indirection table and key,
-  configured through the PF.
-- 1 unicast MAC address reserved per VF.
-- 16 MAC address filters for each VF.
-- Stateless offloads - non-tunneled checksums.
-- AVF device ID.
-- HW mailbox is used for VF to PF communications (including on Windows).
+  configured through the PF
+- 1 unicast MAC address reserved per VF
+- 16 MAC address filters for each VF
+- Stateless offloads - non-tunneled checksums
+- AVF device ID
+- HW mailbox is used for VF to PF communications (including on Windows)
 
 IEEE 802.1ad (QinQ)?Support
 ---------------------------
@@ -117,8 +123,8 @@ VLAN ID, among other uses.
 
 The following are examples of how to configure 802.1ad (QinQ)::
 
-  ip link add link eth0 eth0.24 type vlan proto 802.1ad id 24
-  ip link add link eth0.24 eth0.24.371 type vlan proto 802.1Q id 371
+    # ip link add link eth0 eth0.24 type vlan proto 802.1ad id 24
+    # ip link add link eth0.24 eth0.24.371 type vlan proto 802.1Q id 371
 
 Where "24" and "371" are example VLAN IDs.
 
@@ -133,6 +139,19 @@ specific application. This can reduce latency for the specified application,
 and allow Tx traffic to be rate limited per application. Follow the steps below
 to set ADq.
 
+Requirements:
+
+- The sch_mqprio, act_mirred and cls_flower modules must be loaded
+- The latest version of iproute2
+- If another driver (for example, DPDK) has set cloud filters, you cannot
+  enable ADQ
+- Depending on the underlying PF device, ADQ cannot be enabled when the
+  following features are enabled:
+
+  + Data Center Bridging (DCB)
+  + Multiple Functions per Port (MFP)
+  + Sideband Filters
+
 1. Create traffic classes (TCs). Maximum of 8 TCs can be created per interface.
 The shaper bw_rlimit parameter is optional.
 
@@ -141,9 +160,9 @@ to 1Gbit for tc0 and 3Gbit for tc1.
 
 ::
 
-  # tc qdisc add dev <interface> root mqprio num_tc 2 map 0 0 0 0 1 1 1 1
-  queues 16 at 0 16 at 16 hw 1 mode channel shaper bw_rlimit min_rate 1Gbit 2Gbit
-  max_rate 1Gbit 3Gbit
+    tc qdisc add dev <interface> root mqprio num_tc 2 map 0 0 0 0 1 1 1 1
+    queues 16 at 0 16 at 16 hw 1 mode channel shaper bw_rlimit min_rate 1Gbit 2Gbit
+    max_rate 1Gbit 3Gbit
 
 map: priority mapping for up to 16 priorities to tcs (e.g. map 0 0 0 0 1 1 1 1
 sets priorities 0-3 to use tc0 and 4-7 to use tc1)
@@ -162,6 +181,10 @@ Totals must be equal or less than port speed.
 For example: min_rate 1Gbit 3Gbit: Verify bandwidth limit using network
 monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
 
+NOTE:
+  Setting up channels via ethtool (ethtool -L) is not supported when the
+  TCs are configured using mqprio.
+
 2. Enable HW TC offload on interface::
 
     # ethtool -K <interface> hw-tc-offload on
@@ -171,16 +194,16 @@ monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
     # tc qdisc add dev <interface> ingress
 
 NOTES:
- - Run all tc commands from the iproute2 <pathtoiproute2>/tc/ directory.
- - ADq is not compatible with cloud filters.
+ - Run all tc commands from the iproute2 <pathtoiproute2>/tc/ directory
+ - ADq is not compatible with cloud filters
  - Setting up channels via ethtool (ethtool -L) is not supported when the TCs
-   are configured using mqprio.
+   are configured using mqprio
  - You must have iproute2 latest version
- - NVM version 6.01 or later is required.
+ - NVM version 6.01 or later is required
  - ADq cannot be enabled when any the following features are enabled: Data
-   Center Bridging (DCB), Multiple Functions per Port (MFP), or Sideband Filters.
+   Center Bridging (DCB), Multiple Functions per Port (MFP), or Sideband Filters
  - If another driver (for example, DPDK) has set cloud filters, you cannot
-   enable ADq.
+   enable ADq
  - Tunnel filters are not supported in ADq. If encapsulated packets do arrive
    in non-tunnel mode, filtering will be done on the inner headers.  For example,
    for VXLAN traffic in non-tunnel mode, PCTYPE is identified as a VXLAN
@@ -194,10 +217,236 @@ NOTES:
    traffic will be duplicated and sent to all matching TC queues.  The hardware
    switch mirrors the packet to a VSI list when multiple filters are matched.
 
+SR-IOV Hypervisor Management Interface
+--------------------------------------
+The sysfs file structure below supports the SR-IOV hypervisor management
+interface.
+
+| /sys/class/net/<interface-name>/device/sriov (see [1]_)
+| +-- [VF-id, 0 .. 127] (see [2]_)
+| | +-- trunk
+| | +-- vlan_mirror
+| | +-- engress_mirror
+| | +-- ingress_mirror
+| | +-- mac_anti_spoof
+| | +-- vlan_anti_spoof
+| | +-- loopback
+| | +-- mac
+| | +-- mac_list
+| | +-- promisc
+| | +-- vlan_strip
+| | +-- stats
+| | +-- link_state
+| | +-- max_tx_rate
+| | +-- min_tx_rate
+| | +-- spoofcheck
+| | +-- trust
+| | +-- vlan
+
+.. [1] kobject started from ?sriov? is not available from existing kernel
+   sysfs, and it requires device driver to implement this interface.
+.. [2] assume maximum # of VF supported by a PF is 128. To support a device
+   that supports more than 128 SR-IOV instances, a ?vfx? is added to 0..127.
+   With ?vfx? kboject, users need to add vf index as the first parameter and
+   followed by ?:?.
+
+SR-IOV hypervisor functions:
+
+trunk
+    Supports two operations: add and rem
+   
+    - add: adds one or more VLAN id into VF VLAN filtering.
+    - rem: removes VLAN ids from the VF VLAN filtering list.
+
+Example 1: add multiple VLAN tags, VLANs 2,4,5,10-20, by PF, p1p2, on
+a selected VF, 1, for filtering, with the sysfs support::
+
+    # echo add 2,4,5,10-20 > /sys/class/net/p1p2/device/sriov/1/trunk
+
+Example 2: remove VLANs 5, 11-13 from PF p1p2 VF 1 with sysfs::
+
+    # echo rem 5,11-13 > /sys/class/net/p1p2/device/sriov/1/trunk
+
+Note:
+  For rem, if VLAN id is not on the VLAN filtering list, the VLAN id will
+  be ignored.
+
+vlan_mirror
+    Supports both ingress and egress traffic mirroring.
+
+Example 1: mirror traffic based upon VLANs 2,4,6,18-22 to VF 3 of PF p1p1::
+
+    # echo add 2,4,6,18-22 > /sys/class/net/p1p1/device/sriov/3/vlan_mirror
+
+Example 2: remove VLAN 4, 15-17 from traffic mirroring at destination VF 3::
+
+    # echo rem 15-17 > /sys/class/net/p1p1/device/sriov/3/vlan_mirror
+
+Example 3: remove all VLANs from mirroring at VF 3::
+
+    # echo rem 0 - 4095> /sys/class/net/p1p1/device/sriov/3/vlan_mirror
+
+egress_mirror
+    Supports egress traffic mirroring.
+
+Example 1: add egress traffic mirroring on PF p1p2 VF 1 to VF 7::
+
+    # echo add 7 > /sys/class/net/p1p2/device/sriov/1/egress_mirror
+
+Example 2: remove egress traffic mirroring on PF p1p2 VF 1 to VF 7::
+
+    # echo rem 7 > /sys/class/net/p1p2/device/sriov/1/egress_mirror
+
+ingress_mirror
+    Supports ingress traffic mirroring.
+
+Example 1: mirror ingress traffic on PF p1p2 VF 1 to VF 7::
+
+    # echo add 7 > /sys/class/net/p1p2/device/sriov/1/ingress_mirror
+
+Example 2: show current ingress mirroring configuration::
+
+    # cat /sys/class/net/p1p2/device/sriov/1/ingress_mirror
+
+mac_anti_spoof
+    Supports Enable/Disable MAC anti-spoof. Allows VFs to transmit packets with
+    any SRC MAC, which is needed for some L2 applications as well as vNIC bonding
+    within VMs if set to OFF.
+
+Example 1: enable MAC anti-spoof for PF p2p1 VF 1::
+
+    # echo ON /sys/class/net/p1p2/device/sriov/1/mac_anti_spoof
+
+Example 2: disable MAC anti-spoof for PF p2p1 VF 1::
+
+    # echo OFF /sys/class/net/p1p2/device/sriov/1/mac_anti_spoof
+
+vlan_anti_spoof
+    Supports Enable/Disable VLAN anti-spoof. Allows VFs to transmit packets only
+    with VLAN tag specified in ?trunk? settings, also will not allow to transmit
+    ?untagged? packets if set to ON. Violation have to increment tx_spoof stats
+    counter.
+
+Example 1: enable VLAN anti-spoof for PF p2p1 VF 1::
+
+    # echo ON /sys/class/net/p1p2/device/sriov/1/vlan_anti_spoof
+
+Example 2: disable VLAN anti-spoof for PF p2p1 VF 1::
+
+    # echo OFF /sys/class/net/p1p2/device/sriov/1/vlan_anti_spoof
+
+loopback
+    Supports Enable/Disable VEB/VEPA (Local loopback).
+
+Example 1: allow traffic switching between VFs on the same PF::
+
+    # echo ON > /sys/class/net/p1p2/device/sriov/loopback
+
+Example 2: send Hairpin traffic to the switch to which the PF is connected::
+
+    # echo OFF > /sys/class/net/p1p2/device/sriov/loopback
+
+Example 3: show loopback configuration::
+
+    # cat /sys/class/net/p1p2/device/sriov/loopback
+
+mac
+    Supports setting default MAC address. If MAC address is set by this
+    command, the PF will not allow VF to change it using an MBOX request.
+
+Example 1: set default MAC address to VF 1::
+
+    # echo "00:11:22:33:44:55" > /sys/class/net/p1p2/device/sriov/1/mac
+
+Example 2: show default MAC address::
+
+    # cat /sys/class/net/p1p2/device/sriov/1/mac
+
+mac_list
+    Supports adding additional MACs to the VF. The default MAC is taken from
+    "ip link set p1p2 vf 1 mac 00:11:22:33:44:55" if configured. If not, a random
+    address is assigned to the VF by the NIC. If the MAC is configured using
+    the IP LINK command, the VF cannot change it via MBOX/AdminQ requests.
+
+Example 1: add mac 00:11:22:33:44:55 and 00:66:55:44:33:22 to PF p1p2 VF 1::
+
+    # echo add "00:11:22:33:44:55,00:66:55:44:33:22" > /sys/class/net/p1p2/device/sriov/1/mac_list
+
+Example 2: delete mac 00:11:22:33:44:55 from above VF device::
+
+    # echo rem 00:11:22:33:44:55 > /sys/class/net/p1p2/device/sriov/1/mac_list
+
+Example 3: display a VF MAC address list::
+
+    # cat /sys/class/net/p1p2/device/sriov/1/mac_lis
+
+promisc
+    Supports setting/unsetting VF device unicast promiscuous mode and multicast
+    promiscuous mode.
+
+Example 1: set MCAST promiscuous on PF p1p2 VF 1::
+
+    # echo add mcast > /sys/class/net/p1p2/device/sriov/1/promisc
+
+Example 2: set UCAST promiscuous on PF p1p2 VF 1::
+
+    # echo add ucast > /sys/class/net/p1p2/device/sriov/1/promisc
+
+Example 3: unset MCAST promiscuous on PF p1p2 VF 1::
+
+    # echo rem mcast > /sys/class/net/p1p2/device/sriov/1/promisc
+
+Example 4: show current promiscuous mode configuration::
+
+    # cat /sys/class/net/p1p2/device/sriov/1/promisc
+
+vlan_strip
+    Supports enabling/disabling VF device outer VLAN stripping
+
+Example 1: enable VLAN strip on VF 3::
+
+    # echo ON > /sys/class/net/p1p1/device/sriov/3/vlan_strip
+
+Example 2: disable VLAN striping VF 3::
+
+    # echo OFF > /sys/class/net/p1p1/device/sriov/3/vlan_strip
+
+stats
+    Supports getting VF statistics
+
+Example 1: display anti-spoofing violations counter for VF 1::
+
+    # cat /sys/class/net/p1p2/device/sriov/1/stats/tx_spoofed
+
+link_state
+    Sets/displays link status.
+
+Example 1: display link status on link speed::
+
+    # cat /sys/class/net/p1p2/device/sriov/1/link_state
+
+Example 2 set VF 1 to track status of PF link::
+
+    # echo auto > /sys/class/net/p1p2/device/sriov/1/link_state
+
+Example 3: disable VF 1::
+
+    # echo disable > /sys/class/net/p1p2/device/sriov/1/link_state
+
 
 Known Issues/Troubleshooting
 ============================
 
+Bonding fails with VFs bound to an Intel(R) Ethernet Controller 700 series device
+---------------------------------------------------------------------------------
+If you bind Virtual Functions (VFs) to an Intel(R) Ethernet Controller 700
+series based device, the VF slaves may fail when they become the active slave.
+If the MAC address of the VF is set by the PF (Physical Function) of the
+device, when you add a slave, or change the active-backup slave, Linux bonding
+tries to sync the backup slave's MAC address to the same MAC address as the
+active slave. Linux bonding will fail at this point. This issue will not occur
+if the VF's MAC address is not set by the PF.
+
 Traffic Is Not Being Passed Between VM and Client
 -------------------------------------------------
 You may not be able to pass traffic between a client system and a
@@ -215,13 +464,28 @@ Do not unload a port's driver if a Virtual Function (VF) with an active Virtual
 Machine (VM) is bound to it. Doing so will cause the port to appear to hang.
 Once the VM shuts down, or otherwise releases the VF, the command will complete.
 
+Using four traffic classes fails
+--------------------------------
+Do not try to reserve more than three traffic classes in the iavf driver. Doing
+so will fail to set any traffic classes and will cause the driver to write
+errors to stdout. Use a maximum of three queues to avoid this issue.
+
+Multiple log error messages on iavf driver removal
+--------------------------------------------------
+If you have several VFs and you remove the iavf driver, several instances of
+the following log errors are written to the log::
+
+    Unable to send opcode 2 to PF, err I40E_ERR_QUEUE_EMPTY, aq_err ok
+    Unable to send the message to VF 2 aq_err 12
+    ARQ Overflow Error detected
+
 Virtual machine does not get link
 ---------------------------------
 If the virtual machine has more than one virtual port assigned to it, and those
 virtual ports are bound to different physical ports, you may not get link on
 all of the virtual ports. The following command may work around the issue::
 
-  ethtool -r <PF>
+    # ethtool -r <PF>
 
 Where <PF> is the PF interface in the host, for example: p5p1. You may need to
 run the command more than once to get link on all virtual ports.
@@ -251,12 +515,13 @@ traffic.
 If you have multiple interfaces in a server, either turn on ARP filtering by
 entering::
 
-  echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
+    # echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
 
-NOTE: This setting is not saved across reboots. The configuration change can be
-made permanent by adding the following line to the file /etc/sysctl.conf::
+NOTE:
+  This setting is not saved across reboots. The configuration change can be
+  made permanent by adding the following line to the file /etc/sysctl.conf::
 
-  net.ipv4.conf.all.arp_filter = 1
+    net.ipv4.conf.all.arp_filter = 1
 
 Another alternative is to install the interfaces in separate broadcast domains
 (either in different switches or in a switch partitioned to VLANs).
-- 
2.21.0


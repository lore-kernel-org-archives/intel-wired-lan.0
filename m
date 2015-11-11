From: William Dauchy <william@gandi.net>
Date: Wed, 11 Nov 2015 18:35:27 +0100
Subject: [Intel-wired-lan] regression in ixgbe SFP detection patch
Message-ID: <20151111173527.GA3641@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I upgraded a machine from 3.14.x to v4.1.x and noted that I now have two
kworker very often on D state, just after boot while I am not doing
anything special. This issue remains indefinitely.

This machine has four network interfaces:


01:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
        Subsystem: Inventec Corporation Device 004a
        Flags: bus master, fast devsel, latency 0, IRQ 17
        Memory at fbce0000 (32-bit, non-prefetchable) [size=128K]
        Memory at fbcc0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at cc00 [size=32]
        Memory at fbc9c000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at fbca0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [70] MSI-X: Enable+ Count=10 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-26-6c-ff-ff-ff-af-71
        Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
        Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
        Kernel driver in use: igb

01:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
        Subsystem: Inventec Corporation Device 004a
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at fbc20000 (32-bit, non-prefetchable) [size=128K]
        Memory at fbc00000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at c880 [size=32]
        Memory at fbbdc000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at fbbe0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [70] MSI-X: Enable+ Count=10 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-26-6c-ff-ff-ff-af-71
        Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
        Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
        Kernel driver in use: igb

03:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
        Subsystem: Inventec Corporation Device 004c
        Flags: bus master, fast devsel, latency 0, IRQ 56
        Memory at fbdc0000 (64-bit, non-prefetchable) [size=256K]
        I/O ports at dc00 [size=32]
        Memory at fbd9c000 (64-bit, non-prefetchable) [size=16K]
        Expansion ROM at fbda0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [e0] Vital Product Data
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-8c-fa-ff-ff-01-cf-c2
        Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
        Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
        Kernel driver in use: ixgbe

03:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
        Subsystem: Inventec Corporation Device 004c
        Flags: bus master, fast devsel, latency 0, IRQ 82
        Memory at fbd40000 (64-bit, non-prefetchable) [size=256K]
        I/O ports at d880 [size=32]
        Memory at fbd1c000 (64-bit, non-prefetchable) [size=16K]
        Expansion ROM at fbd20000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [e0] Vital Product Data
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-8c-fa-ff-ff-01-cf-c2
        Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
        Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
        Kernel driver in use: ixgbe


The two ixgbe interfaces are not used (UP but no-carrier):

2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 qdisc mq state UP group defa
    link/ether 00:26:6c:ff:af:70 brd ff:ff:ff:ff:ff:ff
    inet 10.5.5.58/24 brd 10.5.5.255 scope global eth0
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 qdisc mq state UP group defa
    link/ether 00:26:6c:ff:af:71 brd ff:ff:ff:ff:ff:ff
4: eth2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group 
    link/ether 00:8c:fa:01:cf:c2 brd ff:ff:ff:ff:ff:ff
5: eth3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group 
    link/ether 00:8c:fa:01:cf:c3 brd ff:ff:ff:ff:ff:ff


if I turn them down (ip link set dev eth{2,3} down); the problem
disappear, the two kworker in D disapper as well.

Since I consider this as a regression because I only change the kernel
version, I did a bisection in order to localize the issue.

What I got at the end is: (bisected between v3.14.x and v4.1.x)
# first bad commit: [d9cd46cd391a132a43cbde7bdac12c16284b618f] ixgbe: fix detection of SFP+ capable interfaces

After some tests, I reverted the only part present in ixgbe_main:

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4786,8 +4786,6 @@
 	case ixgbe_phy_qsfp_active_unknown:
 	case ixgbe_phy_qsfp_intel:
 	case ixgbe_phy_qsfp_unknown:
-	/* ixgbe_phy_none is set when no SFP module is present */
-	case ixgbe_phy_none:
 		return true;
 	case ixgbe_phy_nl:
 		if (hw->mac.type == ixgbe_mac_82598EB)


It also fixes my issue: even if eth{2,3} are still up with no carrier, I
don't have any kworker in D state.


So, is it something we should consider as a regression, in that case I
can send a formal patch, or do you need some more information to help
you debug it?


Thanks,
-- 
William
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151111/e0533096/attachment-0001.asc>

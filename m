From: Jayakumar, Muthurajan <muthurajan.jayakumar@intel.com>
Date: Tue, 20 Sep 2016 16:19:13 +0000
Subject: [Intel-wired-lan] Intel igb Nic driver stuck in loop [ Urgent ]
In-Reply-To: <CAG9b6k3K8qx2auAckXc8dTsvRteAje4SZb4tzUgQu0ssX7-Rkg@mail.gmail.com>
References: <CAG9b6k1oke4Mhgp9565uxPceB_-qRbOgkc0_2GBkLHjVKgOEGA@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD65ACF476F@ORSMSX114.amr.corp.intel.com>
 <CAG9b6k3K8qx2auAckXc8dTsvRteAje4SZb4tzUgQu0ssX7-Rkg@mail.gmail.com>
Message-ID: <5D695A7F6F10504DBD9B9187395A21797E902BC7@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

?

Dear Ravi,
In your tickets, there was a part about you getting errors in NVRAM update and there was a part about DPDK area issue.
The Intel-wired-lan group will be having knowledge about NVRAM update issue.
Is it possible to post that part of your problem please.

(ps: The other one I had given another link ? that is from DPDK community ? related to RSS)

Thanks,
M Jay

From: Ravi Iyer [mailto:ravi at versa-networks.com]
Sent: Tuesday, September 20, 2016 9:15 AM
To: Fujinaka, Todd <todd.fujinaka@intel.com>
Cc: intel-wired-lan at lists.osuosl.org; Jayakumar, Muthurajan <muthurajan.jayakumar@intel.com>
Subject: Re: [Intel-wired-lan] Intel igb Nic driver stuck in loop [ Urgent ]

The Intel DPDK team redirected us here.
Adding MJay from DPDK team.

thanks
ravi

On Tue, Sep 20, 2016 at 7:52 PM, Fujinaka, Todd <todd.fujinaka at intel.com<mailto:todd.fujinaka@intel.com>> wrote:
Sounds like a dpdk problem and you should engage with the dpdk team on the dpdk mailing list (found on dpdk.org).

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com<mailto:todd.fujinaka@intel.com>
(503) 712-4565<tel:%28503%29%20712-4565>

From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org<mailto:intel-wired-lan-bounces@lists.osuosl.org>] On Behalf Of Ravi Iyer
Sent: Sunday, September 18, 2016 10:30 PM
To: intel-wired-lan@lists.osuosl.org<mailto:intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] Intel igb Nic driver stuck in loop [ Urgent ]

Hello All,


We are seeing an issue where in the igb driver of the linux kernel spins in a loop while trying to read link status of an interface. The interface itself is as such not visible over ubuntu linux.

The same issue is seen when, with the box in the same state, we run a dpdk based application. One of the dpdk thread keeps spinning right after rte_eth_link_get_nowait() .The back trace of dpdk thread as well as the
kernel thread is pasted below.

The kernel Version is 3.16.0-30-generic.

Any suggestions/workarounds are welcome.


Thanks
ravi





The dpdk thread spins a loop as follows:
===========================================

#0  e1000_get_hw_semaphore_generic (hw=hw at entry=0x7f2ab5cfa400) at ../usr/lib/DPDK/lib/librte_pmd_e1000/e1000/e1000_mac.c:1756
#1  0x00000000014a5036 in e1000_acquire_swfw_sync_82575 (hw=0x7f2ab5cfa400, mask=2)
    at ../usr/lib/DPDK/lib/librte_pmd_e1000/e1000/e1000_82575.c:1060
#2  0x00000000014a5d16 in e1000_read_phy_reg_82580 (hw=0x7f2ab5cfa400, offset=1, data=0x7f2accc52cb0)
    at ../usr/lib/DPDK/lib/librte_pmd_e1000/e1000/e1000_82575.c:2362
#3  0x00000000014b7dcd in e1000_phy_has_link_generic (hw=0x7f2ab5cfa400, iterations=iterations at entry=1, usec_interval=usec_interval at entry=0,
    success=success at entry=0x7f2accc52d00) at ../usr/lib/DPDK/lib/librte_pmd_e1000/e1000/e1000_phy.c:2381
#4  0x00000000014b098f in e1000_check_for_copper_link_generic (hw=0x7f2ab5cfa400)
    at ../usr/lib/DPDK/lib/librte_pmd_e1000/e1000/e1000_mac.c:749
#5  0x0000000001499386 in eth_igb_link_update (dev=0x1a83f220 <rte_eth_devices>, wait_to_complete=<optimized out>)
    at ../usr/lib/DPDK/lib/librte_pmd_e1000/igb_ethdev.c:1440
===================================

The kernel thread back trace:

======================================
+   99.87%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] ret_from_fork
+   99.87%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] kthread
+   99.87%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] worker_thread
+   99.87%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] process_one_work
+   99.87%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] igb_watchdog_task
+   99.87%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] igb_has_link
+   99.87%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] igb_check_for_link_82575
+   99.87%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] igb_check_for_copper_link
+   99.87%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] igb_phy_has_link
+   99.86%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] igb_read_phy_reg_82580
+   99.86%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] igb_acquire_phy_82575
?+   99.86%     0.00%   kworker/0:2  [kernel.kallsyms]   [k] igb_acquire_swfw_sync_82575
+   99.84%     0.01%   kworker/0:2  [kernel.kallsyms]   [k] igb_get_hw_semaphore
+   98.00%     0.02%   kworker/0:2  [kernel.kallsyms]   [k] __const_udelay
+   88.84%    50.02%   kworker/0:2  [kernel.kallsyms]   [k] delay_tsc
+   47.91%    47.91%   kworker/0:2  [kernel.kallsyms]   [k] native_read_tsc
=====================================================

lspci output
=====================================================
admin at Branch-1:~$ lspci
00:00.0 Host bridge: Intel Corporation Atom processor C2000 SoC Transaction Router (rev 02)
00:01.0 PCI bridge: Intel Corporation Atom processor C2000 PCIe Root Port 1 (rev 02)
00:02.0 PCI bridge: Intel Corporation Atom processor C2000 PCIe Root Port 2 (rev 02)
00:03.0 PCI bridge: Intel Corporation Atom processor C2000 PCIe Root Port 3 (rev 02)
00:04.0 PCI bridge: Intel Corporation Atom processor C2000 PCIe Root Port 4 (rev 02)
00:0b.0 Co-processor: Intel Corporation Atom processor C2000 nCPM (rev 02)
00:0e.0 Host bridge: Intel Corporation Atom processor C2000 RAS (rev 02)
00:0f.0 IOMMU: Intel Corporation Atom processor C2000 RCEC (rev 02)
00:13.0 System peripheral: Intel Corporation Atom processor C2000 SMBus 2.0 (rev 02)
00:14.0 Ethernet controller: Intel Corporation Ethernet Connection I354 (rev 03)
00:14.1 Ethernet controller: Intel Corporation Ethernet Connection I354 (rev 03)
00:14.2 Ethernet controller: Intel Corporation Ethernet Connection I354 (rev 03)
00:14.3 Ethernet controller: Intel Corporation Ethernet Connection I354 (rev 03)
00:16.0 USB controller: Intel Corporation Atom processor C2000 USB Enhanced Host Controller (rev 02)
00:17.0 SATA controller: Intel Corporation Atom processor C2000 AHCI SATA2 Controller (rev 02)
00:18.0 SATA controller: Intel Corporation Atom processor C2000 AHCI SATA3 Controller (rev 02)
00:1f.0 ISA bridge: Intel Corporation Atom processor C2000 PCU (rev 02)
00:1f.3 SMBus: Intel Corporation Atom processor C2000 PCU SMBus (rev 02)
01:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
02:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
=====================================================

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160920/6ce230f9/attachment-0001.html>

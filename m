From: Jun Miao <jun.miao@windriver.com>
Date: Mon,  6 Sep 2021 17:30:54 +0800
Subject: [Intel-wired-lan] [v2][PATCH] ice: Fix NULL pointer dereference of
 pf->aux_idx
Message-ID: <20210906093054.2904558-1-jun.miao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The RDMA is not supported on some devices such as E822-C.
When triger PCI hotplug, there will be a kernel NULL pointer Call Trace.

Since of removing the E822-C ice driver, ice_remove() will callback ida_free().
But there isn`t be alloced "pf->aux_idx", when the RDMA is unsupported. So we
should check whether support RDMA firstly, before free the "pf->aux_idx".

Feature description and call trace Log:

There are E822-C on the board:
ec:00.0 Ethernet controller: Intel Corporation Ethernet Connection E822-C for QSFP (rev 20)
ec:00.1 Ethernet controller: Intel Corporation Ethernet Connection E822-C for QSFP (rev 20)
ec:00.2 Ethernet controller: Intel Corporation Ethernet Connection E822-C for QSFP (rev 20)
ec:00.3 Ethernet controller: Intel Corporation Ethernet Connection E822-C for QSFP (rev 20)
ec:00.4 Ethernet controller: Intel Corporation Ethernet Connection E822-C for SFP (rev 20)

root at intel-x86-64:~#echo 1 > /sys/bus/pci/devices/0000:ec:00.3/remove
BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 17 PID: 791 Comm: sh Not tainted 5.14.0-next-20210903 #1
Hardware name: Intel Corporation JACOBSVILLE/JACOBSVILLE, BIOS
JBVLCRB2.86B.0014.P67.2103111848 03/11/2021
RIP: 0010:ida_free+0x7f/0x150
Code: 00 00 48 c7 45 d0 00 00 00 00 0f 88 d8 00 00 00 89 f3 e8 44 38 84 00 48 8d
7d a8 49 89 c6 e8 38 ee 00 00 a8 01 49 89 c5 75 47 <4c> 0f a3 20 0f 92 c0 84 c0
75 79 48 8b 7d a8 4c 89 f6 e8 6a 38 84
RSP: 0018:ffffb114c18dbc38 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb114c18dbc38
RBP: ffffb114c18dbc90 R08: 0000000000000000 R09: ffffb114c18dbc28
R10: 0000000000000000 R11: ffffffff89e59e58 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000246 R15: ffffa0e5e10f4900
FS:  00007fc4d4021740(0000) GS:ffffa0f500040000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000010a70a000 CR4: 0000000000350ee0
Call Trace:
 ice_remove+0xc4/0x210 [ice]
 pci_device_remove+0x3b/0xc0
 device_release_driver_internal+0xfe/0x1d0
 device_release_driver+0x12/0x20
 pci_stop_bus_device+0x61/0x90
 pci_stop_and_remove_bus_device_locked+0x1a/0x30
 remove_store+0x7c/0x90
 dev_attr_store+0x14/0x30
 sysfs_kf_write+0x39/0x50
 kernfs_fop_write_iter+0x123/0x1b0
 new_sync_write+0x10e/0x1b0
 vfs_write+0x131/0x2a0
 ksys_write+0x5e/0xe0
 __x64_sys_write+0x1a/0x20
 do_syscall_64+0x3f/0xa0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc4d411faa7
Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b
04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3
48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007fff097188b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fc4d411faa7
RDX: 0000000000000002 RSI: 0000555bc86bf640 RDI: 0000000000000001
RBP: 0000555bc86bf640 R08: 0000000000000000 R09: 00007fc4d41cf4e0
R10: 00007fc4d41cf3e0 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fc4d42155a0 R14: 0000000000000002 R15: 00007fc4d42157a0
Modules linked in: intel_rapl_msr intel_rapl_common ice i10nm_edac
x86_pkg_temp_thermal intel_powerclamp matroxfb_base iTCO_wdt coretemp
intel_pmc_bxt matroxfb_g450 crct10dif_pclmul iTCO_vendor_support matroxfb_accel
intel_spi_pci crct10dif_common watchdog intel_spi matroxfb_DAC1064 intel_th_gth
aesni_intel spi_nor g450_pll crypto_simd input_leds matroxfb_misc cryptd
intel_th_pci led_class i2c_i801 intel_th i2c_smbus i2c_ismt wmi acpi_cpufreq
sch_fq_codel openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 fuse configfs
CR2: 0000000000000000
---[ end trace b7d0a971ebc5759b ]---
SmmCorePerformanceLib: No enough space to save boot records
RIP: 0010:ida_free+0x7f/0x150
Code: 00 00 48 c7 45 d0 00 00 00 00 0f 88 d8 00 00 00 89 f3 e8 44 38 84 00 48 8d
7d a8 49 89 c6 e8 38 ee 00 00 a8 01 49 89 c5 75 47 <4c> 0f a3 20 0f 92 c0 84 c0
75 79 48 8b 7d a8 4c 89 f6 e8 6a 38 84
RSP: 0018:ffffb114c18dbc38 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb114c18dbc38
RBP: ffffb114c18dbc90 R08: 0000000000000000 R09: ffffb114c18dbc28
R10: 0000000000000000 R11: ffffffff89e59e58 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000246 R15: ffffa0e5e10f4900
FS:  00007fc4d4021740(0000) GS:ffffa0f500040000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000010a70a000 CR4: 0000000000350ee0
note: sh[791] exited with preempt_count 1
Killed

Fixes: d25a0fc41c1f ("ice: Initialize RDMA support")
Signed-off-by: Jun Miao <jun.miao@windriver.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0d6c143f6653..947a47d10855 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4615,7 +4615,10 @@ static void ice_remove(struct pci_dev *pdev)
 
 	ice_aq_cancel_waiting_tasks(pf);
 	ice_unplug_aux_dev(pf);
-	ida_free(&ice_aux_ida, pf->aux_idx);
+
+	if (ice_is_aux_ena(pf))
+		ida_free(&ice_aux_ida, pf->aux_idx);
+
 	set_bit(ICE_DOWN, pf->state);
 
 	mutex_destroy(&(&pf->hw)->fdir_fltr_lock);
-- 
2.32.0


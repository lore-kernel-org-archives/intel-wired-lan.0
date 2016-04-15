From: Brian Walsh <brian@walsh.ws>
Date: Fri, 15 Apr 2016 16:16:02 -0400
Subject: [Intel-wired-lan] [PATCH] e1000e: don't modify SYSTIM registers
 during SIOCSHWTSTAMP ioctl
In-Reply-To: <1460676564-30452-1-git-send-email-jacob.e.keller@intel.com>
References: <1460676564-30452-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <20160415201602.GA28093@hobbes.lan20.walshnetwork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 14, 2016 at 04:29:24PM -0700, Jacob Keller wrote:
> The e1000e_config_hwtstamp function was incorrectly resetting the SYSTIM
> registers every time the ioctl was being run. If you happened to be
> running ptp4l and lost the PTP connect (removing cable, or blocking the
> UDP traffic for example), then ptp4l will eventually perform a restart
> which involves re-requesting timestamp settings. In e1000e this has the
> unfortunate and incorrect result of resetting SYSTIME to the kernel
> time. Since kernel time is usually in UTC, and PTP time is in TAI, this
> results in the leap second being re-applied.
> 
> Fix this by extracting the SYSTIME reset out into its own function,
> e1000e_ptp_reset, which we call during reset to restore the hardware
> registers. This function will (a) restart the timecounter based on the
> new system time, (b) restore the previous PPB setting, and (c) restore
> the previous hwtstamp settings.
> 
> In order to perform (b), I had to modify the adjfreq ptp function
> pointer to store the old delta each time it is called. This also has the
> side effect of restoring the correct base timinca register correctly.
> The driver does not need to explicitly zero the ptp_delta variable since
> the entire adapter structure comes zero-initialized.
> 
> Reported-by: Brian Walsh <brian@walsh.ws>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

My last attempt was on an older 4.1 kernel. I am seeing the same failure
on the latest 4.6 rc3.

[   14.029654] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   14.088821] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   14.113831] e1000e 0000:07:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   14.255644] BUG: unable to handle kernel NULL pointer dereference at (null)
[   14.260555] IP: [<  (null)>]   (null)
[   14.268130] *pde = 00000000
[   14.273156] Oops: 0000 [#1] PREEMPT SMP
[   14.276980] Modules linked in: e1000e(+)
[   14.281386] CPU: 0 PID: 1227 Comm: modprobe Tainted: G        W 4.6.0-rc3+ #2
[   14.281386] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./microETXexpress-DC    , BIOS UNP1R112 04/12/2010
[   14.281386] task: f5ea5100 ti: f57c4000 task.ti: f57c4000
[   14.281386] EIP: 0060:[<00000000>] EFLAGS: 00010282 CPU: 0
[   14.281386] EIP is at 0x0
[   14.281386] EAX: f57d7184 EBX: f57d4500 ECX: 00000000 EDX: 00000000
[   14.281386] ESI: f57d495c EDI: f57d7144 EBP: f57c5ce8 ESP: f57c5cc4
[   14.281386]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[   14.281386] CR0: 80050033 CR2: 00000000 CR3: 3575f000 CR4: 000006c0
[   14.281386] Stack:
[   14.281386]  f81935b6 00007a0e 00007333 f81890f4 00048000 f57d4500 f57d4500 00000000
[   14.281386]  00000000 f57c5d3c f8194f9e 00000001 00020000 f5e78864 f5e78800 f57d495c
[   14.365891]  f57d4000 f57d7138 c10593b2 f5e788c8 00000000 f57d70c0 f57d70b0 f57d70a0
[   14.365891] Call Trace:
[   14.365891]  [<f81935b6>] ? e1000e_reset+0x323/0x49f [e1000e]
[   14.386984]  [<f81890f4>] ? e1000e_read_nvm_eerd+0x50/0x77 [e1000e]
[   14.391710]  [<f8194f9e>] e1000_probe+0x8bb/0xa88 [e1000e]
[   14.391710]  [<c10593b2>] ? preempt_count_add+0x78/0x95
[   14.391710]  [<c12a851c>] local_pci_probe+0x30/0x69
[   14.391710]  [<c12a8721>] pci_device_probe+0x50/0x77
[   14.391710]  [<c13df028>] driver_probe_device+0xe2/0x1f3
[   14.391710]  [<c13df189>] __driver_attach+0x50/0x6c
[   14.391710]  [<c13ddc59>] bus_for_each_dev+0x38/0x61
[   14.391710]  [<c13ded57>] driver_attach+0x14/0x16
[   14.391710]  [<c13df139>] ? driver_probe_device+0x1f3/0x1f3
[   14.391710]  [<c13de82b>] bus_add_driver+0xb4/0x191
[   14.391710]  [<f8069000>] ? 0xf8069000
[   14.391710]  [<f8069000>] ? 0xf8069000
[   14.391710]  [<c13df71f>] driver_register+0x70/0xa2
[   14.391710]  [<c12a87d8>] __pci_register_driver+0x35/0x39
[   14.391710]  [<f8069030>] e1000_init_module+0x30/0x32 [e1000e]
[   14.391710]  [<c1000409>] do_one_initcall+0xc9/0x146
[   14.391710]  [<c110ccf3>] ? kmem_cache_alloc_trace+0xca/0xd4
[   14.391710]  [<c109562d>] ? do_init_module+0x24/0x195
[   14.391710]  [<c109565c>] do_init_module+0x53/0x195
[   14.391710]  [<c10971fe>] load_module+0x1000/0x11d7
[   14.391710]  [<c10ff926>] ? __vmalloc_node+0x3d/0x44
[   14.391710]  [<c10974c1>] ? SyS_init_module+0x63/0xdd
[   14.391710]  [<c1097539>] SyS_init_module+0xdb/0xdd
[   14.391710]  [<c1001472>] do_fast_syscall_32+0x80/0xbf
[   14.391710]  [<c16763fb>] sysenter_past_esp+0x40/0x6a
[   14.391710] Code:  Bad EIP value.
[   14.391710] EIP: [<00000000>] 0x0 SS:ESP 0068:f57c5cc4
[   14.391710] CR2: 0000000000000000
[   14.513519] ---[ end trace 0004a75013c7c407 ]---


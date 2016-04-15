From: Brian Walsh <brian@walsh.ws>
Date: Fri, 15 Apr 2016 13:22:58 -0400
Subject: [Intel-wired-lan] [PATCH] e1000e: don't modify SYSTIM registers
 during SIOCSHWTSTAMP ioctl
In-Reply-To: <1460676564-30452-1-git-send-email-jacob.e.keller@intel.com>
References: <1460676564-30452-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <20160415172258.GA26754@hobbes.lan20.walshnetwork.net>
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

My machine will not boot with this patch. It is failing in the device
initialization.

Brian

[   12.938544] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[   12.938695] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[   12.948646] e1000e 0000:07:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   13.061455] BUG: unable to handle kernel NULL pointer dereference at (null)
[   13.061696] IP: [<  (null)>]   (null)
[   13.061875] *pde = 00000000
[   13.062017] Oops: 0000 [#1] PREEMPT SMP
[   13.062017] Modules linked in: e1000e(+)
[   13.062017] CPU: 1 PID: 1134 Comm: modprobe Not tainted 4.1.7 #2
[   13.062017] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./microETXexpress-DC    , BIOS UNP1R112 04/12/2010
[   13.062017] task: f5ebe200 ti: f5694000 task.ti: f5694000
[   13.062017] EIP: 0060:[<00000000>] EFLAGS: 00010282 CPU: 1
[   13.062017] EIP is at 0x0
[   13.063225] EAX: f57d3144 EBX: f57d04c0 ECX: 00000000 EDX: 00000000
[   13.063225] ESI: f57d091c EDI: f57d3104 EBP: f5695d7c ESP: f5695d58
[   13.063225]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[   13.063225] CR0: 8005003b CR2: 00000000 CR3: 356cd000 CR4: 000006c0
[   13.063225] Stack:
[   13.063225]  f81a030a 00007a0e 00007333 f8195fac 00048000 f57d04c0 f57d04c0 00000000
[   13.063225]  00000000 f5695db8 f81a186a 00000001 00020000 f5f04464 f5f04400 f57d091c
[   13.063225]  f57d0000 c13b7680 f5695db8 c13b8768 4d010000 f5695dd8 f5f04400 f5f04464
[   13.063225] Call Trace:
[   13.063225]  [<f81a030a>] ? e1000e_reset+0x313/0x447 [e1000e]
[   13.063225]  [<f8195fac>] ? e1000e_read_nvm_eerd+0x50/0x77 [e1000e]
[   13.063225]  [<f81a186a>] e1000_probe+0x8a3/0xa6d [e1000e]
[   13.063225]  [<c13b7680>] ? spin_unlock_irqrestore+0x8/0xa
[   13.063225]  [<c13b8768>] ? __pm_runtime_resume+0x3b/0x43
[   13.063225]  [<c1297746>] local_pci_probe+0x30/0x69
[   13.063225]  [<c129792f>] pci_device_probe+0x42/0x61
[   13.063225]  [<c13b1683>] driver_probe_device+0xae/0x1bc
[   13.063225]  [<c13b17cd>] __driver_attach+0x3c/0x54
[   13.063225]  [<c13b0548>] bus_for_each_dev+0x38/0x61
[   13.063225]  [<c13b14fe>] driver_attach+0x14/0x16
[   13.063225]  [<c13b1791>] ? driver_probe_device+0x1bc/0x1bc
[   13.063225]  [<c13b10dc>] bus_add_driver+0x9b/0x177
[   13.063225]  [<f8077000>] ? 0xf8077000
[   13.063225]  [<f8077000>] ? 0xf8077000
[   13.063225]  [<c13b1ca3>] driver_register+0x70/0xa2
[   13.063225]  [<c12979d0>] __pci_register_driver+0x2e/0x31
[   13.063225]  [<f8077030>] e1000_init_module+0x30/0x32 [e1000e]
[   13.063225]  [<c1000401>] do_one_initcall+0xc9/0x146
[   13.063225]  [<c108ac9d>] ? do_init_module+0x21/0x18a
[   13.063225]  [<c10f7db6>] ? kmem_cache_alloc_trace+0xa1/0xab
[   13.063225]  [<c108ac9d>] ? do_init_module+0x21/0x18a
[   13.063225]  [<c108accc>] do_init_module+0x50/0x18a
[   13.063225]  [<c108c68e>] load_module+0xeb8/0x1084
[   13.063225]  [<c108c998>] SyS_init_module+0xcf/0xd3
[   13.063225]  [<c16302ac>] sysenter_do_call+0x12/0x12
[   13.063225] Code:  Bad EIP value.
[   13.063225] EIP: [<00000000>] 0x0 SS:ESP 0068:f5695d58
[   13.063225] CR2: 0000000000000000
[   13.092775] ---[ end trace 0d302018b434ce8a ]---


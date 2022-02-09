From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 8 Feb 2022 16:33:40 -0800
Subject: [Intel-wired-lan] BUG: KCSAN: data-race in
 e1000_clean_rx_irq+0x330/0x870
In-Reply-To: <e3926433-d05c-92b1-a37d-204cf54e270c@molgen.mpg.de>
References: <e3926433-d05c-92b1-a37d-204cf54e270c@molgen.mpg.de>
Message-ID: <528f99c7-6cc7-39a3-bb94-fcb9de444746@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/7/2022 8:08 AM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Running Linux 5.17-rc2+ with KCSAN in QEMU, it reports the race below:
> 
> ```
> [??? 0.000000] Linux version 5.17.0-rc2-00353-g90c9e950c0de 
> (pmenzel at invidia.molgen.mpg.de) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 
> 2.37) #34 SMP PREEMPT Sun Feb 6 13:11:13 CET 2022
> [??? 0.000000] Command line: root=/dev/vda1 rw quiet
> [?]
> [? 410.295890] 
> ==================================================================
> [? 410.297475] BUG: KCSAN: data-race in e1000_clean_rx_irq+0x330/0x870
> 
> [? 410.299722] race at unknown origin, with read to 0xffff8a554584d3ec 
> of 1 bytes by interrupt on cpu 0:
> [? 410.301524]? e1000_clean_rx_irq+0x330/0x870
> [? 410.301534]? e1000_clean+0x4a5/0xc40
> [? 410.301541]? __napi_poll+0x5c/0x280
> [? 410.301550]? net_rx_action+0x4ff/0x5b0
> [? 410.301559]? __do_softirq+0xe4/0x2d9
> [? 410.301567]? run_ksoftirqd+0x21/0x30
> [? 410.301577]? smpboot_thread_fn+0x26b/0x360
> [? 410.301595]? kthread+0x16d/0x1a0
> [? 410.301604]? ret_from_fork+0x22/0x30
> 
> [? 410.302478] value changed: 0x00 -> 0x07
> 
> [? 410.304564] Reported by Kernel Concurrency Sanitizer on:
> [? 410.305757] CPU: 0 PID: 12 Comm: ksoftirqd/0 Not tainted 
> 5.17.0-rc2-00353-g90c9e950c0de #34
> [? 410.305776] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS 1.15.0-1 04/01/2014
> [? 410.305788] 
> ==================================================================
> ```
> 
> Please find the output of `dmesg` attached.
> 
> 
> Kind regards,
> 
> Paul

Thanks for the bug report, I don't even have any e1000 these days to 
test on, so I had to install a Virtual machine.

This is probably because we access rx_desc->status in a while loop and 
then try to access it again after dma_rmb() and it's changed. This is 
kind of expected to happen, but the clean_rx routine can be updated to 
be more like our newer drivers, and should hopefully avoid the data 
dependency.

I have a patch to try that out, I'll see if I can get it to run in my 
VM. If it gets too messy, I may just send the patch to you/this list and 
see if others can give it a go to indicate if I broke something.

The code is a bit messy on purpose but has shown itself to be resilient 
on most platforms we've tried it on all these years. However I'd like 
for us to not be discussing this issue for years going forward, so I'll 
spend a little time on it.

Jesse

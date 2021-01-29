From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 29 Jan 2021 13:58:57 -0800
Subject: [Intel-wired-lan] IRQ affinity not working properly?
In-Reply-To: <aa48b21f-c8da-0b9c-b7de-f100069ccba2@windriver.com>
References: <aa48b21f-c8da-0b9c-b7de-f100069ccba2@windriver.com>
Message-ID: <20210129135857.000037e3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Chris Friesen wrote:

> Hi,
> 
> I have a CentOS 7 linux system with 48 logical CPUs and a number of 
> Intel NICs running the i40e driver.  It was booted with 
> irqaffinity=0-1,24-25 in the kernel boot args, resulting in 
> /proc/irq/default_smp_affinity showing "0000,03000003".   CPUs 2-11 are 
> set as "isolated" in the kernel boot args.  The irqbalance daemon is not 
> running.
> 
> The iavf driver is 3.7.61.20 and the i40e driver is 2.10.19.82
> 
> The problem I'm seeing is that /proc/interrupts shows iavf interrupts on 
> other CPUs than the expected affinity.  For example, here are some 
> interrupts on CPU 4 where I would not expect to see any interrupts given 
> that "cat /proc/irq/<NUM>/smp_affinity_list" reports "0-1,24-25" for all 
> these interrupts.  (Sorry for the line wrapping.)

Hi Chris, I think you're probably running into a long standing kernel
bug, which as far as I know hasn't been fixed. My suspicion is that us setting 
up the affinity_hint and an affinity_mask is somehow bypassing the 
command line setup.

That said, if you would try commenting out this code in the iavf_main.c?

#ifdef HAVE_IRQ_AFFINITY_NOTIFY
                /* register for affinity change notifications */
                q_vector->affinity_notify.notify = iavf_irq_affinity_notify;
                q_vector->affinity_notify.release =
                                                   iavf_irq_affinity_release;
                irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
#endif
#ifdef HAVE_IRQ_AFFINITY_HINT
                /* Spread the IRQ affinity hints across online CPUs. Note that
                 * get_cpu_mask returns a mask with a permanent lifetime so
                 * it's safe to use as a hint for irq_set_affinity_hint.
                 */
                cpu = cpumask_local_spread(q_vector->v_idx, -1);
                irq_set_affinity_hint(irq_num, get_cpu_mask(cpu));
#endif /* HAVE_IRQ_AFFINITY_HINT */

And actually I want you to remove any code that refers to 
q_vector->affinity_mask, in all iavf files.

...

> There were IRQs coming in on the "iavf-0000:b5:02.7:mbx" interrupt at 
> roughly 1 per second without any traffic, while the interrupt rate on 
> the "iavf-net1-TxRx-<X>" seemed to be related to traffic.

The continuous IRQs 1 per second are on purpose to flush out any pending
events on the queues, but also usually serve another purpose, which
is to cause an interrupt to allow the interrupt to be moved to the new
mask.
 
> Is this expected?  It seems like the iavf and/or the i40e aren't 
> respecting the configured SMP affinity for the interrupt in question.

Both drivers have the same code as mentioned above. I suspect most of the 
Intel drivers have this problem and no one has run into it before
because the feature isn't used very much?

The other idea I have is that you're running into affinity exhaustion,
which the older kernels silently suffer from. see commit
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=743dac494d61d
It might even backport cleanly! Or you might be able to systemtap that
code to see if it hits.

Please let us know how it goes?

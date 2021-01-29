From: Chris Friesen <chris.friesen@windriver.com>
Date: Fri, 29 Jan 2021 09:41:09 -0600
Subject: [Intel-wired-lan] IRQ affinity not working properly?
Message-ID: <aa48b21f-c8da-0b9c-b7de-f100069ccba2@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I have a CentOS 7 linux system with 48 logical CPUs and a number of 
Intel NICs running the i40e driver.  It was booted with 
irqaffinity=0-1,24-25 in the kernel boot args, resulting in 
/proc/irq/default_smp_affinity showing "0000,03000003".   CPUs 2-11 are 
set as "isolated" in the kernel boot args.  The irqbalance daemon is not 
running.

The iavf driver is 3.7.61.20 and the i40e driver is 2.10.19.82

The problem I'm seeing is that /proc/interrupts shows iavf interrupts on 
other CPUs than the expected affinity.  For example, here are some 
interrupts on CPU 4 where I would not expect to see any interrupts given 
that "cat /proc/irq/<NUM>/smp_affinity_list" reports "0-1,24-25" for all 
these interrupts.  (Sorry for the line wrapping.)

cat /proc/interrupts | grep -e CPU -e 941: -e 942: -e 943: -e 944: -e 
945: -e 961: -e 962: -e 963: -e 964: -e 965:

              CPU0       CPU1       CPU2       CPU3 CPU4       CPU5
941:          0          0          0          0 28490          0 
   IR-PCI-MSI-edge iavf-0000:b5:03.6:mbx
942:          0          0          0          0 333832         0 
   IR-PCI-MSI-edge      iavf-net1-TxRx-0
943:          0          0          0          0 300842         0 
   IR-PCI-MSI-edge      iavf-net1-TxRx-1
944:          0          0          0          0 333845         0 
   IR-PCI-MSI-edge      iavf-net1-TxRx-2
945:          0          0          0          0 333822         0 
   IR-PCI-MSI-edge      iavf-net1-TxRx-3
961:          0          0          0          0 28492         0 
  IR-PCI-MSI-edge iavf-0000:b5:02.7:mbx
962:          0          0          0          0 435608         0 
   IR-PCI-MSI-edge      iavf-net1-TxRx-0
963:          0          0          0          0 394832         0 
   IR-PCI-MSI-edge      iavf-net1-TxRx-1
964:          0          0          0          0 398414         0 
   IR-PCI-MSI-edge      iavf-net1-TxRx-2
965:          0          0          0          0 192847         0 
   IR-PCI-MSI-edge      iavf-net1-TxRx-3

There were IRQs coming in on the "iavf-0000:b5:02.7:mbx" interrupt at 
roughly 1 per second without any traffic, while the interrupt rate on 
the "iavf-net1-TxRx-<X>" seemed to be related to traffic.

Is this expected?  It seems like the iavf and/or the i40e aren't 
respecting the configured SMP affinity for the interrupt in question.

Anyone have any ideas?

Thanks,

Chris

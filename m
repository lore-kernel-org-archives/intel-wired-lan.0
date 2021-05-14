From: Chris Friesen <chris.friesen@windriver.com>
Date: Fri, 14 May 2021 17:31:25 -0600
Subject: [Intel-wired-lan] interrupt mitigation on iavf?
Message-ID: <8dc41fcb-c4ca-e8f4-be66-5d6f08adea59@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm using iavf 4.0.1 and i40e 2.14.13 on a CentOS 7 RT kernel.  I have 
traffic coming in at a total of 150K packets/sec (64-byte packets) over 
two devices, each with multiple VFs.  I have kernel bridging enabled 
between the two VFs, and I'm seeing relatively high CPU consumption in 
the  "irq/XXX-iavf-ne" threads.  ( I assume these are the threads 
corresponding to the "iavf-netX-TxRx-X" interrupts that show up in 
/proc/interrupts.)

This is in the context of a Kubernetes environment, where we're passing 
through the VFs into a container via the SRIOV device plugin for Kubernetes.

By default, we were seeing one iavf interrupt per packet.  Given that 
"adaptive rx" and "adaptive tx" were both on, this seems wrong.

Within the container I see the VFs as "net1" and "net2", and I can use 
"ethtool -C" to set the coalescing parameters.  I can also see them 
outside of Kubernetes if I run the ethtool command using the appropriate 
network namespace.  (ip netns exec <namespace> ethtool -C net1 ....)

Given the above, I have a few questions.

1) Is hardware adaptive interrupt rate limiting working on iavf?  It 
seemed to be ineffective as I originally got one interrupt per packet.

2) Isn't the kernel itself supposed to do interrupt rate limiting via 
iavf_napi_poll()?  Or is that not effective when there are eight 
interrupts in play?

3) Is there any way to set the coalescing parameters on the VFs of the 
original PF in the root namespace?  Or do I need to operate on the linux 
network device corresponding to the VF (via the alternate namespace or 
from the container)?

4) Even with interrupt rates turned way down in ethtool 
(rx-usecs/tx-usecs of 8000), at 150K packets per second I'm still seeing 
about 3% CPU usage in each of 8 "irq/XXX-iavf-ne" threads.  Doubling the 
interrupt rates doesn't really change the CPU usage so I'm wondering if 
this is the actual packet processing cost for the bridging?

Thanks!
Chris

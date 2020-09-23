From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Wed, 23 Sep 2020 14:11:22 -0400
Subject: [Intel-wired-lan] [PATCH v2 0/4] isolation: limit msix vectors
 based on housekeeping CPUs
Message-ID: <20200923181126.223766-1-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a follow-up posting for "[RFC v1 0/3] isolation: limit msix vectors
based on housekeeping CPUs".


Issue
=====
With the current implementation device drivers while creating their MSIX ? ? ? ?
vectors only take num_online_cpus() into consideration which works quite well ?
for a non-RT environment, but in an RT environment that has a large number of ? 
isolated CPUs and very few housekeeping CPUs this could lead to a problem. ? ?
The problem will be triggered when something like tuned will try to move all ? ?
the IRQs from isolated CPUs to the limited number of housekeeping CPUs to ? ? ? 
prevent interruptions for a latency-sensitive workload that will be running on ? 
the isolated CPUs. This failure is caused because of the per CPU vector ? ? ? ? 
limitation. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 


Proposed Fix
============
In this patch-set, the following changes are proposed:
- A generic API hk_num_online_cpus() which is meant to return the online
  housekeeping CPUs that are meant to handle managed IRQ jobs.
- i40e: Specifically for the i40e driver the num_online_cpus() used in 
? i40e_init_msix() to calculate numbers msix vectors is replaced with the above
? defined API. This is done to restrict the number of msix vectors for i40e in
  RT environments.
- pci_alloc_irq_vector(): With the help of hk_num_online_cpus() the max_vecs
? passed in pci_alloc_irq_vector() is restricted only to the online
? housekeeping CPUs only in an RT environment. However, if the min_vecs exceeds
  the online housekeeping CPUs, max_vecs is limited based on the min_vecs
  instead.


Future Work
===========

- In the previous upstream discussion [1], it was decided that it would be
  better if we can have a generic framework that can be consumed by all the
  drivers to  fix this kind of issue. However, it will be a long term work,
  and since there are RT workloads that are getting impacted by the reported
  issue. We agreed upon the proposed per-device approach for now.


Testing
=======
Functionality:
- To test that the issue is resolved with i40e change I added a tracepoint
? in i40e_init_msix() to find the number of CPUs derived for vector creation
? with and without tuned's realtime-virtual-host profile. As per expectation
? with the profile applied I was only getting the number of housekeeping CPUs
? and all available CPUs without it.
  Similarly did a few more tests with different modes eg with only
  nohz_full, isolcpus etc.

Performance:
- To analyze the performance impact I have targetted the change introduced in 
? pci_alloc_irq_vectors() and compared the results against a vanilla kernel
? (5.9.0-rc3) results.

? Setup Information:
? + I had a couple of 24-core machines connected back to back via a couple of
? ? mlx5 NICs and I analyzed the average bitrate for server-client TCP and UDP
? ? transmission via iperf. 
? + To minimize the Bitrate variation of iperf TCP and UDP stream test I have
? ? applied the tuned's network-throughput profile and disabled HT.
?Test Information:
? + For the environment that had no isolated CPUs:
? ? I have tested with single stream and 24 streams (same as that of online
? ? CPUs).
? + For the environment that had 20 isolated CPUs:
? ? I have tested with single stream, 4 streams (same as that the number of
? ? housekeeping) and 24 streams (same as that of online CPUs).

?Results:
? # UDP Stream Test:
?   + There was no degradation observed in UDP stream tests in both
      environments. (With isolated CPUs and without isolated CPUs after the
      introduction of the patches).
? # TCP Stream Test - No isolated CPUs:
?   + No noticeable degradation was observed.
? # TCP Stream Test - With isolated CPUs:
?   + Multiple Stream (4) ?- Average degradation of around 5-6%
?   + Multiple Stream (24) - Average degradation of around 2-3%
?   + Single Stream ? ? ? ?- Even on a vanilla kernel the Bitrate observed for
                             a TCP single stream test seem to vary
                             significantly across different runs (eg. the %
                             variation between the best and the worst case on
                             a vanilla kernel was around 8-10%). A similar
                             variation was observed with the kernel that
                             included my patches. No additional degradation
                             was observed.

If there are any suggestions for more performance evaluation, I would
be happy to discuss/perform them.

Changes from v1[2]:
==================
Patch1: ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 
- Replaced num_houskeeeping_cpus() with hk_num_online_cpus() and started using
  the cpumask corresponding to HK_FLAG_MANAGED_IRQ to derive the number of
  online housekeeping CPUs. This is based on Frederic Weisbecker's suggestion. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 
- Since the hk_num_online_cpus() is self-explanatory, got rid of ? ? ? ? ? ? 
? the comment that was added previously. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 
Patch2: ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 
- Added a new patch that is meant to enable managed IRQ isolation for nohz_full
  CPUs. This is based on Frederic Weisbecker's suggestion.? ? ? ? ? ? ? 
Patch4 (PCI): ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 
- For cases where the min_vecs exceeds the online housekeeping CPUs, instead
  of skipping modification to max_vecs, started restricting it based on the
  min_vecs. This is based on a suggestion from Marcelo Tosatti.? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ??

[1] https://lore.kernel.org/lkml/20200922095440.GA5217 at lenoir/
[2] https://lore.kernel.org/lkml/20200909150818.313699-1-nitesh at redhat.com/

Nitesh Narayan Lal (4):
  sched/isolation: API to get housekeeping online CPUs
  sched/isolation: Extend nohz_full to isolate managed IRQs
  i40e: limit msix vectors based on housekeeping CPUs
  PCI: Limit pci_alloc_irq_vectors as per housekeeping CPUs

 drivers/net/ethernet/intel/i40e/i40e_main.c |  3 ++-
 include/linux/pci.h                         | 15 +++++++++++++++
 include/linux/sched/isolation.h             | 13 +++++++++++++
 kernel/sched/isolation.c                    |  2 +-
 4 files changed, 31 insertions(+), 2 deletions(-)

-- 



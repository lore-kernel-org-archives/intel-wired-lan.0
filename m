From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 31 Aug 2017 20:47:10 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 02/13] i40e/i40evf: spread
 CPU	affinity hints across online CPUs only
In-Reply-To: <20170829093242.41026-2-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9525@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S79-V2 02/13] i40e/i40evf: spread CPU
> affinity hints across online CPUs only
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Currently, when setting up the IRQ for a q_vector, we set an affinity hint
> based on the v_idx of that q_vector. Meaning a loop iterates on v_idx, which
> is an incremental value, and the cpumask is created based on this value.
> 
> This is a problem in systems with multiple logical CPUs per core (like in SMT
> scenarios). If we disable some logical CPUs, by turning SMT off for example,
> we will end up with a sparse cpu_online_mask, i.e., only the first CPU in a
> core is online, and incremental filling in q_vector cpumask might lead to
> multiple offline CPUs being assigned to q_vectors.
> 
> Example: if we have a system with 8 cores each one containing 8 logical CPUs
> (SMT == 8 in this case), we have 64 CPUs in total. But if SMT is disabled, only
> the 1st CPU in each core remains online, so the cpu_online_mask in this case
> would have only 8 bits set, in a sparse way.
> 
> In general case, when SMT is off the cpu_online_mask has only C bits set:
> 0, 1*N, 2*N, ..., C*(N-1)  where
> C == # of cores;
> N == # of logical CPUs per core.
> In our example, only bits 0, 8, 16, 24, 32, 40, 48, 56 would be set.
> 
> Instead, we should only assign hints for CPUs which are online. Even better,
> the kernel already provides a function, cpumask_local_spread() which takes
> an index and returns a CPU, spreading the interrupts across local NUMA
> nodes first, and then remote ones if necessary.
> 
> Since we generally have a 1:1 mapping between vectors and CPUs, there is
> no real advantage to spreading vectors to local CPUs first. In order to avoid
> mismatch of the default XPS hints, we'll pass -1 so that it spreads across all
> CPUs without regard to the node locality.
> 
> Note that we don't need to change the q_vector->affinity_mask as this is
> initialized to cpu_possible_mask, until an actual affinity is set and then
> notified back to us.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 16 +++++++++++-----
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  9 ++++++---
>  2 files changed, 17 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



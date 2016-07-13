From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jul 2016 15:01:35 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: use valid online CPU
	on	q_vector initialization
In-Reply-To: <1467040603-23008-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1467040603-23008-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EA4C6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Guilherme G. Piccoli
> Sent: Monday, June 27, 2016 8:17 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; gpiccoli at linux.vnet.ibm.com
> Subject: [Intel-wired-lan] [PATCH net] i40e: use valid online CPU on q_vector
> initialization
> 
> Currently, the q_vector initialization routine sets the affinity_mask of a
> q_vector based on v_idx value. Meaning a loop iterates on v_idx, which is an
> incremental value, and the cpumask is created based on this value.
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
> This patch changes the way q_vector's affinity_mask is created: it iterates on
> v_idx, but consumes the CPU index from the cpu_online_mask instead of
> just using the v_idx incremental value.
> 
> No functional changes were introduced.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

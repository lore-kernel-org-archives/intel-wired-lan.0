From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jul 2017 20:41:53 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 06/13] i40e/i40evf:
	remove	ULTRA latency mode
In-Reply-To: <20170714131019.52530-6-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2523@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 06/13] i40e/i40evf: remove
> ULTRA latency mode
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Since commit c56625d59726 ("i40e/i40evf: change dynamic interrupt
> thresholds") a new higher latency ITR setting called I40E_ULTRA_LATENCY
> was added with a cryptic comment about how it was meant for adjusting Rx
> more aggressively when streaming small packets.
> 
> This mode was attempting to calculate packets per second and then kick in
> when we have a huge number of small packets.
> 
> Unfortunately, the ULTRA setting was kicking in for workloads it wasn't
> intended for including single-thread UDP_STREAM workloads.
> 
> This wasn't caught for a variety of reasons. First, the ip_defrag routines were
> improved somewhat which makes the UDP_STREAM test still reasonable at
> 10GbE, even when dropped down to 8k interrupts a second.
> Additionally, some other obvious workloads appear to work fine, such as
> TCP_STREAM.
> 
> The number 40k doesn't make sense for a number of reasons. First, we
> absolutely can do more than 40k packets per second. Second, we calculate
> the value inline in an integer, which sometimes can overflow resulting in
> using incorrect values.
> 
> If we fix this overflow it makes it even more likely that we'll enter ULTRA
> mode which is the opposite of what we want.
> 
> The ULTRA mode was added originally as a way to reduce CPU utilization
> during a small packet workload where we weren't keeping up anyways. It
> should never have been kicking in during these other workloads.
> 
> Given the issues outlined above, let's remove the ULTRA latency mode. If
> necessary, a better solution to the CPU utilization issue for small packet
> workloads will be added in a future patch.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 17 -----------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 -
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 17 -----------------
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  1 -
>  4 files changed, 36 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



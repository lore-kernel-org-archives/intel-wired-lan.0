From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Apr 2017 18:13:46 +0000
Subject: [Intel-wired-lan] [next PATCH S71 10/10] i40evf: allocate
 queues	before we setup the interrupts and q_vectors
In-Reply-To: <20170419132559.20459-10-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
 <20170419132559.20459-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA12B2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 19, 2017 6:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S71 10/10] i40evf: allocate queues
> before we setup the interrupts and q_vectors
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This matches the ordering of how we free stuff during reset and remove.
> It also makes logical sense because we set the interrupts based on the
> number of queues. Currently this doesn't really matter in practice.
> However a future patch moves the assignment of num_active_queues into
> i40evf_alloc_queues, which is required by i40evf_set_interrupt_capability.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



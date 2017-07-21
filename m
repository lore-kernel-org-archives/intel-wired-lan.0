From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 20:47:52 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 08/10] i40evf: fix ring
	to	vector mapping
In-Reply-To: <20170714132709.52657-8-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
 <20170714132709.52657-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB279E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S77-V3 08/10] i40evf: fix ring to vector
> mapping
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> The current implementation for mapping queues to vectors is broken
> because it attempts to map each tx and rx ring to its own vector, however we
> use combined queues so we should actually be mapping the tx/rx rings
> together on one vector.
> 
> Also in the current implementation, in the case where we have more queues
> than vectors, we attempt to group the queues together into 'chunks' and
> map each 'chunk' of queues to a vector.  Chunking them together would be
> more ideal if, and only if, we only had RSS because of the way the hashing
> algorithm works but in the case of a future patch that enables VF ADq, round
> robin assignment is better and still works with RSS.
> 
> This patch resolves both those issues and simplifies the code needed to
> accomplish this.  Instead of treating the case where we have more queues
> than vectors as special, if we notice our vector index is greater than vectors,
> reset the vector index to zero and continue mapping.  This should ensure
> that in both cases, whether we have enough vectors for each queue or not,
> the queues get appropriately mapped.
> 
> Testing-hints:
>     Make sure traffic continues to be received and features like RSS
>     continue to work as expected.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 48 ++++++------------------
> -
>  1 file changed, 10 insertions(+), 38 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



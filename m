From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Apr 2017 17:32:19 +0000
Subject: [Intel-wired-lan] [next PATCH S70 10/12] i40e:
	use	i40e_stop_rings_no_wait to implement PORT_SUSPENDED state
In-Reply-To: <20170413084555.6962-10-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040BF18@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 10/12] i40e: use
> i40e_stop_rings_no_wait to implement PORT_SUSPENDED state
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This state bit was added as a way for DCB to avoid having to wait for the
> queues to disable when handling LLDP events. The logic for this was burried
> deep within stop Tx and stop Rx queue code. First, let's rename it so that it
> does not appear to only affect Tx when infact it modifies both Tx and Rx flow.
> Second we can move it up into the i40e_stop_rings() function, and we can
> simply re-use the i40e_stop_rings_no_wait() so that we don't have to bury
> the implementation as deep into the call stack.
> 
> An alternative might be to remove the state bit and instead attempt to shut
> down everything directly in DCP flow. This, however, is not ideal because it
> creates yet another separate shutdown routine that we'd have to maintain.
> In the current implementation any changes will be made to both flows.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I68e1ccb901af320862bca395e9c9746f08e8b17c
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 ++++++----------
>  2 files changed, 7 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



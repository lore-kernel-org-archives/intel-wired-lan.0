From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Apr 2017 17:33:35 +0000
Subject: [Intel-wired-lan] [next PATCH S70 12/12] i40e: make use
	of	i40e_reset_all_vfs when initializing new VFs
In-Reply-To: <20170413084555.6962-12-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-12-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040BF3A@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S70 12/12] i40e: make use of
> i40e_reset_all_vfs when initializing new VFs
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When allocating a large number of VFs, the driver previously used
> i40e_reset_vf in a sequence. Just as when performing a normal reset, this
> accumulates a large amount of delay for handling all of the VFs in sequence.
> This delay is mainly due to a hardware requirement to wait after initiating a
> reset on the VF.
> 
> We recently added a new function, i40e_reset_all_vfs() which can be used to
> amortize the delay time, by first triggering all VF resets, then waiting once,
> and finally cleaning up and allocating the VFs. This is almost as good as truly
> running the resets in parallel.
> 
> In order to avoid sending a spurious reset message to a client interface, we
> have a check to see whether we've assigned
> pf->num_alloc_vfs yet. This was originally intended as a way to
> distinquish the "initialization" case from the regular reset case.
> 
> Unfortunately, this means that we can't directly use i40e_reset_all_vfs yet.
> Lets avoid this check of pf->num_alloc_vfs by replacing it with a proper VSI
> state bit which we can use instead. This makes the intention much clearer
> and allows us to re-use the i40e_reset_all_vfs function directly.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
> Change-ID: I694279b37eb6b5a91b6670182d0c15d10244fd6e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++++---
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



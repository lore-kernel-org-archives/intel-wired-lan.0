From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 20:31:15 +0000
Subject: [Intel-wired-lan] [next PATCH S1 4/6] i40e: check queue pairs
 num in config queues handler
In-Reply-To: <20181219144542.85924-4-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
 <20181219144542.85924-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3439A3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 19, 2018 6:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S1 4/6] i40e: check queue pairs num in
> config queues handler
> 
> From: Sergey Nemov <sergey.nemov@intel.com>
> 
> Check if num_queue_pairs number requested by VF is less than maximum
> possible value in VIRTCHNL_OP_CONFIG_VSI_QUEUES handler.
> 
> Also check if local_vf_id >= 0 in common handler since it is of int type and can
> potentially be negative.
> 
> Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



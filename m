From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 2 Mar 2019 00:26:13 +0000
Subject: [Intel-wired-lan] [next PATCH S3 9/9] i40e: fix misleading
 message about promisc setting on un-trusted VF
In-Reply-To: <20190228175255.54754-9-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
 <20190228175255.54754-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367741@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, February 28, 2019 9:53 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S3 9/9] i40e: fix misleading message
> about promisc setting on un-trusted VF
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> A refactor of the i40e_vc_config_promiscuous_mode_msg function moved
> the check for un-trusted VF into another function. We have to lie to an un-
> trusted VF that its request to set promiscuous mode is successful even when
> it is not because we don't want the VF to find out its trust status this way.
> With the refactor, we were running into a case where even though we were
> not setting promiscuous mode for an un-trusted VF, we still printed a
> misleading message that it was successful.
> 
> This patch fixes that by ensuring that a success message is printed on the
> host side only when the promiscuous mode change has been successful.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 28 +++++++++++--------
>  1 file changed, 16 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



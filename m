From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Feb 2019 21:51:53 +0000
Subject: [Intel-wired-lan] [PATCH S11 13/16] ice: check for a leaf node
 presence
In-Reply-To: <20190208205043.11975-14-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3669A5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 13/16] ice: check for a leaf node
> presence
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> check for a leaf node presence for a given VSI. This check is required before
> removing a VSI since VSIs can't be removed with enabled queues (with leaf
> nodes) from the FW scheduler tree unless its a reset.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c  | 23
> +++++++++++++++++++++++  drivers/net/ethernet/intel/ice/ice_status.h |
> 1 +
>  2 files changed, 24 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



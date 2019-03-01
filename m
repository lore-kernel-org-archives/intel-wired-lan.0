From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:48:34 +0000
Subject: [Intel-wired-lan] [PATCH S15 v2 03/14] ice: Fix issue with VF
 attempt to delete default MAC address
In-Reply-To: <20190220171148.30904-1-anirudh.venkataramanan@intel.com>
References: <20190220171148.30904-1-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367598@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 20, 2019 9:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S15 v2 03/14] ice: Fix issue with VF attempt
> to delete default MAC address
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch fixes issue that occurs when VF is attempting to remove default
> LAN/MAC address, which is programmed by the administrator.
> We shouldn't return error for the call by the VF, but continue with the
> remaining steps to handle MAC opcode. Also update the dev_err message to
> explicitly say that VF can't change MAC programmed by PF.
> 
> Also change "mac" to "MAC" for kernel print statements in the same file.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> fixed
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



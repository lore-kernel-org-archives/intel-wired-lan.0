From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 Feb 2019 00:00:04 +0000
Subject: [Intel-wired-lan] [PATCH S11 09/16] ice: only use the VF for
 ICE_VSI_VF in ice_vsi_release
In-Reply-To: <20190208205043.11975-10-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366282@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S11 09/16] ice: only use the VF for
> ICE_VSI_VF in ice_vsi_release
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> In ice_vsi_release we are always assigning a value to the local VF variable.
> Change this to only be assigned if the VSI is a VF VSI.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



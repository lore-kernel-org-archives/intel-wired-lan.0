From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:50:27 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 02/17] ice: Remove unused
 function prototype
In-Reply-To: <20190227003523.28733-3-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367281@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 26, 2019 4:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S13 v2 02/17] ice: Remove unused function
> prototype
> 
> Commit 7c710869d64e ("ice: Add handlers for VF netdevice operations")
> seems to have inadvertently introduced a function prototype for
> ice_set_vf_bw that isn't implemented. Remove it.
> 
> Fixes: 7c710869d64e ("ice: Add handlers for VF netdevice operations")
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 10 ----------
>  1 file changed, 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



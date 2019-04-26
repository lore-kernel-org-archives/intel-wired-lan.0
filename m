From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 21:51:01 +0000
Subject: [Intel-wired-lan] [PATCH S19 02/15] ice: Cleanup an unnecessary
 variable initialization
In-Reply-To: <20190416172439.27908-3-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3999AB@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S19 02/15] ice: Cleanup an unnecessary
> variable initialization
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Commit 3463688e6ced ("ice: Add more validation in
> ice_vc_cfg_irq_map_msg") added an assignment of vsi making the
> assignment during declaration unnecessary.
> 
> Also, cleanup the declaration and assignment of irqmap_info to not use two
> lines in the variable declaration section.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:12:50 +0000
Subject: [Intel-wired-lan] [PATCH S27 10/15] ice: Add ice_get_main_vsi
 to get PF/main VSI
In-Reply-To: <20190808143938.4968-10-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-10-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D411679@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 10/15] ice: Add ice_get_main_vsi to get
> PF/main VSI
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> There are multiple places where we currently use ice_find_vsi_by_type to
> get the PF (a.k.a. main) VSI. The PF VSI by definition is always the first
> element in the pf->vsi array (i.e. pf->vsi[0]). So instead add and use a new
> helper function ice_get_main_vsi, which just returns
> pf->vsi[0].
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 20 +++++++-------------
>  drivers/net/ethernet/intel/ice/ice_main.c |  6 +++---
>  2 files changed, 10 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



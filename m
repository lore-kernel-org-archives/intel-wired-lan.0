From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:26:20 +0000
Subject: [Intel-wired-lan] [PATCH S35 09/15] ice: Fix VF link state when
 it's IFLA_VF_LINK_STATE_AUTO
In-Reply-To: <20191212111307.33566-9-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-9-anthony.l.nguyen@intel.com>
Message-ID: <7e48bbe31efc4747a7e19ee4d384fe86@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 09/15] ice: Fix VF link state when it's
> IFLA_VF_LINK_STATE_AUTO
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the flow for ice_set_vf_link_state() is not configuring link the same
> as all other VF link configuration flows. Fix this by only setting the necessary
> VF members in ice_set_vf_link_state() and then call
> ice_vc_notify_link_state() to actually configure link for the VF. This made
> ice_set_pfe_link_forced() unnecessary, so it was deleted. Also, this
> commonizes the link flows for the VF to all call ice_vc_notify_link_state().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     |  3 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 56 ++++---------------
>  2 files changed, 12 insertions(+), 47 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



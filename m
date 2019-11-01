From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:41:05 +0000
Subject: [Intel-wired-lan] [PATCH S32 01/15] ice: Use ice_ena_vsi and
 ice_dis_vsi in DCB configuration flow
In-Reply-To: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
Message-ID: <4b1c4256703342dd9c0622c5f58bb1ad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 01/15] ice: Use ice_ena_vsi and
> ice_dis_vsi in DCB configuration flow
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> DCB configuration flow needs to disable and enable only the PF (main) VSI,
> so use ice_ena_vsi and ice_dis_vsi. To avoid the use of ifdef to control the
> staticness of these functions, move them to ice_lib.c.
> 
> Also change devm* to kzalloc/kfree in ice_pf_dcb_cfg()
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  4 -
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 28 +++++--
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 56 ++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  4 +
>  drivers/net/ethernet/intel/ice/ice_main.c    | 79 --------------------
>  5 files changed, 82 insertions(+), 89 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



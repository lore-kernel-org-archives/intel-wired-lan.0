From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:34:16 +0000
Subject: [Intel-wired-lan] [PATCH S32 v3 01/15] ice: Use ice_ena_vsi and
 ice_dis_vsi in DCB configuration flow
In-Reply-To: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
Message-ID: <c5287da0b80b451694b215081a4e7f5b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 6, 2019 2:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 v3 01/15] ice: Use ice_ena_vsi and
> ice_dis_vsi in DCB configuration flow
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> DCB configuration flow needs to disable and enable only the PF (main) VSI,
> so use ice_ena_vsi and ice_dis_vsi. To avoid the use of ifdef to control the
> staticness of these functions, move them to ice_lib.c.
> 
> Also replace the allocate and copy of old_cfg to kmemdup() in
> ice_pf_dcb_cfg().
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v3:
> - Use kmemdup instead of kzalloc + memcpy
> v2:
> - Add null check after allocation of old_cfg
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  4 -
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 31 ++++++--
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 56 ++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  4 +
>  drivers/net/ethernet/intel/ice/ice_main.c    | 79 --------------------
>  5 files changed, 84 insertions(+), 90 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



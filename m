From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 21:56:21 +0000
Subject: [Intel-wired-lan] [PATCH S8 05/16] ice: Remove duplicate
 addition of VLANs in replay path
In-Reply-To: <20181026174105.11628-6-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328CC9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 05/16] ice: Remove duplicate addition of
> VLANs in replay path
> 
> ice_restore_vlan and active_vlans were originally put in place to reprogram
> VLAN filters in the replay path. This is now done as part of the much broader
> VSI rebuild/replay framework. So remove both ice_restore_vlan and
> active_vlans
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h             |  1 -
>  drivers/net/ethernet/intel/ice/ice_main.c        | 42 ++++--------------------
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  2 --
>  3 files changed, 6 insertions(+), 39 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



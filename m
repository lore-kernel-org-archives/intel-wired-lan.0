From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:30:45 +0000
Subject: [Intel-wired-lan] [PATCH v4 08/13] ice: Set VLAN flags correctly
In-Reply-To: <20180809132903.22819-9-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-9-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545A5B@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 08/13] ice: Set VLAN flags correctly
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> In the struct ice_aqc_vsi_props the field port_vlan_flags is an overloaded
> term because it is used for both port VLANs (PVLANs) and regular VLANs.
> This is an issue and is very confusing especially when dealing with VFs
> because normal VLANs and port VLANs are not the same.
> To fix this the field was renamed to vlan_flags and all of the #define's labeled
> *_PVLAN_* were renamed to *_VLAN_* if they are not specific to port
> VLANs.
> 
> Also in ice_vsi_manage_vlan_stripping, set the
> ICE_AQ_VSI_VLAN_MODE_ALL bit to allow the driver to add a VLAN tag to all
> packets it sends.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 24 +++++++-------
>  drivers/net/ethernet/intel/ice/ice_main.c     | 31 +++++++++++--------
>  2 files changed, 30 insertions(+), 25 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>



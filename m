From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:40:10 +0000
Subject: [Intel-wired-lan] [PATCH 5/8] ice: Update comment for
 ice_fltr_mgmt_list_entry
In-Reply-To: <20180920002311.10891-6-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
 <20180920002311.10891-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC3D7@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 5/8] ice: Update comment for
> ice_fltr_mgmt_list_entry
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Previously the comment stated that VSI lists should be used when a second
> VSI becomes a subscriber to the "VLAN address". VSI lists are always used for
> VLAN membership, so replace "VLAN address" with "MAC address". Also
> note that VLAN(s) always use VSI list rules.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



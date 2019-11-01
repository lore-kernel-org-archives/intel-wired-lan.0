From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:44:29 +0000
Subject: [Intel-wired-lan] [PATCH S32 11/15] ice: Update enum
 ice_flg64_bits to current specification
In-Reply-To: <20191025143441.50151-11-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
 <20191025143441.50151-11-anthony.l.nguyen@intel.com>
Message-ID: <55de0d1a288a46b0bd571ae7a474dedf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 11/15] ice: Update enum ice_flg64_bits
> to current specification
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the VLAN ice_flg64_bits are off by 1. Fix this by setting the
> ICE_FLG_EVLAN_x8100 flag to 14, which also updates
> ICE_FLG_EVLAN_x9100 to 15 and ICE_FLG_VLAN_x8100 to 16.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



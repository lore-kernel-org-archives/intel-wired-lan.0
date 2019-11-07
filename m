From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:39:48 +0000
Subject: [Intel-wired-lan] [PATCH S32 v3 11/15] ice: Update enum
 ice_flg64_bits to current specification
In-Reply-To: <20191106100541.48639-11-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
 <20191106100541.48639-11-anthony.l.nguyen@intel.com>
Message-ID: <a80ac62baf9f419ea74211cb3a73d3b3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 6, 2019 2:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 v3 11/15] ice: Update enum
> ice_flg64_bits to current specification
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



From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 14 Feb 2019 22:46:57 +0000
Subject: [Intel-wired-lan] [PATCH S11 02/16] ice: Fix the calculation of
 ICE_MAX_MTU
In-Reply-To: <20190208205043.11975-3-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3661E2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 02/16] ice: Fix the calculation of
> ICE_MAX_MTU
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Currently ICE_MAX_MTU subtracts only ETH_HLEN from max frame size and
> adds ETH_FCS_LEN and VLAN_HLEN, which is not what was intended.
> The ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN expression should be
> surrounded with parentheses.
> 
> Wrap mentioned expression and take into account VLAN double tagging.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



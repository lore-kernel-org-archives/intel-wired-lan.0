From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Apr 2018 20:56:41 +0000
Subject: [Intel-wired-lan] [next PATCH S90 3/8] i40e: Add advertising
 10G LR mode
In-Reply-To: <20180420084140.8081-3-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
 <20180420084140.8081-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A976959@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, April 20, 2018 1:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Pawlak, Jakub <jakub.pawlak@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S90 3/8] i40e: Add advertising 10G LR
> mode
> 
> From: Jakub Pawlak <jakub.pawlak@intel.com>
> 
> The advertising 10G LR mode should be possible to set but in the function
> i40e_set_link_ksettings() check for this is missed. This patch adds check for
> 10000baseLR_Full flag for 10G modes.
> 
> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



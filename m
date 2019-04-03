From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Apr 2019 21:57:52 +0000
Subject: [Intel-wired-lan] [next PATCH S4 06/11] i40e: Fix the typo in
 adding 40GE KR4 mode
In-Reply-To: <20190329220840.51187-6-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
 <20190329220840.51187-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3787DD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 29, 2019 3:09 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S4 06/11] i40e: Fix the typo in adding
> 40GE KR4 mode
> 
> From: Grzegorz Siwik <grzegorz.siwik@intel.com>
> 
> This patch fixes the typo in I40E_CAP_PHY_TYPE mode link code.
> It was fixed by changing 40000baseLR4_Full to 40000baseKR4_Full
> 
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



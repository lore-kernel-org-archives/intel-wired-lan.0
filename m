From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Oct 2015 19:17:51 +0000
Subject: [Intel-wired-lan] [next PATCH S17 07/11] i40e: fix for PHY
	NVM	interaction problem
In-Reply-To: <1443464220-148318-8-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B319D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:17 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S17 07/11] i40e: fix for PHY NVM
> interaction problem
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes a problem where the NVMUpdate Tool, when using the PHY
> NVM feature, gets bad data from the PHY because of contention on the
> MDIO interface from get phy capability calls from the driver during regular
> operations.  The problem is fixed by adding a check if media is available
> before calling get phy capability function because that bit is not set when
> device is in PHY interaction mode.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Ib89991b0f841808dd92410f5e8683d6ee3301cd0
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, able to dump and verify PHY flash using LANConf successfully. (QV Driverless Mode)

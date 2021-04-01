From: Switzer, David <david.switzer@intel.com>
Date: Thu, 1 Apr 2021 22:07:23 +0000
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix parameters in
 aq_get_phy_register()
In-Reply-To: <1616576307-54213-1-git-send-email-grzegorz.siwik@intel.com>
References: <1616576307-54213-1-git-send-email-grzegorz.siwik@intel.com>
Message-ID: <MW3PR11MB47487B607A77DBA3E6D0997DEB7B9@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Grzegorz Siwik
>Sent: Wednesday, March 24, 2021 1:58 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
>Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix parameters in
>aq_get_phy_register()
>
>Change parameters order in aq_get_phy_register() due to wrong statistics in
>PHY reported by ethtool. Previously all PHY statistics were exactly the same
>for all interfaces Now statistics are reported correctly - different for different
>interfaces
>
>Fixes: 0514db37dd78 ("i40e: Extend PHY access with page change flag")
>Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
>---
>v2:
>-Changed target tree to net
>---
>v3:
>-Fixed typo in commit message
>---
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
 


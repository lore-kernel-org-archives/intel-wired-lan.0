From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Jan 2016 22:19:34 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 05/15] i40e: use new
 add_veb	calling with veb stats control
In-Reply-To: <1452732712-12248-6-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-6-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F980968@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 05/15] i40e: use new add_veb
> calling with veb stats control
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> The new parameters for add_veb allow us to enable and disable VEB stats, so
> let's use them.
> 
> Update copyright year.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ie6e68c68e2d1d459e42168eda661051b56bf0a65
> ---
> Testing Hints: These commands should now do something useful:
> 	ethtool --set-priv-flags eth0 veb-stats on
> 	ethtool --set-priv-flags eth0 veb-stats off
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 11 ++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  4 ++--
>  2 files changed, 10 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, VEB stat collection and display controllable via priv-flags

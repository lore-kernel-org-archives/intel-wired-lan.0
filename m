From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 20:59:56 +0000
Subject: [Intel-wired-lan] [next PATCH S12 12/15] i40e: add switch for
 link	polling
In-Reply-To: <1440690163-128213-13-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5E2C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S12 12/15] i40e: add switch for link
> polling
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> There's been some need for controlling the periodic link polling for
> debugging link issues.  This patch enables switching it off and on through an
> ethtool private flag.  The link poll remains on by default, but can be turned
> off with
> 	ethtool --set-priv-flags p261p1 LinkPolling off and later turned back
> on with
> 	ethtool --set-priv-flags p261p1 LinkPolling on
> 
> To check the current status, use
> 	ethtool --show-priv-flags p261p1
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I32e4ab654ff3eec90a06cf144899971b82d71c40
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 26
> ++++++++++++++++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  4 +++-
>  3 files changed, 29 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, switch present and functions in ethtool.

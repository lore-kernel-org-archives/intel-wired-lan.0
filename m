From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 2 Oct 2015 16:49:20 +0000
Subject: [Intel-wired-lan] [next PATCH S17 06/11] i40e: Fix for
	Tools	loopback test failing after driver load
In-Reply-To: <1443464220-148318-7-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2E57@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S17 06/11] i40e: Fix for Tools loopback
> test failing after driver load
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes a problem where our Tools MAC Loopback test, after driver
> unbind would fail.  This was because the hw was configured for multiqueue
> and unbind operation did not clear this configuration.
> The problem is fixed by resetting this configuration in i40e_remove.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I130c05138319182ed1476d3a0b5222d6a6320af9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, MAC loopback test passes in LANConf.

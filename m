From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 17:50:49 +0000
Subject: [Intel-wired-lan] [next PATCH S24 03/12] i40e/i40evf: Fix
	for	UDP/TCP RSS for X722
In-Reply-To: <1450823114-29514-4-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
 <1450823114-29514-4-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9800F4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Tuesday, December 22, 2015 2:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S24 03/12] i40e/i40evf: Fix for
> UDP/TCP RSS for X722
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The PCTYPES for the X710 and X722 families are different. This patch makes
> adjustments for that.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 18 ++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  6 +++++
> drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 29
> +++++++++++++++++++---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  8 +++---
>  4 files changed, 54 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, RSS works on X722 with TCP and UDP traffic

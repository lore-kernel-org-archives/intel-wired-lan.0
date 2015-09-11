From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 16:03:23 +0000
Subject: [Intel-wired-lan] [next PATCH S15 05/15] i40e: Remove 100M
 SGMII	unless hw is X722
In-Reply-To: <1441315142-173025-6-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A63AF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 03, 2015 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S15 05/15] i40e: Remove 100M SGMII
> unless hw is X722
> 
> Only the X722 device now supports 100M SGMII, and nothing supports 100M
> on 1000Base_T.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I6f44dcd818944edd40041410e6de380f4a359a0c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 42 ++++++++++++++++----
> ------
>  1 file changed, 26 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree

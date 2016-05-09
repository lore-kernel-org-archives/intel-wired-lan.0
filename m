From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 May 2016 16:44:56 +0000
Subject: [Intel-wired-lan] [next PATCH S36 07/12] i40e: change Rx
	hang	message into a WARN_ONCE
In-Reply-To: <1462313600-3123-8-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5E98@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 07/12] i40e: change Rx hang
> message into a WARN_ONCE
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Use WARN_ONCE in order to highlight the issue, but don't display a warning
> every time. The user should be able to see the ethtool counter we created if
> necessary to see how often it is occurring.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I40c4ea159819b64a7d33b7f5716749089791533a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver builds, compiles, and passes traffic.

From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Sep 2016 19:10:39 +0000
Subject: [Intel-wired-lan] [next PATCH S48 6/7] i40e: Removal of
 workaround	for simple MAC address filter deletion
In-Reply-To: <1475000934-27335-7-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
 <1475000934-27335-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0F045@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 27, 2016 11:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S48 6/7] i40e: Removal of workaround
> for simple MAC address filter deletion
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This is code refactoring. This patch removes the workaround which deleted a
> default MAC filter added by the firmware when the interface was brought
> up. This filter caused frames to pass disregarding the VLAN tagging.
> It used to be automatically applied after reset in pre-SRA FW versions.
> This workaround is not needed in production NICs and hence can be
> removed.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> Change-ID: I129fe1aae1f17b5a224c9b29a996d916aa1be1ec
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 41 -----------------------------
>  1 file changed, 41 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied, driver builds, compiles, and passes traffic correctly.



From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Nov 2016 23:51:02 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 09/15] i40e: Driver prints
 log	message on link speed change
In-Reply-To: <1478639119-14656-10-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA36E15@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S52-V2 09/15] i40e: Driver prints log
> message on link speed change
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch makes the driver log link speed change. Before applying the patch
> link messages were printed only on state change. Now message is printed
> when link is brought up or down and when speed changes.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> Change-ID: Ifbee14b4b16c24967450b3cecac6e8351dcc8f74
> ---
> Testing-hints:
>   Check that link message is logged in system log when link speed
>   changes. Use lanconf and a device with backplane NVM image.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



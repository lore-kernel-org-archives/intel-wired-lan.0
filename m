From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Oct 2015 21:59:09 +0000
Subject: [Intel-wired-lan] [next PATCH S20 01/15] i40e: add new fields
 to	store user configuraion
In-Reply-To: <1445903081-155893-2-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D4B97@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, October 26, 2015 4:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Helin
> Subject: [Intel-wired-lan] [next PATCH S20 01/15] i40e: add new fields to
> store user configuraion
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> This patch adds new fields to i40e_vsi to store user configured RSS config
> data and code to use it.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: I73886469dca9e9f6b16d842182a87f3f4009f95d
> 
> ---
> Testing-hints: Test with the next patch.
>  drivers/net/ethernet/intel/i40e/i40e.h         |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 31 +++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 52
> +++++++++++++++++++++++---
>  3 files changed, 68 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ethtool -x/X and -l/L show and set correct data, data persists across resets.

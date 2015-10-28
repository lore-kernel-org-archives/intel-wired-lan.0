From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 21:21:00 +0000
Subject: [Intel-wired-lan] [next PATCH S20 07/15] i40evf: create a
 generic	get rss function
In-Reply-To: <1445903081-155893-8-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D483C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, October 26, 2015 4:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Helin
> Subject: [Intel-wired-lan] [next PATCH S20 07/15] i40evf: create a generic get
> rss function
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> There are two ways to get RSS, this patch implements two functions with the
> same input parameters, and creates a more generic function for getting RSS
> configuration.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: I12d3b712c21455d47dd0a5aae58fc9b7c680db59
> 
> ---
> Testing-hints: Test RSS still works right on multiple RX queues in the VF (via
> testing multiple flows RX). Test setting RSS indirection table via ethtool -X,
> and reading via ethtool -x works.
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  2 +
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 35 +++++---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 97
> ++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ethtool -x and -X work correctly, able to use RSS with multiple RX queues in VF

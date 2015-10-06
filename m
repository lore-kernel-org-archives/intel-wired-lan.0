From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Oct 2015 21:19:42 +0000
Subject: [Intel-wired-lan] [next PATCH S18 5/8] i40e: fix
	inconsistent	statuses after a PF reset
In-Reply-To: <1443724661-92168-6-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B3821@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, October 01, 2015 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Helin
> Subject: [Intel-wired-lan] [next PATCH S18 5/8] i40e: fix inconsistent statuses
> after a PF reset
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> This patch fixes a problem of possibly getting inconsistent flow control
> statuses after a PF reset. Requested_mode was being set with a default
> value during probing, but the initial HW state could be different from this
> mode.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: I772bf07b78616e87086418d4bd87954b66fa17cd
> 
> ---
> Testing-hints: 5644395
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, statuses stayed consistent after reset

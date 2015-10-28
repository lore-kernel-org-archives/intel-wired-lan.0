From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 21:32:23 +0000
Subject: [Intel-wired-lan] [next PATCH S20 10/15] i40e: fix confusing
 message
In-Reply-To: <1445903081-155893-11-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D486F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S20 10/15] i40e: fix confusing message
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> This patch fixes the confusing kernel message of enabled RSS size, by
> reporting it together with the hardware maximum RSS size.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: I64864dbfbc13beccc180a7871680def1f3d5a339
> 
> ---
> Testing-hints: Check for "RSS count/HW max RSS count" in dmesg when the
> RSS size is changed through "ethtool -l ethx", especially when the number of
> queues are brought down.
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, updated message appears in dmesg when changing RSS queue size.

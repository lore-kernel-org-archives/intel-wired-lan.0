From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Oct 2015 21:59:28 +0000
Subject: [Intel-wired-lan] [next PATCH S20 02/15] i40e: rename rss_size
 to	alloc_rss_size in i40e_pf
In-Reply-To: <1445903081-155893-3-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D4BA8@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S20 02/15] i40e: rename rss_size to
> alloc_rss_size in i40e_pf
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> This patch renames rss_size to alloc_rss_size in i40e_pf, which is clearer and
> avoids confusion. It also adds comments to the other related structure
> members to help clarify usage.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: Ia90090609d006ab589cb639975bb8a0af795d16f
> 
> ---
> Testing-hints: Test all the RSS knobs from ethtool for X[L]710 and X722.
>  drivers/net/ethernet/intel/i40e/i40e.h      |  8 ++++----
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 31 +++++++++++++++++-----
> -------
>  2 files changed, 22 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ethtool -x/X and -l/L show and set correct data, data persists across resets.

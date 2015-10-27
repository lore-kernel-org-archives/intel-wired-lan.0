From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 27 Oct 2015 15:26:46 +0000
Subject: [Intel-wired-lan] [next PATCH S19 14/15] i40e: create a
	generic	configure rss function
In-Reply-To: <1445471784-36024-2-git-send-email-catherine.sullivan@intel.com>
References: <1445471784-36024-1-git-send-email-catherine.sullivan@intel.com>
 <1445471784-36024-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D43F4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Helin
> Subject: [Intel-wired-lan] [next PATCH S19 14/15] i40e: create a generic
> configure rss function
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> This patch renames the old pf-specific function in order to clarify its scope.
> This patch also creates a more generic configure RSS function with the old
> name.
> 
> This patch also creates a new more generic function to get RSS configuration,
> using the appropriate method.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: Ieddca2707b708ef19f1ebccdfd03a0a0cd63d3af
> 
> ---
> Testing-hints: Test RSS hooks from ethtool for X[L]710 and X722.
>  drivers/net/ethernet/intel/i40e/i40e.h         |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 72 ++++++++++------------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 85
> ++++++++++++++++++++++----
>  3 files changed, 107 insertions(+), 52 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, settings with ethtool -X and -L set correctly, and persist across PF and global resets

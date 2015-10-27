From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 27 Oct 2015 15:25:36 +0000
Subject: [Intel-wired-lan] [next PATCH S19 13/15] i40e: rework the
 functions	to configure RSS with similar parameters
In-Reply-To: <1445471784-36024-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471784-36024-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D43E4@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S19 13/15] i40e: rework the functions
> to configure RSS with similar parameters
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> Adjust the RSS configure functions so that there is a generic way to hook to
> ethtool hooks.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: If446e34fcfaf1bc3320d9d319829a095b5976e67
> 
> ---
> Testing-hints: Test with next patch.
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 95
> +++++++++++++++++++-------
>  3 files changed, 71 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied

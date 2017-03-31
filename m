From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Mar 2017 19:39:11 +0000
Subject: [Intel-wired-lan] [next-queue v6 PATCH 6/7] i40e: Add support
 for	exposing switch port statistics via port netdevs
In-Reply-To: <1490833375-2788-7-git-send-email-sridhar.samudrala@intel.com>
References: <1490833375-2788-1-git-send-email-sridhar.samudrala@intel.com>
 <1490833375-2788-7-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040AA09@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Wednesday, March 29, 2017 5:23 PM
> To: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Duyck,
> Alexander H <alexander.h.duyck@intel.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; jakub.kicinski at netronome.com;
> gerlitz.or at gmail.com; jiri at resnulli.us; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>
> Subject: [Intel-wired-lan] [next-queue v6 PATCH 6/7] i40e: Add support for
> exposing switch port statistics via port netdevs
> 
> By default stats counted by HW are returned via the original
> ndo_get_stats64() api. Stats counted in SW are returned via
> ndo_get_offload_stats() api.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  10 +++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 125
> ++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_txrx.c |  24 +++++-
>  3 files changed, 158 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



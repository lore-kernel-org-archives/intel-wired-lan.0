From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 23 Mar 2018 18:55:46 +0000
Subject: [Intel-wired-lan] [PATCH v3 2/2] i40e: add support for
 XDP_REDIRECT
In-Reply-To: <20180322151434.24338-2-bjorn.topel@gmail.com>
References: <20180322151434.24338-1-bjorn.topel@gmail.com>
 <20180322151434.24338-2-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A957988@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bj?rn T?pel
> Sent: Thursday, March 22, 2018 8:15 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>;
> Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v3 2/2] i40e: add support for
> XDP_REDIRECT
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> The driver now acts upon the XDP_REDIRECT return action. Two new ndos
> are implemented, ndo_xdp_xmit and ndo_xdp_flush.
> 
> XDP_REDIRECT action enables XDP program to redirect frames to other
> netdevs.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 74
> +++++++++++++++++++++++++----
> drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +
>  3 files changed, 68 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 22:23:23 +0000
Subject: [Intel-wired-lan] [next PATCH S82-V4 7/9] i40e:
 link_down_on_close private flag support
In-Reply-To: <20171114120052.86665-7-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
 <20171114120052.86665-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEEE4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, November 14, 2017 4:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Stachura, Mariusz <mariusz.stachura@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S82-V4 7/9] i40e: link_down_on_close
> private flag support
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> This patch introduces new ethtool private flag used for forcing true link state.
> Function i40e_force_link_state that implements this functionality was added,
> it sets phy_type = 0 in order to work-around firmware's LESM. False positive
> error messages were suppressed.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 71
> ++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



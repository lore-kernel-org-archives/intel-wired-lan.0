From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 21:33:02 +0000
Subject: [Intel-wired-lan] [next PATCH S7 1/9] i40e: fix incorrect
 ethtool statistics veb and veb.tc_
In-Reply-To: <20190702122259.79070-1-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD210@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 2, 2019 5:23 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Golovanov, Dmitrii <dmitrii.golovanov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S7 1/9] i40e: fix incorrect ethtool
> statistics veb and veb.tc_
> 
> From: Dmitrii Golovanov <dmitrii.golovanov@intel.com>
> 
> This patch fixes missing call of i40e_update_veb_stats() in function
> i40e_get_ethtool_stats() to update stats data of VEB and VEB TC counters
> before they are written into ethtool buffer.
> Before the patch ethtool counters may fell behind interface counters.
> 
> Signed-off-by: Dmitrii Golovanov <dmitrii.golovanov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 +++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



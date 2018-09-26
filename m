From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:58:16 +0000
Subject: [Intel-wired-lan] [PATCH 14/16] ice: Use the right function to
 enable/disable VSI
In-Reply-To: <20180920002339.11107-15-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
 <20180920002339.11107-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC4F6@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 14/16] ice: Use the right function to
> enable/disable VSI
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The ice_ena/dis_vsi should have a single differentiating factor to determine
> if the netdev_ops call is used or a direct call to ice_vsi_open/close.  This is if
> the netif is running or not.  If netif is running, use ndo_open/ndo_close.
> Else, use ice_vsi_open/ice_vsi_close.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



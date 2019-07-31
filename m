From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:12:22 +0000
Subject: [Intel-wired-lan] [PATCH S25 06/12] ice: Sanitize ice_ena_vsi
 and ice_dis_vsi
In-Reply-To: <20190725095401.24590-6-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-6-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EAAB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 2:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S25 06/12] ice: Sanitize ice_ena_vsi and
> ice_dis_vsi
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> 1. ndo_open and ndo_stop are implemented by ice_open and ice_stop
>    respectively. When enabling/disabling VSIs, just call
>    ice_open/ice_stop instead of ndo_open/ndo_stop.
> 
> 2. Rework logic around rtnl_lock/rtnl_unlock
> 
> 3. In ice_ena_vsi, remove an unnecessary stack variable and return
>    0 instead of err when __ICE_NEEDS_RESTART is not set.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++++------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 23:18:56 +0000
Subject: [Intel-wired-lan] [PATCH S19 05/15] ice: Fix hang when ethtool
 disables FW LLDP
In-Reply-To: <20190416172439.27908-6-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39B04D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S19 05/15] ice: Fix hang when ethtool
> disables FW LLDP
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> When disabling and enabling VSIs, there are a couple of flows that recursively
> acquire the RTNL lock which causes a deadlock.
> Fix that.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 31 ++++++++++++--------
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  5 ++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 +--
>  drivers/net/ethernet/intel/ice/ice_main.c    |  2 +-
>  4 files changed, 25 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



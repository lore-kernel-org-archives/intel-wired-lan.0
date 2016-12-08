From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 17:36:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: prefix Data Center
 Bridge	ops struct
In-Reply-To: <20161121095240.529ed49d@samsung9>
References: <20161121095240.529ed49d@samsung9>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39AD5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Stephen Hemminger
> Sent: Monday, November 21, 2016 9:53 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: prefix Data Center Bridge
> ops struct
> 
> From: Stephen Hemminger <sthemmin@microsoft.com>
> 
> Since dcbnl_ops is global, it should be prefixed by ixgbe_
> 
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h        | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



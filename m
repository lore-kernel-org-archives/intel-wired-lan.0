From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:46:20 +0000
Subject: [Intel-wired-lan] [PATCH S14 10/15] ice: add and use new
 ice_for_each_traffic_class() macro
In-Reply-To: <20190213185115.25877-11-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36721E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 13, 2019 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S14 10/15] ice: add and use new
> ice_for_each_traffic_class() macro
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> There are numerous for() loops iterating over each of the max traffic classes.
> Use a simple iterator macro instead to make the code cleaner.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c    | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_sched.c  | 2 +-
>  drivers/net/ethernet/intel/ice/ice_type.h   | 3 +++
>  4 files changed, 7 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



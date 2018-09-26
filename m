From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:57:33 +0000
Subject: [Intel-wired-lan] [PATCH 10/16] ice: Expand use of VSI handles
 part 2/2
In-Reply-To: <20180920002319.10971-11-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC4E6@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 10/16] ice: Expand use of VSI handles part
> 2/2
> 
> This patch is a continuation of the previous patch where VSI handles are used
> instead of VSI numbers.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c |  71 ++++++++-----
> drivers/net/ethernet/intel/ice/ice_common.h |  13 +--
>  drivers/net/ethernet/intel/ice/ice_lib.c    |  18 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c   |  22 ++--
>  drivers/net/ethernet/intel/ice/ice_sched.c  | 151 +++++++++------------------
> -
>  drivers/net/ethernet/intel/ice/ice_sched.h  |   5 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c |   6 +-
>  drivers/net/ethernet/intel/ice/ice_switch.h |   5 +
>  drivers/net/ethernet/intel/ice/ice_type.h   |   4 +-
>  9 files changed, 132 insertions(+), 163 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



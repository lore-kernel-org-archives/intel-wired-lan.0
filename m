From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:35:58 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 15/15] ice: Trivial fixes
In-Reply-To: <20200206092013.23388-15-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-15-anthony.l.nguyen@intel.com>
Message-ID: <0eeaa5c1860f4a89a1d99108483c96fd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 15/15] ice: Trivial fixes
> 
> This is a collection of trivial fixes including fixing whitespace, typos, function
> headers, reverse Christmas tree, etc.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> - Another whitespace fix
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |  1 +
>  drivers/net/ethernet/intel/ice/ice_common.c      |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_dcb.c         |  8 ++++----
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c     |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     | 14 +++++++-------
>  drivers/net/ethernet/intel/ice/ice_lib.c         |  7 ++++---
>  drivers/net/ethernet/intel/ice/ice_main.c        |  4 +++-
>  drivers/net/ethernet/intel/ice/ice_txrx.c        |  9 ++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx.h        |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_type.h        |  2 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  3 +--
>  11 files changed, 31 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



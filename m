From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:35:01 +0000
Subject: [Intel-wired-lan] [PATCH S33 10/15] ice: Add ice_pf_to_dev(pf)
 macro
In-Reply-To: <20191108142331.10221-10-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-10-anthony.l.nguyen@intel.com>
Message-ID: <0f070cbbbb5a44bba2f8675997aaeddd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 10/15] ice: Add ice_pf_to_dev(pf)
> macro
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> We use &pf->dev->pdev all over the code. Add a simple
> macro to do this for us. When multiple de-references
> like this are being done add a local struct device
> variable.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  drivers/net/ethernet/intel/ice/ice_base.c     |  22 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 112 +++++-----
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   2 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |  14 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  57 +++---
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 155 ++++++++------
>  drivers/net/ethernet/intel/ice/ice_main.c     | 171 ++++++++--------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 191 ++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |   4 +-
>  10 files changed, 389 insertions(+), 341 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



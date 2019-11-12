From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:34:33 +0000
Subject: [Intel-wired-lan] [PATCH S33 09/15] ice: Do not use devm*
 functions for local uses
In-Reply-To: <20191108142331.10221-9-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-9-anthony.l.nguyen@intel.com>
Message-ID: <7a3fe5635fc144f588e6ce6866e6e70d@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S33 09/15] ice: Do not use devm* functions
> for local uses
> 
> In situations where we alloc and free memory within the same function do
> not use the devm_* variants; use regular alloc and free functions. Remove
> any unused vars if there are no usages after these changes.
> 
> Also, replace an allocate and copy with kmemdup() and remove an
> unnecessary memset() to 0 after a kzalloc().
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 25 +++++----
> drivers/net/ethernet/intel/ice/ice_ethtool.c  | 50 ++++++++---------
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 54 +++++++++----------
>  drivers/net/ethernet/intel/ice/ice_main.c     | 24 ++++-----
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 15 +++---
>  5 files changed, 80 insertions(+), 88 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



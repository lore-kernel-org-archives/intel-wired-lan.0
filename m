From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Oct 2019 23:13:20 +0000
Subject: [Intel-wired-lan] [PATCH S30 1/9] ice: Introduce ice_base.c
In-Reply-To: <20191009140925.13997-1-anthony.l.nguyen@intel.com>
References: <20191009140925.13997-1-anthony.l.nguyen@intel.com>
Message-ID: <e308d8b7a26b46e1a8f2c8400623a6d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 1/9] ice: Introduce ice_base.c
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Remove a few uses of kernel configuration flags from ice_lib.c by
> introducing a new source file ice_base.c. Also move corresponding
> function prototypes from ice_lib.h to ice_base.h and include ice_base.h
> where required.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice.h          |   8 +
>  drivers/net/ethernet/intel/ice/ice_base.c     | 767 +++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_base.h     |  31 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 787 +-----------------
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  39 -
>  drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   2 -
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   1 +
>  10 files changed, 811 insertions(+), 827 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_base.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_base.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



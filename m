From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:41:46 +0000
Subject: [Intel-wired-lan] [PATCH S32 03/15] ice: Implement DCBNL support
In-Reply-To: <20191025143441.50151-3-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
 <20191025143441.50151-3-anthony.l.nguyen@intel.com>
Message-ID: <f08d16a67f7345f99a209a9a239b3b3d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 03/15] ice: Implement DCBNL support
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Implement interface layer for the DCBNL subsystem. These are the functions
> to support the callbacks defined in the dcbnl_rtnl_ops struct. These callbacks
> are going to be used to interface with the DCB settings of the device.
> Implementation of dcb_nl set functions and supporting SW DCB functions.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   2 +-
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  15 +-
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  15 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c   | 933 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.h   |  19 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   3 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   6 +
>  9 files changed, 991 insertions(+), 5 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_dcb_nl.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_dcb_nl.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



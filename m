From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Sep 2019 21:17:12 +0000
Subject: [Intel-wired-lan] [PATCH S29 v2 3/6] ice: Implement Dynamic
 Device Personalization (DDP) download
In-Reply-To: <20190906134626.37344-3-anthony.l.nguyen@intel.com>
References: <20190906134626.37344-1-anthony.l.nguyen@intel.com>
 <20190906134626.37344-3-anthony.l.nguyen@intel.com>
Message-ID: <f61537adc3884eeaa4d449ffc6a3efdb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, September 6, 2019 6:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S29 v2 3/6] ice: Implement Dynamic Device
> Personalization (DDP) download
> 
> Add the required defines, structures, and functions to enable downloading a
> DDP package.  Before download, checks are performed to ensure the
> package is valid and compatible.
> 
> Note that package download is not yet requested by the driver as further
> initialization is required to utilize the package.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  60 ++
>  drivers/net/ethernet/intel/ice/ice_common.c   |  40 +-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   4 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 607 ++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |  25 +
>  .../net/ethernet/intel/ice/ice_flex_type.h    | 372 +++++++++++
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |  26 +
>  9 files changed, 1136 insertions(+), 1 deletion(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_flex_pipe.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_flex_pipe.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_flex_type.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



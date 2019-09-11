From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 11 Sep 2019 18:59:46 +0000
Subject: [Intel-wired-lan] [PATCH S29 v3 5/6] ice: Enable DDP package
 download
In-Reply-To: <20190909134747.10415-5-anthony.l.nguyen@intel.com>
References: <20190909134747.10415-1-anthony.l.nguyen@intel.com>
 <20190909134747.10415-5-anthony.l.nguyen@intel.com>
Message-ID: <7f27d68d2bbd44bd9fcf3a74628d9516@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, September 9, 2019 6:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S29 v3 5/6] ice: Enable DDP package
> download
> 
> Attempt to request an optional device-specific DDP package file (one with
> the PCIe Device Serial Number in its name so that different DDP package files
> can be used on different devices). If the optional package file exists,
> download it to the device. If not, download the default package file.
> 
> Log an appropriate message based on whether or not a DDP package file
> exists and the return code from the attempt to download it to the device.  If
> the download fails and there is not already a package file on the device, go
> into "Safe Mode" where some features are not supported.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v3:
> - Fixed wording on error message
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  14 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  69 ++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  42 ++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   2 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  27 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |   4 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |   1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  92 +--
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 614 ++++++++++++++----
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   6 +
>  12 files changed, 679 insertions(+), 195 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



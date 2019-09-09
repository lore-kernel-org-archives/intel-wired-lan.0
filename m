From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Sep 2019 21:16:16 +0000
Subject: [Intel-wired-lan] [PATCH S29 v2 1/6] ice: send driver version
 to firmware
In-Reply-To: <20190906134626.37344-1-anthony.l.nguyen@intel.com>
References: <20190906134626.37344-1-anthony.l.nguyen@intel.com>
Message-ID: <481ba4c30b634bf890d6cb87a683648c@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S29 v2 1/6] ice: send driver version to
> firmware
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> The driver is required to send a version to the firmware to indicate that the
> driver is up. If the driver doesn't do this the firmware doesn't behave
> properly.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> - Modified error message when ice_send_version() fails
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 13 +++++++
>  drivers/net/ethernet/intel/ice/ice_common.c   | 37
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |  3 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 36 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |  8 ++++
>  6 files changed, 97 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



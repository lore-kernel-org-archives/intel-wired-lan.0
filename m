From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 10 Dec 2016 00:12:33 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Report driver version
	to	firmware for x550 devices
In-Reply-To: <1477524318-17574-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1477524318-17574-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39DA1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 26, 2016 4:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Report driver version to
> firmware for x550 devices
> 
> Some x550 devices require the driver version reported to its firmware; this
> patch sends the driver version string to the firmware through the host
> interface command for x550 devices.
> 
> v2:
>   Set ixgbe_set_fw_drv_ver_x550() to static
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |  7 ++-
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |  3 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |  5 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   | 14 +++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   | 58
> ++++++++++++++++++++++++-
>  5 files changed, 80 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



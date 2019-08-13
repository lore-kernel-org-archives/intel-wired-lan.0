From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:06:52 +0000
Subject: [Intel-wired-lan] [PATCH S27 01/15] ice: Limit Max TCs on
 devices with more than 4 ports
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D4115E6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 01/15] ice: Limit Max TCs on devices
> with more than 4 ports
> 
> From: Usha Ketineni <usha.k.ketineni@intel.com>
> 
> This patch limits the max TCs set by the driver to the value provided by the
> firmware as per the capabilities of the device. Otherwise, hardcoding to 8 TC
> max would fail the device configurations with more than 4 ports.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  1 +
>  drivers/net/ethernet/intel/ice/ice_common.c     | 12 ++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c    | 10 ++++++++--
>  drivers/net/ethernet/intel/ice/ice_type.h       |  3 +++
>  4 files changed, 24 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 5 Mar 2020 22:33:26 +0000
Subject: [Intel-wired-lan] [PATCH S34 v4 4/6] ice: Enable event
 notifications
In-Reply-To: <20200302233107.4691-4-anthony.l.nguyen@intel.com>
References: <20200302233107.4691-1-anthony.l.nguyen@intel.com>
 <20200302233107.4691-4-anthony.l.nguyen@intel.com>
Message-ID: <1f111c67cedc4cd79ea9e16def7fc419@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, March 2, 2020 3:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S34 v4 4/6] ice: Enable event notifications
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Enable registration of notifications. Peer devices can register to be notified of
> certain events as well as notify the driver of its state changes.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  37 ++++
>  drivers/net/ethernet/intel/ice/ice_idc.c     | 221 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c    |  27 ++-
>  4 files changed, 280 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



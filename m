From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Jun 2020 20:33:19 +0000
Subject: [Intel-wired-lan] [PATCH v2] ice: implement snapshot for device
 capabilities
In-Reply-To: <20200618184611.2641181-1-jacob.e.keller@intel.com>
References: <20200618184611.2641181-1-jacob.e.keller@intel.com>
Message-ID: <BN6PR1101MB2145BA08AEDB9B8AB7D2401C8C970@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Thursday, June 18, 2020 11:46 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v2] ice: implement snapshot for device
> capabilities
> 
> Add a new devlink region used for capturing a snapshot of the device
> capabilities buffer which is reported by the firmware over the AdminQ.
> This information can useful in debugging driver and firmware interactions.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> v2
> * Fixed ice_devlink_destroy_regions to properly release the new region
> 
>  drivers/net/ethernet/intel/ice/ice.h         |  1 +
>  drivers/net/ethernet/intel/ice/ice_common.c  | 66 +++++++++++++++-----
> drivers/net/ethernet/intel/ice/ice_common.h  |  3 +
> drivers/net/ethernet/intel/ice/ice_devlink.c | 59 +++++++++++++++++
>  4 files changed, 115 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



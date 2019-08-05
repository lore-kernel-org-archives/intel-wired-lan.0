From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Aug 2019 21:40:12 +0000
Subject: [Intel-wired-lan] [PATCH S26 12/15] ice: update driver
 unloading field for Queue Shutdown AQ command
In-Reply-To: <20190802082533.23083-12-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
 <20190802082533.23083-12-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F116@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, August 2, 2019 1:26 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S26 12/15] ice: update driver unloading
> field for Queue Shutdown AQ command
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> According to recent specification versions, the field in the Queue Shutdown
> AdminQ command consisting of the "driver unloading" indication is not a 4
> byte field (it is byte.bit 16.0).  Change it to a byte and remove the
> unnecessary endian conversion.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_common.c     | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



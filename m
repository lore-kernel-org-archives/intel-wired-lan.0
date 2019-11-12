From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:30:24 +0000
Subject: [Intel-wired-lan] [PATCH S33 01/15] ice: Store number of
 functions for the device
In-Reply-To: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
Message-ID: <cf5d62db50994f23bb19997a797def93@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 01/15] ice: Store number of functions
> for the device
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Store the number of functions the device has and use this number when
> setting safe mode capabilities instead of calculating it.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Co-developed-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 21 ++++++++++-----------
>  drivers/net/ethernet/intel/ice/ice_type.h   |  1 +
>  2 files changed, 11 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



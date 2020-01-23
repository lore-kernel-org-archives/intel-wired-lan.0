From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:35:12 +0000
Subject: [Intel-wired-lan] [PATCH S34 v3 4/6] ice: Enable event
 notifications
In-Reply-To: <20200121162021.17107-4-anthony.l.nguyen@intel.com>
References: <20200121162021.17107-1-anthony.l.nguyen@intel.com>
 <20200121162021.17107-4-anthony.l.nguyen@intel.com>
Message-ID: <4d8e2346631446529c9c3dc775a5c02b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, January 21, 2020 8:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S34 v3 4/6] ice: Enable event notifications
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Enable registration of notifications. Peer devices can register to be notified of
> certain events as well as notify the driver of its state changes.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  34 +++
>  drivers/net/ethernet/intel/ice/ice_idc.c     | 221 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c    |  27 ++-
>  4 files changed, 277 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



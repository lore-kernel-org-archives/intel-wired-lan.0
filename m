From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:36:02 +0000
Subject: [Intel-wired-lan] [PATCH S39 01/15] ice: Validate config for SW
 DCB map
In-Reply-To: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
Message-ID: <5345c99b2a954dec98f34c28a4c62911@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, January 27, 2020 12:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 01/15] ice: Validate config for SW DCB
> map
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> Validate the inputs for SW DCB config received either via lldptool or pcap file.
> And don't apply DCB for bad bandwidth inputs or non-contiguous TCs.
> Without this patch, any config having bad inputs will cause the loss of link
> making PF unusable even after driver reload. Recoverable only via system
> reboot.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 55 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  1 +
> drivers/net/ethernet/intel/ice/ice_dcb_nl.c  |  7 +++
>  3 files changed, 63 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:37:32 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 01/15] ice: Validate config for
 SW DCB map
In-Reply-To: <20200213213059.33939-1-anthony.l.nguyen@intel.com>
References: <20200213213059.33939-1-anthony.l.nguyen@intel.com>
Message-ID: <ebef05a4d22e42b79d943e9b444c0b19@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 13, 2020 1:31 PM
> To: intel-wired-lan at lists.osuosl.org; pmenzel at molgen.mpg.de
> Subject: [Intel-wired-lan] [PATCH S39 v2 01/15] ice: Validate config for SW
> DCB map
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> Validate the inputs for SW DCB config received either via lldptool or pcap file.
> And don't apply DCB for bad bandwidth inputs. Without this patch, any config
> having bad inputs will cause the loss of link making PF unusable even after
> driver reload. Recoverable only via system reboot.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> - Allocate all bandwidth to TC0 if no TCs requested any bandwidth
> - Remove zero bandwidth check on non-TC0
> - Add message about reason for error and return from error immediately in
>   ice_dcb_bwchk()
> - Change a comment
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 40 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  1 +
> drivers/net/ethernet/intel/ice/ice_dcb_nl.c  |  6 +++
>  3 files changed, 47 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



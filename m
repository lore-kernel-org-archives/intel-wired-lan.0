From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 2 May 2022 14:25:58 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ice: fix PTP stale Tx
 timestamps cleanup
In-Reply-To: <20220420122302.574-1-michal.michalik@intel.com>
References: <20220420122302.574-1-michal.michalik@intel.com>
Message-ID: <BYAPR11MB3367C42485FDAA51FF9E45E8FCC19@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Michalik
> Sent: Wednesday, April 20, 2022 5:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Michalik, Michal <michal.michalik@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] ice: fix PTP stale Tx timestamps
> cleanup
> 
> Read stale PTP Tx timestamps from PHY on cleanup.
> 
> After running out of Tx timestamps request handlers, hardware (HW) stops
> reporting finished requests. Function ice_ptp_tx_tstamp_cleanup() used to
> only clean up stale handlers in driver and was leaving the hardware registers
> not read. Not reading stale PTP Tx timestamps prevents next interrupts from
> arriving and makes timestamping unusable.
> 
> v2:
> - update commit message,
> - added a comment to ice_read_phy_tstamp() call to clarify intentions.
> 
> v1[1]
> 
> [1] https://patchwork.ozlabs.org/project/intel-wired-
> lan/patch/20220414102358.13486-1-michal.michalik at intel.com/#2876713
> 
> Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)

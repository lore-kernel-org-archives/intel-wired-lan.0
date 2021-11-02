From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 2 Nov 2021 08:16:11 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: ignore dropped packets
 during init
In-Reply-To: <20211023002817.86671-1-jesse.brandeburg@intel.com>
References: <20211023002817.86671-1-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB3367B9668616B4A1E228C1B3FC8B9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
> Brandeburg
> Sent: Saturday, October 23, 2021 5:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] ice: ignore dropped packets during init
> 
> If the hardware is constantly receiving unicast or broadcast packets during
> driver load, the device previously counted many GLV_RDPC (VSI dropped
> packets) events during init. This causes confusing dropped packet statistics
> during driver load. The dropped packets counter incrementing does stop once
> the driver finishes loading.
> 
> Avoid this problem by baselining our statistics at the end of driver open instead
> of the end of probe.
> 
> Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> Testing Hints: pktgen or ping flood the DUT, while reloading the driver and
> bringing up the interface (in a script or with networkmanager) and note
> dropped packets with ip -s -s link or ifconfig, after this patch there should be
> none.
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)

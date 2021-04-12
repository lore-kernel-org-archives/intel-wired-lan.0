From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Mon, 12 Apr 2021 17:27:51 +0000
Subject: [Intel-wired-lan] [PATCH S58 03/13] ice: manage interrupts
 during poll exit
In-Reply-To: <20210331211708.55205-3-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-3-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105844C6858DAE45FE7F2E9FA709@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, March 31, 2021 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S58 03/13] ice: manage interrupts during
> poll exit
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver would occasionally miss that there were outstanding descriptors
> to clean when exiting busy/napi poll. This issue has been in the code since
> the introduction of the ice driver.
> 
> Attempt to "catch" any remaining work by triggering a software interrupt
> when exiting napi poll or busy-poll. This will not cause extra interrupts in the
> case of normal execution.
> 
> This issue was found when running sfnt-pingpong, with busy poll enabled,
> and typically with larger I/O sizes like > 8192, the program would occasionally
> report > 1 second maximums to complete a ping pong.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c       | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)



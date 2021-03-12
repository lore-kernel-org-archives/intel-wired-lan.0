From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 12 Mar 2021 22:13:37 +0000
Subject: [Intel-wired-lan] [PATCH S55 03/14] ice: Add Support for XPS
In-Reply-To: <20210302181213.51718-3-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
 <20210302181213.51718-3-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105654265C7B1ECA35F56BCFA6F9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S55 03/14] ice: Add Support for XPS
> 
> From: Benita Bose <benita.bose@intel.com>
> 
> Enable and configure XPS. The driver code implemented sets up the Transmit
> Packet Steering Map, which in turn will be used by the kernel in queue
> selection during Tx.
> 
> Signed-off-by: Benita Bose <benita.bose@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> Note: Emails to Benita will bounce as she has since left Intel
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 23
> +++++++++++++++++++++++  drivers/net/ethernet/intel/ice/ice_txrx.h |  6
> ++++++
>  2 files changed, 29 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel



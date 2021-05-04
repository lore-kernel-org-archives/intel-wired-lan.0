From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Tue, 4 May 2021 11:24:23 +0000
Subject: [Intel-wired-lan] [PATCH S54 08/14] ice: Refactor
 ice_setup_rx_ctx
In-Reply-To: <SN6PR11MB30081A2B88B7B247BEA481DBE25A9@SN6PR11MB3008.namprd11.prod.outlook.com>
References: <20201121003938.48514-1-anthony.l.nguyen@intel.com>
 <20201121003938.48514-8-anthony.l.nguyen@intel.com>
 <SN6PR11MB30081A2B88B7B247BEA481DBE25A9@SN6PR11MB3008.namprd11.prod.outlook.com>
Message-ID: <DM6PR11MB3292BE1D88E8FFB63243C1C4F15A9@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Saturday, November 21, 2020 6:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S54 08/14] ice: Refactor ice_setup_rx_ctx
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> Move AF_XDP logic and buffer allocation out of ice_setup_rx_ctx() to a new
> function ice_vsi_cfg_rxq(), so the function actually sets up the Rx context.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 120 +++++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_base.h |   2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  10 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c  |   2 +-
>  4 files changed, 78 insertions(+), 56 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel



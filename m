From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:25:21 +0000
Subject: [Intel-wired-lan] [PATCH S44 09/14] ice: Refactor
 ice_setup_rx_ctx
In-Reply-To: <20200516004226.4795-9-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-9-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165939D6D428C1AE34DDC3778CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 09/14] ice: Refactor ice_setup_rx_ctx
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> Move AF_XDP logic and buffer allocation out of ice_setup_rx_ctx() to a new
> function ice_vsi_cfg_rxq(), so the function actually sets up the Rx context.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 123 +++++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_base.h |   2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  10 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c  |   2 +-
>  4 files changed, 80 insertions(+), 57 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



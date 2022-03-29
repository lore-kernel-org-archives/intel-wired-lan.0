From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 29 Mar 2022 04:12:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add Inspur Ethernet
 Connection X722 for 10GbE SFP+ support
In-Reply-To: <20220325095456.20084-1-mateusz.palczewski@intel.com>
References: <20220325095456.20084-1-mateusz.palczewski@intel.com>
Message-ID: <BYAPR11MB33673B966790C96BB070A2BBFC1E9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Friday, March 25, 2022 3:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Patynowski,
> PrzemyslawX <przemyslawx.patynowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add Inspur Ethernet
> Connection X722 for 10GbE SFP+ support
> 
> Add support for Inspur Ethernet Connection X722 for 10GbE SFP+ cards.
> Make possible for the driver to bind to the card.
> 
> Testing Hints: no functionality loss for other cards, make sure the device
> loads
> 
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 1 +
> drivers/net/ethernet/intel/i40e/i40e_devids.h | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 1 +
>  3 files changed, 3 insertions(+)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)

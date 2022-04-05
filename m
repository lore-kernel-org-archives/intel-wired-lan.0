From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 5 Apr 2022 11:03:16 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: Add Ethernet
 Connection X722 for 10GbE SFP+ support
In-Reply-To: <20220329073543.7911-1-mateusz.palczewski@intel.com>
References: <20220329073543.7911-1-mateusz.palczewski@intel.com>
Message-ID: <BYAPR11MB33670F9A4DBBFA4F4A10238FFCE49@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Tuesday, March 29, 2022 1:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Patynowski,
> PrzemyslawX <przemyslawx.patynowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: Add Ethernet
> Connection X722 for 10GbE SFP+ support
> 
> Add support for Ethernet Connection X722 for 10GbE SFP+ cards.
> Make possible for the driver to bind to the card.
> 
> Testing Hints: no functionality loss for other cards, make sure the device
> loads
> 
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Removed word "Inspur" from commit title
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 1 +
> drivers/net/ethernet/intel/i40e/i40e_devids.h | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 1 +
>  3 files changed, 3 insertions(+)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)

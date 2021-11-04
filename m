From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Thu, 4 Nov 2021 20:49:41 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix RTNL deadlock with
 new flag IAVF_FLAG_REINIT_MSIX_NEEDED
In-Reply-To: <20210901091503.77708-1-karen.sornek@intel.com>
References: <20210901091503.77708-1-karen.sornek@intel.com>
Message-ID: <PH0PR11MB514401A2C465CE6009234A1BE28D9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Karen
> Sornek
> Sent: Wednesday, September 1, 2021 2:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Williams, Mitch A <mitch.a.williams@intel.com>; Sornek, Karen
> <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix RTNL deadlock with new flag
> IAVF_FLAG_REINIT_MSIX_NEEDED
> 
> The IAVF_FLAG_REINIT_ITR_NEEDED flag was being used for two different
> purposes. As originally written, it indicates to the ITR mechanism to update the
> interrupt registers to a new setting. Sometime later, it was overloaded to indicate
> that interrupts need to be completely reinitialized during reset. This causes
> problems when ethtool -C is used while a reset is in progress, and can lead to
> RTNL deadlocks.
> 
> To fix this, add a new flag IAVF_FLAG_REINIT_MSIX_NEEDED and use that to
> trigger MSI-X reinit.
> 
> Fixes: 129cf89e5856 ("iavf: rename functions and structs to new name")
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      | 1 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>  

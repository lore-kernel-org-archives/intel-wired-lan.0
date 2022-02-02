From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Feb 2022 10:07:12 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: Add waiting for
 response from PF in set mac
In-Reply-To: <20220126122459.4523-1-mateusz.palczewski@intel.com>
References: <20220126122459.4523-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB562176C57347C055A8470CFCAB279@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Wednesday, January 26, 2022 1:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Sylwester
> Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: Add waiting for response
> from PF in set mac
> 
> Make iavf_set_mac synchronous by waiting for a response from a PF.
> Without this iavf_set_mac is always returning success even though set_mac
> can be rejected by a PF.
> This ensures that when set_mac exits netdev MAC is updated.
> This is needed for sending ARPs with correct MAC after changing VF's MAC.
> This is also needed by bonding module.
> 
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Changed __IAVF_IN_CRITICAL_TASK to crit_lock
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |   7 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 123 +++++++++++++++---
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  63 ++++++++-
>  3 files changed, 172 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index a746f44..2b3ccc8 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

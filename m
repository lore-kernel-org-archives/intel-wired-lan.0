From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 31 May 2022 08:37:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4] iavf: Add waiting for
 response from PF in set mac
In-Reply-To: <20220520100713.6632-1-mateusz.palczewski@intel.com>
References: <20220520100713.6632-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB5621417A1F36B648A0E26946ABDC9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Friday, May 20, 2022 12:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v4] iavf: Add waiting for response
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
>  v4: Rewrited some code to avoid passing a value as a condition
>  v3: Resent the patch to apply to next-queue
>  v2: Changed __IAVF_IN_CRITICAL_TASK to crit_lock
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |   7 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 127 +++++++++++++++---
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  61 ++++++++-
>  3 files changed, 174 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 49aed3e..fda1198 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -146,7 +146,8 @@ struct iavf_mac_filter {

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

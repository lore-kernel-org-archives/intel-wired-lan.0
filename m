From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Feb 2022 10:12:19 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: Add usage of new
 virtchnl format to set default MAC
In-Reply-To: <20220119101521.1212-1-mateusz.palczewski@intel.com>
References: <20220119101521.1212-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB5621C9FE4762286666BDCEDEAB279@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Wednesday, January 19, 2022 11:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Sylwester Dziedziuch
> <sylwesterx.dziedziuch@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: Add usage of new
> virtchnl format to set default MAC
> 
> Use new type field of VIRTCHNL_OP_ADD_ETH_ADDR and
> VIRTCHNL_OP_DEL_ETH_ADDR requests to indicate that VF wants to change
> its default MAC address.
> 
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Fixed function description to fit in 80 characters per line limit
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c     | 12 +++++++++---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index ec4f85a..7fa29a8 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

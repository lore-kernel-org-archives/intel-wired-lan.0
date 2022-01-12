From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 12 Jan 2022 10:36:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3] iavf: Add support for
 50G/100G in AIM algorithm
In-Reply-To: <20220110150638.24305-1-mateusz.palczewski@intel.com>
References: <20220110150638.24305-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB562177A23CBA00A4A7545745AB529@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: poniedzia?ek, 10 stycznia 2022 16:07
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Brett Creeley
> <brett.creeley@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v3] iavf: Add support for
> 50G/100G in AIM algorithm
> 
> Advanced link speed support was added long back, but adding AIM support
> was missed. This patch adds AIM support for advanced link speed support,
> which allows the algorithm to take into account 50G/100G link speeds. Also,
> other previous speeds are taken into consideration when advanced link
> speeds are supported.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  v3: Fixed checkpatch errors
>  v2: Removed build issues
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 62 ++++++++++++++++-----
>  1 file changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index 8cbe7ad..978f651 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -374,29 +374,60 @@ static inline bool iavf_container_is_rx(struct
> iavf_q_vector *q_vector,

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

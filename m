From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 30 Mar 2022 17:28:53 +0000
Subject: [Intel-wired-lan] [PATCH intel-next] ice: introduce common
 helper for retrieving VSI by vsi_num
In-Reply-To: <20220324114907.73459-1-maciej.fijalkowski@intel.com>
References: <20220324114907.73459-1-maciej.fijalkowski@intel.com>
Message-ID: <DM8PR11MB56216945A750624D043AF8EAAB1F9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Thursday, March 24, 2022 12:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; kuba at kernel.org; bpf at vger.kernel.org;
> pabeni at redhat.com; davem at davemloft.net; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-next] ice: introduce common helper
> for retrieving VSI by vsi_num
> 
> Both ice_idc.c and ice_virtchnl.c carry their own implementation of a helper
> function that is looking for a given VSI based on provided vsi_num. Their
> functionality is the same, so let's introduce the common function in ice.h that
> both of the mentioned sites will use.
> 
> This is a strictly cleanup thing, no functionality is changed.
> 
> Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          | 15 +++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 15 -------------
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 22 ++-----------------
>  3 files changed, 17 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index e9aa1fb43c3a..a541446b96e8 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

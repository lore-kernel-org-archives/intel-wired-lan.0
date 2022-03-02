From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:59:36 +0000
Subject: [Intel-wired-lan] [net-next PATCH 14/25] ice: introduce VF
 operations structure for reset flows
In-Reply-To: <20220223002712.2771809-15-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-15-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56297613047AF773B305768BAB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 23, 2022 1:27 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH 14/25] ice: introduce VF
> operations structure for reset flows
> 
> The ice driver currently supports virtualization using Single Root IOV, with
> code in the ice_sriov.c file. In the future, we plan to also implement support
> for Scalable IOV, which uses slightly different hardware implementations for
> some functionality.
> 
> To eventually allow this, we introduce a new ice_vf_ops structure which will
> contain the basic operations that are different between the two IOV
> implementations. This primarily includes logic for how to handle the VF reset
> registers, as well as what to do before and after rebuilding the VF's VSI.
> 
> Implement these ops structures and call the ops table instead of directly
> calling the SR-IOV specific function. This will allow us to easily add the Scalable
> IOV implementation in the future. Additionally, it helps separate the
> generalized VF logic from SR-IOV specifics. This change allows us to move the
> reset logic out of ice_sriov.c and into ice_vf_lib.c without placing any Single
> Root specific details into the generic file.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c  | 318 +++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c |   4 +-
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h |  13 +
>  3 files changed, 196 insertions(+), 139 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 91d106528b66..be6ec42f97c1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -478,16 +478,6 @@ void ice_free_vfs(struct ice_pf *pf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

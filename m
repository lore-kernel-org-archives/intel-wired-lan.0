From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:00:05 +0000
Subject: [Intel-wired-lan] [net-next PATCH 13/25] ice: fix incorrect
 dev_dbg print mistaking 'i' for vf->vf_id
In-Reply-To: <20220223002712.2771809-14-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-14-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629F0CD1458FE8FB60EB184AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 13/25] ice: fix incorrect dev_dbg
> print mistaking 'i' for vf->vf_id
> 
> If we fail to clear the malicious VF indication after a VF reset, the dev_dbg
> message which is printed uses the local variable 'i' when it meant to use vf-
> >vf_id. Fix this.
> 
> Fixes: 0891c89674e8 ("ice: warn about potentially malicious VFs")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 2f74fcf51c2c..91d106528b66 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1381,7 +1381,8 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

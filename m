From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:57:02 +0000
Subject: [Intel-wired-lan] [net-next PATCH 15/25] ice: fix a long line
 warning in ice_reset_vf
In-Reply-To: <20220223002712.2771809-16-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-16-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629C189328C36A9ED1E9D4EAB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 15/25] ice: fix a long line warning
> in ice_reset_vf
> 
> We're about to move ice_reset_vf out of ice_sriov.c and into ice_vf_lib.c
> 
> One of the dev_err statements has a checkpatch.pl violation due to putting
> the vf->vf_id on the same line as the dev_err. Fix this style issue first before
> moving the code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index be6ec42f97c1..b2376e3b746e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1251,7 +1251,8 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

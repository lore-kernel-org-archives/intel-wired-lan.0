From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 16 Nov 2021 11:04:46 +0000
Subject: [Intel-wired-lan] [PATCH net 4/4] ice: fix FDIR init missing
 when reset VF
In-Reply-To: <20210505211800.11908-4-anthony.l.nguyen@intel.com>
References: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
 <20210505211800.11908-4-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB56211CF7761C56B42FF6D2E6AB999@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: ?roda, 5 maja 2021 23:18
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 4/4] ice: fix FDIR init missing when
> reset VF
> 
> From: Yahui Cao <yahui.cao@intel.com>
> 
> When VF is being reset, ice_reset_vf() will be called and FDIR resource
> should be released and initialized again.
> 
> Fixes: 1f7ea1cd6a37 ("ice: Enable FDIR Configure for AVF")
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index 4001dc723e1f..c827977f4539 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -1565,6 +1565,7 @@ bool ice_reset_all_vfs(struct ice_pf *pf, bool
> is_vflr)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

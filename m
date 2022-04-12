From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 12 Apr 2022 07:10:56 +0200
Subject: [Intel-wired-lan] [PATCH net-next 1/6] ice: add newline to
 dev_dbg in ice_vf_fdir_dump_info
In-Reply-To: <20220411232907.1022602-2-jacob.e.keller@intel.com>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
 <20220411232907.1022602-2-jacob.e.keller@intel.com>
Message-ID: <aa858f43-a62b-4ce8-c307-882e0ef90134@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jacob,


Am 12.04.22 um 01:29 schrieb Jacob Keller:
> The debug print in ice_vf_fdir_dump_info don't end in newlines. This can

Singular? does not

> look confusing when reading the kernel log, as the next print will
> immediately continue on the same line.
> 
> Fix this.
> 

Add a Fixes tag?

Maybe also add *forgotten* to the commit message summary:

Add forgotten newline ?

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> index 8e38ee2faf58..dbc1965c0609 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> @@ -1349,7 +1349,7 @@ static void ice_vf_fdir_dump_info(struct ice_vf *vf)
>   
>   	fd_size = rd32(hw, VSIQF_FD_SIZE(vsi_num));
>   	fd_cnt = rd32(hw, VSIQF_FD_CNT(vsi_num));
> -	dev_dbg(dev, "VF %d: space allocated: guar:0x%x, be:0x%x, space consumed: guar:0x%x, be:0x%x",
> +	dev_dbg(dev, "VF %d: space allocated: guar:0x%x, be:0x%x, space consumed: guar:0x%x, be:0x%x\n",
>   		vf->vf_id,
>   		(fd_size & VSIQF_FD_CNT_FD_GCNT_M) >> VSIQF_FD_CNT_FD_GCNT_S,
>   		(fd_size & VSIQF_FD_CNT_FD_BCNT_M) >> VSIQF_FD_CNT_FD_BCNT_S,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

From: Venkataramanan, Anirudh <anirudh.venkataramanan@intel.com>
Date: Thu, 29 Mar 2018 16:31:31 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error return code
 in ice_init_hw()
In-Reply-To: <1522241445-77090-1-git-send-email-weiyongjun1@huawei.com>
References: <1522241445-77090-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <1522341089.15392.172.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-03-28 at 12:50 +0000, Wei Yongjun wrote:
> Fix to return error code ICE_ERR_NO_MEMORY from the alloc error
> handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: dc49c7723676 ("ice: Get MAC/PHY/link info and scheduler
> topology")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> b/drivers/net/ethernet/intel/ice/ice_common.c
> index 385f5d4..21977ec 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -468,8 +468,10 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
>  	mac_buf_len = sizeof(struct ice_aqc_manage_mac_read_resp);
>  	mac_buf = devm_kzalloc(ice_hw_to_dev(hw), mac_buf_len,
> GFP_KERNEL);
>  
> -	if (!mac_buf)
> +	if (!mac_buf) {
> +		status = ICE_ERR_NO_MEMORY;
>  		goto err_unroll_fltr_mgmt_struct;
> +	}
>  
>  	status = ice_aq_manage_mac_read(hw, mac_buf, mac_buf_len,
> NULL);
>  	devm_kfree(ice_hw_to_dev(hw), mac_buf);
> 

Acked-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Thanks!
Ani
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3302 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180329/75d04e0d/attachment.bin>

From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Tue, 9 Mar 2021 09:02:35 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix error handling in
 e1000_set_d0_lplu_state_82571
In-Reply-To: <20210228094424.7884-1-dinghao.liu@zju.edu.cn>
References: <20210228094424.7884-1-dinghao.liu@zju.edu.cn>
Message-ID: <3cc37aec-bd27-235a-7c37-e8f1113c6a3c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 28/02/2021 11:44, Dinghao Liu wrote:
> There is one e1e_wphy() call in e1000_set_d0_lplu_state_82571
> that we have caught its return value but lack further handling.
> Check and terminate the execution flow just like other e1e_wphy()
> in this function.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   drivers/net/ethernet/intel/e1000e/82571.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/82571.c b/drivers/net/ethernet/intel/e1000e/82571.c
> index 88faf05e23ba..0b1e890dd583 100644
> --- a/drivers/net/ethernet/intel/e1000e/82571.c
> +++ b/drivers/net/ethernet/intel/e1000e/82571.c
> @@ -899,6 +899,8 @@ static s32 e1000_set_d0_lplu_state_82571(struct e1000_hw *hw, bool active)
>   	} else {
>   		data &= ~IGP02E1000_PM_D0_LPLU;
>   		ret_val = e1e_wphy(hw, IGP02E1000_PHY_POWER_MGMT, data);
> +		if (ret_val)
> +			return ret_val;
>   		/* LPLU and SmartSpeed are mutually exclusive.  LPLU is used
>   		 * during Dx states where the power conservation is most
>   		 * important.  During driver activity we should enable
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>

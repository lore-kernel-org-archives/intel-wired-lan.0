From: Simon Horman <horms@kernel.org>
Date: Wed, 20 Oct 2021 11:25:37 +0200
Subject: [Intel-wired-lan] [PATCH linux-next] e1000: Remove redundant
 statement
In-Reply-To: <20211018085305.853996-1-luo.penghao@zte.com.cn>
References: <20211018085305.853996-1-luo.penghao@zte.com.cn>
Message-ID: <20211020092537.GF3935@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 18, 2021 at 08:53:05AM +0000, luo penghao wrote:

nit: s/linux-next/net-next/ in subject

> This statement is redundant in the context, because there will be
> an identical statement next. otherwise, the variable initialization
> is actually unnecessary.
> 
> The clang_analyzer complains as follows:
> 
> drivers/net/ethernet/intel/e1000/e1000_ethtool.c:1218:2 warning:
> 
> Value stored to 'ctrl_reg' is never read.

I agree this does seem to be the case.

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index 0a57172..8951f2a 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -1215,8 +1215,6 @@ static int e1000_integrated_phy_loopback(struct e1000_adapter *adapter)
>  		e1000_write_phy_reg(hw, PHY_CTRL, 0x8140);
>  	}
>  
> -	ctrl_reg = er32(CTRL);
> -
>  	/* force 1000, set loopback */
>  	e1000_write_phy_reg(hw, PHY_CTRL, 0x4140);
>  
> -- 
> 2.15.2
> 
> 

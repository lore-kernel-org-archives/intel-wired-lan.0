From: jesse.brandeburg@intel.com <jesse.brandeburg@intel.com>
Date: Mon, 18 Oct 2021 09:10:57 -0700
Subject: [Intel-wired-lan] [PATCH linux-next] e1000: Remove redundant
 statement
In-Reply-To: <20211018085305.853996-1-luo.penghao@zte.com.cn>
References: <20211018085305.853996-1-luo.penghao@zte.com.cn>
Message-ID: <fdd05a99-7cae-c6c2-f44a-d48202fb0543@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/18/21 1:53 AM, luo penghao <cgel.zte@gmail.com> wrote:
> This statement is redundant in the context, because there will be
> an identical statement next. otherwise, the variable initialization
> is actually unnecessary.
> 
> The clang_analyzer complains as follows:
> 
> drivers/net/ethernet/intel/e1000/e1000_ethtool.c:1218:2 warning:
> 
> Value stored to 'ctrl_reg' is never read.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>   drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index 0a57172..8951f2a 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -1215,8 +1215,6 @@ static int e1000_integrated_phy_loopback(struct e1000_adapter *adapter)
>   		e1000_write_phy_reg(hw, PHY_CTRL, 0x8140);
>   	}
>   
> -	ctrl_reg = er32(CTRL);

Thanks for your patch, but this change is not safe. you're removing a read that could do two things. The first is that the read "flushes" the write just above to PCI (it's a PCI barrier), and the second is that the read can have some side effects.

If this change must be done, the code should be to remove the assignment to ctrl_reg, but leave the read, so the line would just look like:
        er32(CTRL);

This will get rid of the warning and not change the flow from the hardware perspective.

> -
>   	/* force 1000, set loopback */
>   	e1000_write_phy_reg(hw, PHY_CTRL, 0x4140);
>   
> 
> 


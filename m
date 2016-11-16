From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Date: Wed, 16 Nov 2016 15:05:44 +0100
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: write flush vfta registers
In-Reply-To: <1479300041-3436-1-git-send-email-zyjzyj2000@gmail.com>
References: <1479300041-3436-1-git-send-email-zyjzyj2000@gmail.com>
Message-ID: <trinity-ec3a2e6f-7310-41aa-8743-61bc62ccf663-1479305144399@3capp-gmx-bs59>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Hi,

> 
> Sometimes vfta registers can not be written successfully in dcb mode.
> This is very occassional. When the ixgbe nic runs for a very long time,
> sometimes this bug occurs. But after IXGBE_WRITE_FLUSH is executed,
> this bug never occurs.
> 
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index bd93d82..1221cfb 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -4138,8 +4138,10 @@ static void ixgbe_vlan_promisc_enable(struct ixgbe_adapter *adapter)
>  	}
>  
>  	/* Set all bits in the VLAN filter table array */
> -	for (i = hw->mac.vft_size; i--;)
> +	for (i = hw->mac.vft_size; i--;) {
>  		IXGBE_WRITE_REG(hw, IXGBE_VFTA(i), ~0U);
> +		IXGBE_WRITE_FLUSH(hw);
> +	}

Should it not be sufficient to do the flush only once, at the end of the function?

Regards,
Lino

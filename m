From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 14 Mar 2021 19:41:40 -0700
Subject: [Intel-wired-lan] [PATCH] net: ethernet: intel: igb: Typo fix
 in the file igb_main.c
In-Reply-To: <20210315014847.1021209-1-unixbhaskar@gmail.com>
References: <20210315014847.1021209-1-unixbhaskar@gmail.com>
Message-ID: <d397b00d-ec55-2216-3b69-776d664b4c3d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/14/21 6:48 PM, Bhaskar Chowdhury wrote:
> 
> s/structue/structure/
> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 03f78fdb0dcd..afc8ab9046a5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3115,7 +3115,7 @@ static s32 igb_init_i2c(struct igb_adapter *adapter)
>  		return 0;
> 
>  	/* Initialize the i2c bus which is controlled by the registers.
> -	 * This bus will use the i2c_algo_bit structue that implements
> +	 * This bus will use the i2c_algo_bit structure that implements
>  	 * the protocol through toggling of the 4 bits in the register.
>  	 */
>  	adapter->i2c_adap.owner = THIS_MODULE;
> --


-- 
~Randy


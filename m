From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sun, 3 Jan 2021 09:41:00 +0100
Subject: [Intel-wired-lan] [PATCH] net: ixgbe: Fix memleak in
 ixgbe_configure_clsu32
In-Reply-To: <20210103080843.25914-1-dinghao.liu@zju.edu.cn>
References: <20210103080843.25914-1-dinghao.liu@zju.edu.cn>
Message-ID: <aefe9de0-83b4-81b8-5d5b-674cb8ea97e8@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Dinghao,


Am 03.01.21 um 09:08 schrieb Dinghao Liu:
> When ixgbe_fdir_write_perfect_filter_82599() fails,
> input allocated by kzalloc() has not been freed,
> which leads to memleak.

Nice find. Thank you for your patches. Out of curiosity, do you use an 
analysis tool to find these issues?

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 393d1c2cd853..e9c2d28efc81 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9582,8 +9582,10 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
>   	ixgbe_atr_compute_perfect_hash_82599(&input->filter, mask);
>   	err = ixgbe_fdir_write_perfect_filter_82599(hw, &input->filter,
>   						    input->sw_idx, queue);
> -	if (!err)
> -		ixgbe_update_ethtool_fdir_entry(adapter, input, input->sw_idx);
> +	if (err)
> +		goto err_out_w_lock;
> +
> +	ixgbe_update_ethtool_fdir_entry(adapter, input, input->sw_idx);
>   	spin_unlock(&adapter->fdir_perfect_lock);
>   
>   	if ((uhtid != 0x800) && (adapter->jump_tables[uhtid]))

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

I wonder, in the non-error case, how `input` and `jump` are freed.

Old code:

>         if (!err)
>                 ixgbe_update_ethtool_fdir_entry(adapter, input, input->sw_idx);
>         spin_unlock(&adapter->fdir_perfect_lock);
> 
>         if ((uhtid != 0x800) && (adapter->jump_tables[uhtid]))
>                 set_bit(loc - 1, (adapter->jump_tables[uhtid])->child_loc_map);
> 
>         kfree(mask);
>         return err;

Should these two lines be replaced with `goto err_out`? (Though the name 
is confusing then, as it?s the non-error case.)

> err_out_w_lock:
>         spin_unlock(&adapter->fdir_perfect_lock);
> err_out:
>         kfree(mask);
> free_input:
>         kfree(input);
> free_jump:
>         kfree(jump);
>         return err;
> }

Kind regards,

Paul

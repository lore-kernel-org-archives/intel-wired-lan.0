From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Mon, 12 Oct 2020 15:49:48 +0200 (CEST)
Subject: [Intel-wired-lan] [linux-safety] [PATCH] e1000: drop unneeded
 assignment in e1000_set_itr()
In-Reply-To: <20201011212326.2758-1-sudipm.mukherjee@gmail.com>
References: <20201011212326.2758-1-sudipm.mukherjee@gmail.com>
Message-ID: <alpine.DEB.2.21.2010121546470.6487@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On Sun, 11 Oct 2020, Sudip Mukherjee wrote:

> The variable 'current_itr' is assigned to 0 before jumping to
> 'set_itr_now' but it has not been used after the jump. So, remove the
> unneeded assignement.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 5e28cf4fa2cd..042de276e632 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -2632,7 +2632,6 @@ static void e1000_set_itr(struct e1000_adapter *adapter)
>  
>  	/* for non-gigabit speeds, just fix the interrupt rate at 4000 */
>  	if (unlikely(adapter->link_speed != SPEED_1000)) {
> -		current_itr = 0;
>  		new_itr = 4000;
>  		goto set_itr_now;
>  	}

Alternatively, you could just inline the max(...) into the switch and 
completely drop the current_itr definition.

But your solution probably does the job: it is a "No functional change" 
commit.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


Lukas

> -- 
> 2.11.0
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#77): https://lists.elisa.tech/g/linux-safety/message/77
> Mute This Topic: https://lists.elisa.tech/mt/77448709/1714638
> Group Owner: linux-safety+owner at lists.elisa.tech
> Unsubscribe: https://lists.elisa.tech/g/linux-safety/unsub [lukas.bulwahn at gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
> 

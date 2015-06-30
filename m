From: Joe Perches <joe@perches.com>
Date: Mon, 29 Jun 2015 22:12:36 -0700
Subject: [Intel-wired-lan] [PATCH 1/1] igb: Use ARRAY_SIZE instead fo
 sizeof(a)/sizeof(a[0])
In-Reply-To: <1435640130-1466-1-git-send-email-maninder1.s@samsung.com>
References: <1435640130-1466-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <1435641156.6661.1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-06-30 at 10:25 +0530, Maninder Singh wrote:
> Use ARRAY_SIZE instead fo sizeof(a)/sizeof(a[0])

I think all of these #defines should be removed instead
as they are all used only once.

> diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
[]
> @@ -37,8 +37,7 @@ static s32  igb_set_master_slave_mode(struct e1000_hw *hw);
>  static const u16 e1000_m88_cable_length_table[] = {
>  	0, 50, 80, 110, 140, 140, E1000_CABLE_LENGTH_UNDEFINED };
>  #define M88E1000_CABLE_LENGTH_TABLE_SIZE \
> -	(sizeof(e1000_m88_cable_length_table) / \
> -	sizeof(e1000_m88_cable_length_table[0]))
> +	ARRAY_SIZE(e1000_m88_cable_length_table)
>  
>  static const u16 e1000_igp_2_cable_length_table[] = {
>  	0, 0, 0, 0, 0, 0, 0, 0, 3, 5, 8, 11, 13, 16, 18, 21,
> @@ -50,8 +49,7 @@ static const u16 e1000_igp_2_cable_length_table[] = {
>  	83, 89, 95, 100, 105, 109, 113, 116, 119, 122, 124,
>  	104, 109, 114, 118, 121, 124};
>  #define IGP02E1000_CABLE_LENGTH_TABLE_SIZE \
> -	(sizeof(e1000_igp_2_cable_length_table) / \
> -	 sizeof(e1000_igp_2_cable_length_table[0]))
> +	ARRAY_SIZE(e1000_igp_2_cable_length_table)
>  
>  /**
>   *  igb_check_reset_block - Check if PHY reset is blocked




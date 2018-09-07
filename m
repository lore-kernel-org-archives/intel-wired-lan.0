From: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>
Date: Fri, 7 Sep 2018 12:40:40 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/2] net: ethernet: i40e: fix build
 error
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-2-git-send-email-dongsheng.wang@hxt-semitech.com>
Message-ID: <f2b0bdfcb53c461191e71603257874ac@HXTBJIDCEMVIW02.hxtcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello all,

The i40e_ethtool_stats.h is just included by i40e/i40e_ethtool.c. So the
static doesn't make any affect. And Carolyn's team is working rebuild
i40e and i40evf.

Cheers,
Dongsheng

On 9/7/2018 7:19 PM, Wang, Dongsheng wrote:
> Remove "inline" from __i40e_add_stat_strings and move the function.
>
> In file included from
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:0:
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function
> __i40e_add_stat_string:
> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error:
> function __i40e_add_stat_strings can never be inlined because it uses
> variable argument lists
>  static inline void __i40e_add_stat_strings(u8 **p, const struct
> 					    i40e_stats stats[],
>
> Tested on: x86_64, make ARCH=i386
>
> Modules section .text:
> i40e: 00019380 <__i40e_add_stat_strings>:
> i40evf: 00006b00 <__i40e_add_stat_strings>:
>
> Buildin section .text:
> i40e: c351ca60 <__i40e_add_stat_strings>:
> i40evf: c354f2c0 <__i40e_add_stat_strings>:
>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> ---
> V3: add static 
> V2: Move function
> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 24 ++++++++++++++++++
>  .../ethernet/intel/i40e/i40e_ethtool_stats.h  | 25 ++-----------------
>  2 files changed, 26 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index d7d3974beca2..34121a72f2e7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -1821,6 +1821,30 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
>  		  "ethtool stats count mismatch!");
>  }
>  
> +/**
> + * __i40e_add_stat_strings - copy stat strings into ethtool buffer
> + * @p: ethtool supplied buffer
> + * @stats: stat definitions array
> + * @size: size of the stats array
> + *
> + * Format and copy the strings described by stats into the buffer pointed at
> + * by p.
> + **/
> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +				    const unsigned int size, ...)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < size; i++) {
> +		va_list args;
> +
> +		va_start(args, size);
> +		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
> +		*p += ETH_GSTRING_LEN;
> +		va_end(args);
> +	}
> +}
> +
>  /**
>   * i40e_get_stat_strings - copy stat strings into supplied buffer
>   * @netdev: the netdev to collect strings for
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> index bba1cb0b658f..553b0d720839 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> @@ -181,29 +181,8 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
>  	*data += size;
>  }
>  
> -/**
> - * __i40e_add_stat_strings - copy stat strings into ethtool buffer
> - * @p: ethtool supplied buffer
> - * @stats: stat definitions array
> - * @size: size of the stats array
> - *
> - * Format and copy the strings described by stats into the buffer pointed at
> - * by p.
> - **/
> -static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> -				    const unsigned int size, ...)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < size; i++) {
> -		va_list args;
> -
> -		va_start(args, size);
> -		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
> -		*p += ETH_GSTRING_LEN;
> -		va_end(args);
> -	}
> -}
> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +				    const unsigned int size, ...);
>  
>  /**
>   * 40e_add_stat_strings - copy stat strings into ethtool buffer



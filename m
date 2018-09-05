From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 5 Sep 2018 16:52:58 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] net: ethernet: i40evf: fix
 potential build error
In-Reply-To: <1536114430-21356-2-git-send-email-dongsheng.wang@hxt-semitech.com>
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536114430-21356-2-git-send-email-dongsheng.wang@hxt-semitech.com>
Message-ID: <02874ECE860811409154E81DA85FBB5884C78D96@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Wang Dongsheng [mailto:dongsheng.wang at hxt-semitech.com]
> Sent: Tuesday, September 04, 2018 7:27 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sergei.shtylyov at cogentembedded.com
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; davem at davemloft.net; intel-
> wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Wang Dongsheng <dongsheng.wang@hxt-
> semitech.com>
> Subject: [PATCH v2 2/2] net: ethernet: i40evf: fix potential build error
> 
> Can't have non-inline function in a header file.
> There is a risk of "Multiple definition" from cross-including.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  .../intel/i40evf/i40e_ethtool_stats.h         | 25 ++-----------------
>  .../ethernet/intel/i40evf/i40evf_ethtool.c    | 24 ++++++++++++++++++
>  2 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> index 60b595dd8c39..d70a071f065f 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> @@ -181,29 +181,8 @@ i40evf_add_queue_stats(u64 **data, struct i40e_ring
> *ring)
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
> -static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
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
> +void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +			     const unsigned int size, ...);
> 
>  /**
>   * 40e_add_stat_strings - copy stat strings into ethtool buffer
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> index 9319971c5c92..c9a54f6de61e 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> @@ -171,6 +171,30 @@ static void i40evf_get_priv_flag_strings(struct
> net_device *netdev, u8 *data)
>  	}
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
> +void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +			     const unsigned int size, ...)
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
>   * i40evf_get_stat_strings - Get stat strings
>   * @netdev: network interface device structure
> --
> 2.18.0


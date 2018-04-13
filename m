From: Steffen Klassert <steffen.klassert@secunet.com>
Date: Fri, 13 Apr 2018 13:09:26 +0200
Subject: [Intel-wired-lan] [net] xfrm: cover crypto status in xfrm_input
In-Reply-To: <20180412190315.3102-3-jacek.kalwas@intel.com>
References: <20180412190315.3102-1-jacek.kalwas@intel.com>
 <20180412190315.3102-3-jacek.kalwas@intel.com>
Message-ID: <20180413110926.utpc4aq5kt7ogmby@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 12, 2018 at 12:03:15PM -0700, Jacek Kalwas wrote:
> Status checking in xfrm_input doesn't cover CRYPTO_GENERIC_ERROR and
> CRYPTO_INVALID_PACKET_SYNTAX.
> 
> Given patch adds additional check for CRYPTO_INVALID_PACKET_SYNTAX and
> treats CRYPTO_GENERIC_ERROR as status matching LINUX_MIB_XFRMINERROR.
> 
> Signed-off-by: Jacek Kalwas <jacek.kalwas@intel.com>
> ---
>  net/xfrm/xfrm_input.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 352abca2605f..08d70ea774f9 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -285,7 +285,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  					goto drop;
>  				}
>  
> -				XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
> +				if (xo->status & CRYPTO_INVALID_PACKET_SYNTAX) {
> +					XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
> +					goto drop;
> +				}

Please consider adding separate statistic counters for offloading.
Reusing some other counter does not make it more usfull as it is now.
Some time ago, each statistic counter was bumped at a unique place,
so it was easy to identify where the packet was dropped. Unfortunately 
this changed over the years. This was one of the concerns the userspace
IPsec developers had during the IPsec workshop we held recently. So I
think it is better to add new counters insted of reusing old ones here.


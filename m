From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 22 Oct 2015 08:59:27 -0700
Subject: [Intel-wired-lan] [PATCH] e1000: free skb when returning on
 -ENOMEM error
In-Reply-To: <1445527642-15567-1-git-send-email-Jason@zx2c4.com>
References: <1445527642-15567-1-git-send-email-Jason@zx2c4.com>
Message-ID: <562907DF.3070404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/22/2015 08:27 AM, Jason A. Donenfeld wrote:
> eth_skb_pad returns 0 if it was successful, or -ENOMEM if it was not. In
> that case, this function exits early. Some early exits return with
> NETDEV_TX_BUSY, which queues the skb up to be tried again, and so the
> skb should not be freed. Other early exits return with NETDEV_TX_OK,
> like this one, in which case it's imperative that the skb is freed,
> since it is not queued back up. In this case, upon receiving -ENOMEM
> from eth_skb_pad, the function exits early with NETDEV_TX_OK, but
> forgets to free the skb. This patch fixes that.
>
> In a low memory situation, in which the GFP_ATOMIC allocation from
> eth_skb_pad fails, if a network device is transmitting repeatedly, this
> bug could lead to rapidly leaking memory that could only be recovered by
> a reboot or crash.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   drivers/net/ethernet/intel/e1000/e1000_main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 74dc150..0d6b4c8 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -3130,8 +3130,10 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
>   	 * packets may get corrupted during padding by HW.
>   	 * To WA this issue, pad all small packets manually.
>   	 */
> -	if (eth_skb_pad(skb))
> +	if (eth_skb_pad(skb)) {
> +		dev_kfree_skb_any(skb);
>   		return NETDEV_TX_OK;
> +	}
>
>   	mss = skb_shinfo(skb)->gso_size;
>   	/* The controller does a simple calculation to
>

This patch makes no sense.  The function eth_skb_pad will have freed the 
skb if it is returning an error value.  As such there is nothing to 
free.  The code was correct before.

- Alex

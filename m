From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 17 Jan 2018 16:28:14 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 02/10] net: ipv4: raw: Hook
 into time based transmission.
In-Reply-To: <20180117230621.26074-3-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-3-jesus.sanchez-palencia@intel.com>
Message-ID: <1516235294.3606.18.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-01-17 at 15:06 -0800, Jesus Sanchez-Palencia wrote:
> From: Richard Cochran <rcochran@linutronix.de>
> 
> For raw packets, copy the desired future transmit time from the CMSG
> cookie into the skb.
> 
> Signed-off-by: Richard Cochran <rcochran@linutronix.de>
> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
> ---
>  net/ipv4/raw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 136544b36a46..e37ea8ab6a78 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -381,6 +381,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>  
>  	skb->priority = sk->sk_priority;
>  	skb->mark = sk->sk_mark;
> +	skb->tstamp = sockc->transmit_time;
>  	skb_dst_set(skb, &rt->dst);
>  	*rtp = NULL;
>  
> @@ -562,6 +563,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	}
>  
>  	ipc.sockc.tsflags = sk->sk_tsflags;
> +	ipc.sockc.transmit_time = 0;
>  	ipc.addr = inet->inet_saddr;
>  	ipc.opt = NULL;
>  	ipc.tx_flags = 0;


It seems that skb_scrub_packet() will clear skb->tstamp, meaning  that
going through a tunnel will break your feature.

Maybe we need to remove skb->tstamp clear from skb_scrub_packet() and
do the cleaning only in forwarding path.



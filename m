From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Mar 2018 12:00:22 -0500
Subject: [Intel-wired-lan] [RFC v3 net-next 05/18] net: ipv4: raw: Hook
 into time based transmission.
In-Reply-To: <20180307011230.24001-6-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-6-jesus.sanchez-palencia@intel.com>
Message-ID: <CAF=yD-JSrTcSFJ18xA7sxNTt8U_CZuHuTahWLw_AgYCHteVD1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 6, 2018 at 8:12 PM, Jesus Sanchez-Palencia
<jesus.sanchez-palencia@intel.com> wrote:
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
> index 54648d20bf0f..8e05970ba7c4 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -381,6 +381,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>
>         skb->priority = sk->sk_priority;
>         skb->mark = sk->sk_mark;
> +       skb->tstamp = sockc->transmit_time;

This implements the feature only for the hdrincl case and silently
drops the txtime request on other raw sockets (incl. corked).

At the least, should probably fail if sockc.transmit_time is non-zero
and the hdrincl path is not taken. Or implement by passing through
inet_cork and set in __ip_make_skb. Then be careful to ignore the
field for other protocols, where it may be uninitialized.

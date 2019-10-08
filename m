From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 08 Oct 2019 08:58:16 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <875zkzn2pj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sridhar Samudrala <sridhar.samudrala@intel.com> writes:

>  int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
>  		    struct bpf_prog *xdp_prog)
>  {
>  	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
>  	struct bpf_map *map = READ_ONCE(ri->map);
> +	struct xdp_sock *xsk;
> +
> +	xsk = xdp_get_direct_xsk(ri);
> +	if (xsk)
> +		return xsk_rcv(xsk, xdp);

This is a new branch and a read barrier in the XDP_REDIRECT fast path.
What's the performance impact of that for non-XSK redirect?

-Toke


From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 8 Oct 2019 10:47:09 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <875zkzn2pj.fsf@toke.dk>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
 <875zkzn2pj.fsf@toke.dk>
Message-ID: <CAJ+HfNhcvRP34L3px6ipAsCiZdvLXG02brecwB=T-sXMaT5yRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 8 Oct 2019 at 08:59, Toke H?iland-J?rgensen <toke@redhat.com> wrote:
>
> Sridhar Samudrala <sridhar.samudrala@intel.com> writes:
>
> >  int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
> >                   struct bpf_prog *xdp_prog)
> >  {
> >       struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
> >       struct bpf_map *map = READ_ONCE(ri->map);
> > +     struct xdp_sock *xsk;
> > +
> > +     xsk = xdp_get_direct_xsk(ri);
> > +     if (xsk)
> > +             return xsk_rcv(xsk, xdp);
>
> This is a new branch and a read barrier in the XDP_REDIRECT fast path.
> What's the performance impact of that for non-XSK redirect?
>

The dependent-read-barrier in READ_ONCE? Another branch -- leave that
to the branch-predictor already! ;-) No, you're right, performance
impact here is interesting. I guess the same static_branch could be
used here as well...


> -Toke
>

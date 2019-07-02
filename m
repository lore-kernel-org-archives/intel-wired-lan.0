From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 2 Jul 2019 15:58:38 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v2 2/6] xsk: add support for
 need_wakeup flag in AF_XDP rings
In-Reply-To: <d4318783-18a4-d5c1-1044-691aaebb2b0a@mellanox.com>
References: <1562059288-26773-1-git-send-email-magnus.karlsson@intel.com>
 <1562059288-26773-3-git-send-email-magnus.karlsson@intel.com>
 <d4318783-18a4-d5c1-1044-691aaebb2b0a@mellanox.com>
Message-ID: <CAJ8uoz0jnR99iVCK+f3U5=Xo7JQ1SRM=Os7A0J9cTb_=8bL_Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jul 2, 2019 at 3:47 PM Maxim Mikityanskiy <maximmi@mellanox.com> wrote:
>
> On 2019-07-02 12:21, Magnus Karlsson wrote:
> >
> > +/* XDP_RING flags */
> > +#define XDP_RING_NEED_WAKEUP (1 << 0)
> > +
> >   struct xdp_ring_offset {
> >       __u64 producer;
> >       __u64 consumer;
> >       __u64 desc;
> > +     __u64 flags;
> >   };
> >
> >   struct xdp_mmap_offsets {
>
> <snip>
>
> > @@ -621,9 +692,12 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
> >       case XDP_MMAP_OFFSETS:
> >       {
> >               struct xdp_mmap_offsets off;
> > +             bool flags_supported = true;
> >
> > -             if (len < sizeof(off))
> > +             if (len < sizeof(off) - sizeof(off.rx.flags))
> >                       return -EINVAL;
> > +             else if (len < sizeof(off))
> > +                     flags_supported = false;
> >
> >               off.rx.producer = offsetof(struct xdp_rxtx_ring, ptrs.producer);
> >               off.rx.consumer = offsetof(struct xdp_rxtx_ring, ptrs.consumer);
> > @@ -638,6 +712,16 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
> >               off.cr.producer = offsetof(struct xdp_umem_ring, ptrs.producer);
> >               off.cr.consumer = offsetof(struct xdp_umem_ring, ptrs.consumer);
> >               off.cr.desc     = offsetof(struct xdp_umem_ring, desc);
> > +             if (flags_supported) {
> > +                     off.rx.flags = offsetof(struct xdp_rxtx_ring,
> > +                                             ptrs.flags);
> > +                     off.tx.flags = offsetof(struct xdp_rxtx_ring,
> > +                                             ptrs.flags);
> > +                     off.fr.flags = offsetof(struct xdp_umem_ring,
> > +                                             ptrs.flags);
> > +                     off.cr.flags = offsetof(struct xdp_umem_ring,
> > +                                             ptrs.flags);
> > +             }
>
> As far as I understood (correct me if I'm wrong), you are trying to
> preserve backward compatibility, so that if userspace doesn't support
> the flags field, you will determine that by looking at len and fall back
> to the old format.

That was the intention yes.

> However, two things are broken here:
>
> 1. The check `len < sizeof(off) - sizeof(off.rx.flags)` should be `len <
> sizeof(off) - 4 * sizeof(flags)`, because struct xdp_mmap_offsets
> consists of 4 structs xdp_ring_offset.
>
> 2. The old and new formats are not binary compatible, as flags are
> inserted in the middle of struct xdp_mmap_offsets.

You are correct. Since there are four copies of the xdp_ring_offset
this simple scheme will not work. I will instead create an internal
version 1 of the struct that I fill in and pass to user space if I
detect that user space is asking for the v1 size.

Thanks for catching Maxim. Keep'em coming.

/Magnus

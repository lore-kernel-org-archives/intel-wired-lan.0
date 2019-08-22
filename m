From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 22 Aug 2019 09:10:58 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix double clean of tx
 descriptors with xdp
In-Reply-To: <f7d0f7a5-e664-8b72-99c7-63275aff4c18@samsung.com>
References: <CGME20190820151644eucas1p179d6d1da42bb6be0aad8f58ac46624ce@eucas1p1.samsung.com>
 <20190820151611.10727-1-i.maximets@samsung.com>
 <CAKgT0Udn0D0_f=SOH2wpBRWV_u4rb1Qe2h7gguXnRNzJ_VkRzg@mail.gmail.com>
 <625791af-c656-1e42-b60e-b3a5cedcb4c4@samsung.com>
 <CAKgT0Uc27+ucd=a_sgTmv5g7_+ZTg1zK4isYJ0H7YWQj3d=Ejg@mail.gmail.com>
 <f7d0f7a5-e664-8b72-99c7-63275aff4c18@samsung.com>
Message-ID: <CAJ+HfNgUe3xGHeLsK0eKV76BOgeV-ZFcNwWKOvxbzcGRcg58dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 21 Aug 2019 at 18:22, Ilya Maximets <i.maximets@samsung.com> wrote:
>
> On 21.08.2019 4:17, Alexander Duyck wrote:
> > On Tue, Aug 20, 2019 at 8:58 AM Ilya Maximets <i.maximets@samsung.com> wrote:
> >>
> >> On 20.08.2019 18:35, Alexander Duyck wrote:
[...]
> >
> > So is it always in the same NAPI context?. I forgot, I was thinking
> > that somehow the socket could possibly make use of XDP for transmit.
>
> AF_XDP socket only triggers tx interrupt on ndo_xsk_async_xmit() which
> is used in zero-copy mode. Real xmit happens inside
> ixgbe_poll()
>  -> ixgbe_clean_xdp_tx_irq()
>     -> ixgbe_xmit_zc()
>
> This should be not possible to bound another XDP socket to the same netdev
> queue.
>
> It also possible to xmit frames in xdp_ring while performing XDP_TX/REDIRECT
> actions. REDIRECT could happen from different netdev with different NAPI
> context, but this operation is bound to specific CPU core and each core has
> its own xdp_ring.
>
> However, I'm not an expert here.
> Bj?rn, maybe you could comment on this?
>

Yes, you're correct Ilya.

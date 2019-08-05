From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 5 Aug 2019 15:02:33 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Use refcount_t for refcount
In-Reply-To: <CA+FuTScLs-qJApj5Yw9OOjVk4++HSjn__Vdy+xX2V1rpWU8uLg@mail.gmail.com>
References: <20190802105507.16650-1-hslester96@gmail.com>
 <CA+FuTScLs-qJApj5Yw9OOjVk4++HSjn__Vdy+xX2V1rpWU8uLg@mail.gmail.com>
Message-ID: <CAKgT0UdzUChE36pYEj4x72vjMkBhjqWd33_B75FhmaYePSgDUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Aug 2, 2019 at 6:47 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Fri, Aug 2, 2019 at 6:55 AM Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > refcount_t is better for reference counters since its
> > implementation can prevent overflows.
> > So convert atomic_t ref counters to refcount_t.
> >
> > Also convert refcount from 0-based to 1-based.
> >
> > This patch depends on PATCH 1/2.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 6 +++---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> > index 00710f43cfd2..d313d00065cd 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> > @@ -773,7 +773,7 @@ int ixgbe_setup_fcoe_ddp_resources(struct ixgbe_adapter *adapter)
> >
> >         fcoe->extra_ddp_buffer = buffer;
> >         fcoe->extra_ddp_buffer_dma = dma;
> > -       atomic_set(&fcoe->refcnt, 0);
> > +       refcount_set(&fcoe->refcnt, 1);
>
> Same point as in the cxgb4 driver patch: how can you just change the
> initial value without modifying the condition for release?
>
> This is not a suggestion to resubmit all these changes again with a
> change to the release condition.

So I am pretty sure this patch is badly broken. It doesn't make any
sense to be resetting with the refcnt in
ixgbe_setup_fcoe_ddp_resources. The value is initialized to zero when
the adapter structure was allocated.

Consider this a NAK from me.

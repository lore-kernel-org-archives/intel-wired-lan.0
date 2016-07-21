From: zhuyj <zyjzyj2000@gmail.com>
Date: Thu, 21 Jul 2016 17:53:06 +0800
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbevf: replace enum with MACROs
In-Reply-To: <CAKgT0UefaX0aqV+mC77zrpWZAQWBKygDCG0Bpq0x2sVyeMpyYw@mail.gmail.com>
References: <1469011313-30044-1-git-send-email-zyjzyj2000@gmail.com>
 <1469011313-30044-2-git-send-email-zyjzyj2000@gmail.com>
 <CAKgT0UefaX0aqV+mC77zrpWZAQWBKygDCG0Bpq0x2sVyeMpyYw@mail.gmail.com>
Message-ID: <CAD=hENf70skR=9a5JXbGtHJeg2MEv=DTgBgD_tbMEBz+hV7HPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Got it. Thanks a lot.

Zhu Yanjun

On Wed, Jul 20, 2016 at 10:29 PM, Alexander Duyck <alexander.duyck@gmail.com
> wrote:

> On Wed, Jul 20, 2016 at 3:41 AM,  <zyjzyj2000@gmail.com> wrote:
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> >
> > With the original enum, when a several bits state is set, it is
> > possible that the wrong test occurs.
> >
> > For example,
> >
> > a state is 0x3, its bits are 11. When testing a state 0x2 whose
> > bits are 10, it is difficult to confirm that state 0x2 is set or
> > not.
> >
> > As such, the MACROs are defined to avoid the above error.
> >
> > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> > index 60fc63b..d37b910 100644
> > --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> > +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> > @@ -436,18 +436,16 @@ struct ixgbevf_adapter {
> >         u8 rss_indir_tbl[IXGBEVF_X550_VFRETA_SIZE];
> >  };
> >
> > -enum ixbgevf_state_t {
> > -       __IXGBEVF_TESTING,
> > -       __IXGBEVF_RESETTING,
> > -       __IXGBEVF_DOWN,
> > -       __IXGBEVF_DISABLED,
> > -       __IXGBEVF_REMOVING,
> > -       __IXGBEVF_SERVICE_SCHED,
> > -       __IXGBEVF_SERVICE_INITED,
> > -       __IXGBEVF_RESET_REQUESTED,
> > -       __IXGBEVF_QUEUE_RESET_REQUESTED,
> > -       __IXGBEVF_HW_RESETTING,
> > -};
> > +#define        __IXGBEVF_TESTING               0x0001
> > +#define        __IXGBEVF_RESETTING             0x0002
> > +#define        __IXGBEVF_DOWN                  0x0004
> > +#define        __IXGBEVF_DISABLED              0x0008
> > +#define        __IXGBEVF_REMOVING              0x0010
> > +#define        __IXGBEVF_SERVICE_SCHED         0x0020
> > +#define        __IXGBEVF_SERVICE_INITED        0x0040
> > +#define        __IXGBEVF_RESET_REQUESTED       0x0080
> > +#define        __IXGBEVF_QUEUE_RESET_REQUESTED 0x0100
> > +#define        __IXGBEVF_HW_RESETTING          0x0200
> >
> >  enum ixgbevf_boards {
> >         board_82599_vf,
>
> You cannot replace a bit offset with a mask without also having to
> update all the spots where the bit offset is used.
>
> There isn't much point to replacing the enum with a macro anyway.
> Using multiple test_bit expressions should be valid for testing
> multiple bits.
>
> - Alex
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160721/d2d64899/attachment-0001.html>

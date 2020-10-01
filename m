From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Date: Thu, 1 Oct 2020 11:08:54 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1] e1000: remove unused and
 incorrect code
In-Reply-To: <c270e596-b5db-005b-fa18-cd374981429c@molgen.mpg.de>
References: <20200918184152.604967-1-jesse.brandeburg@intel.com>
 <c270e596-b5db-005b-fa18-cd374981429c@molgen.mpg.de>
Message-ID: <CAEuXFEwy5wbTwT+Xn_Ez-bPjmXpCrYaYf+x7ms=HWg5x_YztiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 1, 2020 at 12:22 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > Fix this warning by removing the offending code and simplifying
> > the routine to do exactly what it did before, no functional
> > change.
>
> It looks like this fixes commit 1532ecea (e1000: drop dead pcie code
> from e1000) removing support for e1000_82573?

It may, but that commit is from 2009, and since this code change
actually doesn't fix any bug I didn't think it was a) worth davem
targeting to net, b) worth the bots picking up for backporting to
stable, as it is just waste of time, and maybe wouldn't be considered
as important enough for stable.

> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > ---
> >
> > NOTE: I don't recommend this go to stable as there is no functional
> > change.

You'll note I attempted to address your comment with the above line
even before you made it.

> > ---
> >   drivers/net/ethernet/intel/e1000/e1000_hw.c | 10 +---------
> >   1 file changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> > index 2120dacfd55c..c5d702543daa 100644
> > --- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
> > +++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> > @@ -4403,17 +4403,9 @@ void e1000_write_vfta(struct e1000_hw *hw, u32 offset, u32 value)
> >   static void e1000_clear_vfta(struct e1000_hw *hw)
>
> (Why is the diff also mentioning the function before `void
> e1000_write_vfta()`?)

This is an artifact of how diff works, since the e1000_clear_vfta
function was part of the diff context, the "previous function search"
that diff does found write_vfta. There is no issue here, everything is
working as it should.

>
> >   {
> >       u32 offset;
> > -     u32 vfta_value = 0;
> > -     u32 vfta_offset = 0;
> > -     u32 vfta_bit_in_reg = 0;
> >
> >       for (offset = 0; offset < E1000_VLAN_FILTER_TBL_SIZE; offset++) {
> > -             /* If the offset we want to clear is the same offset of the
> > -              * manageability VLAN ID, then clear all bits except that of the
> > -              * manageability unit
> > -              */
> > -             vfta_value = (offset == vfta_offset) ? vfta_bit_in_reg : 0;
> > -             E1000_WRITE_REG_ARRAY(hw, VFTA, offset, vfta_value);
> > +             E1000_WRITE_REG_ARRAY(hw, VFTA, offset, 0);
> >               E1000_WRITE_FLUSH();
> >       }
> >   }
>
> It?d be great if you updated the commit description.

Thanks for your feedback, but in this case I don't think there is
anything to change, I recommend we send the patch as-is. I appreciate
your time spent reviewing!

Jesse

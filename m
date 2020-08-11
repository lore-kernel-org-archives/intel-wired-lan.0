From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 11 Aug 2020 11:04:52 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] igc: Fix SRRCTL register setup
In-Reply-To: <159716520324.40621.12578308745578598418@awandler-mobl.amr.corp.intel.com>
References: <20200810210832.34699-1-andre.guedes@intel.com>
 <20200810210832.34699-3-andre.guedes@intel.com>
 <CAKgT0UdvyU+xkESA5HaqS2acbXQMJDUGdchRM2J6QExEcjiSkQ@mail.gmail.com>
 <159710652891.38166.5470520112400402456@gwclark-mobl2.amr.corp.intel.com>
 <CAKgT0UfujXBhZX8WeM_YrtZyCxZpP10zfARH6x4HdmjLbaFJvw@mail.gmail.com>
 <159716520324.40621.12578308745578598418@awandler-mobl.amr.corp.intel.com>
Message-ID: <CAKgT0UfDs1VUo3zkgC_5m=ZTD_gTWaVEm5GuCqjxhw99agjjkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 11, 2020 at 10:00 AM Andre Guedes <andre.guedes@intel.com> wrote:
>
> Quoting Alexander Duyck (2020-08-10 18:41:41)
> > On Mon, Aug 10, 2020 at 5:42 PM Andre Guedes <andre.guedes@intel.com> wrote:
> > >
> > > Quoting Alexander Duyck (2020-08-10 15:56:31)
> > > > > @@ -1869,6 +1866,7 @@ static void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
> > > > >                  * because each write-back erases this info.
> > > > >                  */
> > > > >                 rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
> > > > > +               rx_desc->read.hdr_addr = 0;
> > > > >
> > > > >                 rx_desc++;
> > > > >                 bi++;
> > > >
> > > > If you are going to do this it would be better to replace the line
> > > > that is setting the length to zero instead of just adding this line.
> > > > That way you can avoid having to rewrite it. I only had bothered with
> > > > clearing the length field as it was a 32b field, however if you are
> > > > wanting to flush the full 64b then I would recommend doing it there
> > > > rather than here.
> > >
> > > Just to make sure I'm on the same page, do you mean to move this line to
> > > patch 2/3, right?
> >
> > No, I hadn't had a chance to take a look at patch 2 yet. I think patch
> > 2 is ill advised as the patch is currently broken, and even if done
> > correctly you don't get any benefit out of it that I can see. From
> > what I can tell this patch was likely covering up some of the errors
> > introduced in patch 2. Now that I see this in conjunction with patch 2
> > I would say you should probably just drop patch 2 and this one as well
> > since they aren't adding any real value other than removing a
> > redundant write which was just there to keep this mostly in sync with
> > how we did it for ixgbe.
>
> What about not setting BSIZEHEADER bits since 'one buffer descriptor' option
> is used in SRRCTL?

Does it cause some sort of problem to be populating it? If not I would
say leave it. It isn't too different from just populating the field
with 0 and should have no effect since the field is unused when in one
buffer mode.

> > The reason the driver path was coded the way it is in order to get
> > away from having to clear the entire descriptor after processing it
> > and to avoid having to explicitly track next_to_use and next_to_clean.
> > Instead we leave the descriptor as mostly read-only until we
> > reallocate the buffer and give it back to the device. All we have to
> > do is clear the length field of the next_to_use descriptor when we are
> > done allocating so that we do not overrun the descriptors when
> > cleaning. It makes it much easier to debug when the descriptors are
> > left in place as long as possible since we can then come back and look
> > at the memory and generally I have found performance is improved as we
> > are not having to dirty cachelines prematurely.
>
> Thanks for the context.
>
> - Andre

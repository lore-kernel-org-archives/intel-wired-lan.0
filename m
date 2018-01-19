From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Sat, 20 Jan 2018 07:45:17 +0900
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <CAKgT0Ue6HRZYq+jkmZjGgvZZD4-C1yb_y+xDhcxbYVBANDjMBg@mail.gmail.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <CAKgT0UemPMN-30ubbKDR8za4w6f6T2R4GZt5atFzOkCpoSFhsA@mail.gmail.com>
 <20180119085952.u63kius4ud34lleq@f1.synalogic.ca>
 <20180119133648.s5nbm4gvby6c33av@f1.synalogic.ca>
 <CAKgT0Ue6HRZYq+jkmZjGgvZZD4-C1yb_y+xDhcxbYVBANDjMBg@mail.gmail.com>
Message-ID: <20180119224517.klugizz5n5zznryx@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/01/19 08:22, Alexander Duyck wrote:
> On Fri, Jan 19, 2018 at 5:36 AM, Benjamin Poirier
> <benjamin.poirier@gmail.com> wrote:
> > On 2018/01/19 17:59, Benjamin Poirier wrote:
> >> On 2018/01/18 07:51, Alexander Duyck wrote:
> >> > On Wed, Jan 17, 2018 at 10:50 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> >> > > It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> >> > > 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> >> > > overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> >> > > e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> >> > > on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> >> > > icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.
> >> >
> >> > Isn't 0x80000004 (_INT_ASSERTED | _LSC)? The assumption I based my
> >>
> >> Yes. The numeric value is correct. I made a mistake when writing down
> >> the flag names.
> >>
> >> > patch on was that the VMware code was sending _OTHER instead of _LSC
> >> > to trigger LSC events. As such in my version of the workaround I just
> >>
> >> It's not so deterministic, sadly. In my tests, upon entry into
> >> e1000_msix_other() after e1000e_trigger_lsc(), with no workaround patch
> >> I've seen:
> >> icr=0x0
> >> icr=0x3d
> >>       Reserved RXDMT0 Reserved LSC TXDW
> >> icr=0x46
> >>       RXO LSC TXQE
> >> and someone else reported:
> >> icr=0x3c
> >>       Reserved RXDMT0 Reserved LSC
> >>
> >> > went through and did the testing if the _RXO bit was set, otherwise I
> >> > assumed that whatever event was received must have been meant to
> >> > trigger an _LSC type event since that worked in the past.
> >                                ^...
> >
> > Re-reading that part, my thoughts are that it worked in the past, before
> > 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1),
> > because (presumably) Other was not set in EIAC. It worked after
> > 16ecba59bc33 but before 4aea7a5c5e94 ("e1000e: Avoid receiver overrun
> > interrupt bursts", v4.15-rc1) because e1000_msix_other() didn't read the
> > value of icr. If it had, it would've found a bogus value, which is
> > what's happening after 4aea7a5c5e94. I wonder if we're not just getting
> > some uninitialized value from the emulation code... which makes me kind
> > of uneasy about your approach of trying to make sense of the value.
> > Maybe Shrikrishna can clarify where the icr value is coming from when
> > Other is set in EIAC.
> 
> For now I still say we let my current patch go as-is in order to
> address the immediate issue. We can follow-up and do a more refined
> version of things once we get the final word from VMware on how this
> actually works. If nothing else the current patch appears to resolve
> the currently reported issue and is already submitted.
> 
> I'm of the mind that we need to cut down on the code thrash.  This
> driver is supposed to have been in a "maintenance" mode for the last
> year or so as there aren't being any new parts added is my
> understanding. As-is I don't see any reason why 16ecba59bc33 ("e1000e:
> Do not read ICR in Other interrupt", v4.5-rc1) was submitted or
> accepted in the first place. I don't see any notes about it fixing any
> bug or addressing any issue and it seems like that is the start of all
> the issues we have been having recently with RXO triggering more
> interrupts, various link issues, and this most recent VMware issue.

I'm sorry to say but you're the one who suggested that change:

http://lkml.iu.edu/hypermail/linux/kernel/1510.3/03528.html

On 2015/10/28 23:08, Alexander Duyck wrote:
> On 10/22/2015 05:32 PM, Benjamin Poirier wrote:
[...]
> 
> I would argue your first patch probably didn't go far enough to remove dead
> code.  Specifically you should only ever get into this function if LSC is
> set.  There are no other causes that should trigger this.  As such you could
> probably remove the ICR read, and instead replace it with an ICR write of
> the LSC bit since OTHER is already cleared via EIAC.
> 

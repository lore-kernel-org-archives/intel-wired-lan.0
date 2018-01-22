From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Mon, 22 Jan 2018 16:12:14 +0900
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <CAKgT0Ueu1T6UKf-yi13RN9+9=V5PPsFzhYrMSz+3sneXyxV9Lw@mail.gmail.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <CAKgT0UemPMN-30ubbKDR8za4w6f6T2R4GZt5atFzOkCpoSFhsA@mail.gmail.com>
 <20180119085952.u63kius4ud34lleq@f1.synalogic.ca>
 <20180119133648.s5nbm4gvby6c33av@f1.synalogic.ca>
 <CAKgT0Ue6HRZYq+jkmZjGgvZZD4-C1yb_y+xDhcxbYVBANDjMBg@mail.gmail.com>
 <20180119224517.klugizz5n5zznryx@f1.synalogic.ca>
 <20180119225500.lq2vpnjh5isxiovf@f1.synalogic.ca>
 <CAKgT0Ueu1T6UKf-yi13RN9+9=V5PPsFzhYrMSz+3sneXyxV9Lw@mail.gmail.com>
Message-ID: <20180122071214.cv773dufu6n4lvnw@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/01/20 09:21, Alexander Duyck wrote:
> On Fri, Jan 19, 2018 at 2:55 PM, Benjamin Poirier
> <benjamin.poirier@gmail.com> wrote:
> > On 2018/01/20 07:45, Benjamin Poirier wrote:
> > [...]
> >> >
> >> > I'm of the mind that we need to cut down on the code thrash.  This
> >> > driver is supposed to have been in a "maintenance" mode for the last
> >> > year or so as there aren't being any new parts added is my
> >> > understanding. As-is I don't see any reason why 16ecba59bc33 ("e1000e:
> >> > Do not read ICR in Other interrupt", v4.5-rc1) was submitted or
> >> > accepted in the first place. I don't see any notes about it fixing any
> >> > bug or addressing any issue and it seems like that is the start of all
> >> > the issues we have been having recently with RXO triggering more
> >> > interrupts, various link issues, and this most recent VMware issue.
> >>
> >> I'm sorry to say but you're the one who suggested that change:
> >>
> >> http://lkml.iu.edu/hypermail/linux/kernel/1510.3/03528.html
> >>
> >> On 2015/10/28 23:08, Alexander Duyck wrote:
> >> > On 10/22/2015 05:32 PM, Benjamin Poirier wrote:
> >> [...]
> >> >
> >> > I would argue your first patch probably didn't go far enough to remove dead
> >> > code.  Specifically you should only ever get into this function if LSC is
> >> > set.  There are no other causes that should trigger this.  As such you could
> >> > probably remove the ICR read, and instead replace it with an ICR write of
> >> > the LSC bit since OTHER is already cleared via EIAC.
> >> >
> >
> > ... The assumption that "There are no other causes that should trigger
> > this." turned out to be wrong and that caused the RXO problems. Clearing
> > OTHER via EIAC is causing the problems with vmware now. I don't think
> > you foresaw those problems back in 2015 and neither did I.
> 
> Well that explains why I felt like I was explaining things to a
> younger version of myself. I was a bit more relaxed in terms of being
> willing to make arbitrary changes a few years ago. I tend to be a bit
> more conservative now, at least as far as having justifications as to
> why I want to do things. With any change you end up taking on risk,
> and so usually a patch has a justification as to why you are making
> the change.
> 
> Unfortunately at the time I didn't have all the information and based
> my suggestion on a bad assumption. I would guess at the time I was
> thinking of doing general code cleanup. Other drivers such as igb work
> this way, but it led us down the path we are on now where we are
> having to make one fix after another. It is leading in the opposite
> direction of maintainability as this is all becoming more complex.
> Suggesting this was a bad decision on my part at the time. I'm only
> human, I make mistakes.. :-)

Thanks for the introspection.

> 
> With further review of the code I am seeing various other issues that
> could still pop up as I am not certain we should even have the "other"
> interrupt messing with the NAPI polling or packet accounting logic at
> all. The question I would have at this point is if we revert
> 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1)
> and all the related fixes for it, what do we end up with?

The patch I submitted for the current vmware issue actually finishes
reverting commit 16ecba59bc33.

I believe the relevant commits to consider are:

16ecba59bc33 e1000e: Do not read ICR in Other interrupt (v4.5-rc1)
a61cfe4ffad7 e1000e: Do not write lsc to ics in msi-x mode (v4.5-rc1)
0a8047ac68e5 e1000e: Fix msi-x interrupt automask (v4.5-rc1)

19110cfbb34d e1000e: Separate signaling for link check/link up
             (v4.15-rc1)
4aea7a5c5e94 e1000e: Avoid receiver overrun interrupt bursts (v4.15-rc1)

4110e02eb45e e1000e: Fix e1000_check_for_copper_link_ich8lan return
	     value. (v4.15-rc8)

(submitted)  e1000e: Remove Other from EIAC.

commit 4aea7a5c5e94 essentially reverts a61cfe4ffad7 and part of
16ecba59bc33 (ICR read). The submitted patch reverts the rest of
16ecba59bc33 (EIAC clearing of Other).

> It seems
> like the code is slowly heading back in the direction of where it was
> originally anyway since there have been a number of partial reverts.
> I'm wondering what would happen if we were to just short-cut that and
> audit the patches involved to see what we really need and don't.
> 
> Your patch as proposed is essentially another step in that direction.
> I'm thinking we may want to drop my currently proposed fix for now and
> instead look at going through and figure out what changes after that
> first one are still really needed.

If the patch that I submitted for the current vmware issue is merged,
the significant commits that are left are:

0a8047ac68e5 e1000e: Fix msi-x interrupt automask (v4.5-rc1)
	Fixes a problem in the irq disabling of the napi implementation.

19110cfbb34d e1000e: Separate signaling for link check/link up
             (v4.15-rc1)
	Fixes link flapping caused by a race condition in link
	detection. It was found because the Other interrupt was being
	triggered sort of spuriously by rxo.

4aea7a5c5e94 e1000e: Avoid receiver overrun interrupt bursts (v4.15-rc1)
	Fixes Other interrupt bursts during sustained rxo conditions.

I think all of those are still needed, or if they're removed, they need
to be reimplemented differently.

> It doesn't look like my fix will
> make it for 4.15 anyway so we might as well focus on making certain to
> have things as solid as possible by the time 4.16-rc1 rolls around.
> 
> Thanks.
> 
> - Alex

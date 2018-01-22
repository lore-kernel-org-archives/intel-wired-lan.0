From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Jan 2018 10:01:27 -0800
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <20180122071214.cv773dufu6n4lvnw@f1.synalogic.ca>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <CAKgT0UemPMN-30ubbKDR8za4w6f6T2R4GZt5atFzOkCpoSFhsA@mail.gmail.com>
 <20180119085952.u63kius4ud34lleq@f1.synalogic.ca>
 <20180119133648.s5nbm4gvby6c33av@f1.synalogic.ca>
 <CAKgT0Ue6HRZYq+jkmZjGgvZZD4-C1yb_y+xDhcxbYVBANDjMBg@mail.gmail.com>
 <20180119224517.klugizz5n5zznryx@f1.synalogic.ca>
 <20180119225500.lq2vpnjh5isxiovf@f1.synalogic.ca>
 <CAKgT0Ueu1T6UKf-yi13RN9+9=V5PPsFzhYrMSz+3sneXyxV9Lw@mail.gmail.com>
 <20180122071214.cv773dufu6n4lvnw@f1.synalogic.ca>
Message-ID: <CAKgT0UdTU-vSCGrjpMN+rQoPZXihyTqPOa79pHGdbVN6W7zxOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Jan 21, 2018 at 11:12 PM, Benjamin Poirier
<benjamin.poirier@gmail.com> wrote:
> On 2018/01/20 09:21, Alexander Duyck wrote:
>> On Fri, Jan 19, 2018 at 2:55 PM, Benjamin Poirier
>> <benjamin.poirier@gmail.com> wrote:
>> > On 2018/01/20 07:45, Benjamin Poirier wrote:
>> > [...]
>> >> >
>> >> > I'm of the mind that we need to cut down on the code thrash.  This
>> >> > driver is supposed to have been in a "maintenance" mode for the last
>> >> > year or so as there aren't being any new parts added is my
>> >> > understanding. As-is I don't see any reason why 16ecba59bc33 ("e1000e:
>> >> > Do not read ICR in Other interrupt", v4.5-rc1) was submitted or
>> >> > accepted in the first place. I don't see any notes about it fixing any
>> >> > bug or addressing any issue and it seems like that is the start of all
>> >> > the issues we have been having recently with RXO triggering more
>> >> > interrupts, various link issues, and this most recent VMware issue.
>> >>
>> >> I'm sorry to say but you're the one who suggested that change:
>> >>
>> >> http://lkml.iu.edu/hypermail/linux/kernel/1510.3/03528.html
>> >>
>> >> On 2015/10/28 23:08, Alexander Duyck wrote:
>> >> > On 10/22/2015 05:32 PM, Benjamin Poirier wrote:
>> >> [...]
>> >> >
>> >> > I would argue your first patch probably didn't go far enough to remove dead
>> >> > code.  Specifically you should only ever get into this function if LSC is
>> >> > set.  There are no other causes that should trigger this.  As such you could
>> >> > probably remove the ICR read, and instead replace it with an ICR write of
>> >> > the LSC bit since OTHER is already cleared via EIAC.
>> >> >
>> >
>> > ... The assumption that "There are no other causes that should trigger
>> > this." turned out to be wrong and that caused the RXO problems. Clearing
>> > OTHER via EIAC is causing the problems with vmware now. I don't think
>> > you foresaw those problems back in 2015 and neither did I.
>>
>> Well that explains why I felt like I was explaining things to a
>> younger version of myself. I was a bit more relaxed in terms of being
>> willing to make arbitrary changes a few years ago. I tend to be a bit
>> more conservative now, at least as far as having justifications as to
>> why I want to do things. With any change you end up taking on risk,
>> and so usually a patch has a justification as to why you are making
>> the change.
>>
>> Unfortunately at the time I didn't have all the information and based
>> my suggestion on a bad assumption. I would guess at the time I was
>> thinking of doing general code cleanup. Other drivers such as igb work
>> this way, but it led us down the path we are on now where we are
>> having to make one fix after another. It is leading in the opposite
>> direction of maintainability as this is all becoming more complex.
>> Suggesting this was a bad decision on my part at the time. I'm only
>> human, I make mistakes.. :-)
>
> Thanks for the introspection.
>
>>
>> With further review of the code I am seeing various other issues that
>> could still pop up as I am not certain we should even have the "other"
>> interrupt messing with the NAPI polling or packet accounting logic at
>> all. The question I would have at this point is if we revert
>> 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1)
>> and all the related fixes for it, what do we end up with?
>
> The patch I submitted for the current vmware issue actually finishes
> reverting commit 16ecba59bc33.
>
> I believe the relevant commits to consider are:
>
> 16ecba59bc33 e1000e: Do not read ICR in Other interrupt (v4.5-rc1)
> a61cfe4ffad7 e1000e: Do not write lsc to ics in msi-x mode (v4.5-rc1)
> 0a8047ac68e5 e1000e: Fix msi-x interrupt automask (v4.5-rc1)
>
> 19110cfbb34d e1000e: Separate signaling for link check/link up
>              (v4.15-rc1)
> 4aea7a5c5e94 e1000e: Avoid receiver overrun interrupt bursts (v4.15-rc1)
>
> 4110e02eb45e e1000e: Fix e1000_check_for_copper_link_ich8lan return
>              value. (v4.15-rc8)
>
> (submitted)  e1000e: Remove Other from EIAC.
>
> commit 4aea7a5c5e94 essentially reverts a61cfe4ffad7 and part of
> 16ecba59bc33 (ICR read). The submitted patch reverts the rest of
> 16ecba59bc33 (EIAC clearing of Other).
>
>> It seems
>> like the code is slowly heading back in the direction of where it was
>> originally anyway since there have been a number of partial reverts.
>> I'm wondering what would happen if we were to just short-cut that and
>> audit the patches involved to see what we really need and don't.
>>
>> Your patch as proposed is essentially another step in that direction.
>> I'm thinking we may want to drop my currently proposed fix for now and
>> instead look at going through and figure out what changes after that
>> first one are still really needed.
>
> If the patch that I submitted for the current vmware issue is merged,
> the significant commits that are left are:
>
> 0a8047ac68e5 e1000e: Fix msi-x interrupt automask (v4.5-rc1)
>         Fixes a problem in the irq disabling of the napi implementation.

This one I fully agree is still needed.

> 19110cfbb34d e1000e: Separate signaling for link check/link up
>              (v4.15-rc1)
>         Fixes link flapping caused by a race condition in link
>         detection. It was found because the Other interrupt was being
>         triggered sort of spuriously by rxo.

This one is somewhat iffy. I am not sure if the patch description
really matches what it is doing. It doesn't appear to do what it says
it is trying to do since clearing get_link_status will still trigger a
link up, it just takes an extra 2 seconds. I think there may be issues
if you aren't using autoneg, as I don't see how you are getting the
link to report up other than the fact that mac->get_link_status has
been cleared but we are reporting a pseduo-error. In addition it is
only really needed after the RXO problem was introduced which really
didn't exist until after we stopped checking for LSC. One interesting
test we may want to look at is to see if there is an additional delay
in a link coming up for a non-autoneg setup. If we find an additional
2 second delay then I would be even more confident that this patch has
a bug.

> 4aea7a5c5e94 e1000e: Avoid receiver overrun interrupt bursts (v4.15-rc1)
>         Fixes Other interrupt bursts during sustained rxo conditions.

So the RXO problem probably didn't exist until we stopped checking for
the OTHER and LSC bits in the "other" interrupt handler. Yes there
would be more "other" cause interrupts, but they shouldn't have been
causing much in the way of issues since the get_link_status value
never changed. Personally I would lean more toward the option of
reverting this patch and instead just focus on testing OTHER and LSC
as we originally were so that we don't risk messing up NAPI by messing
with ring state from a non-ring interrupt.

I will try to get to these later this week if you would like.
Unfortunately I don't have any of these devices in any of my
development systems so I have to go chase one down. Otherwise you are
free to take these on and tell me if I have made another flawed
assumption somewhere, but I am thinking the RXO issue goes away if we
get the original "other" interrupt routine back to where it was.

So the last bit in all this ends up being that because of 0a8047ac68e5
e1000e: Fix msi-x interrupt automask (v4.5-rc1) we don't seem to
auto-clear interrupt causes anymore on ICR read. I am not certain what
the impact of this is. I would be interested in finding out if a cause
left set will trigger an interrupt storm or if it just goes quiet when
we just leave the value high. If it goes quiet then that in itself
might solve the RXO interrupt burst problem if we don't clear it.
Otherwise we need to make certain to clear all of the causes that can
trigger the "other" interrupt to fire regardless of if we service the
events or not.

Thanks.

- Alex

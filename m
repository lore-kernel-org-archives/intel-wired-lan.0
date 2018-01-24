From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Wed, 24 Jan 2018 17:35:39 +0900
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <CAKgT0UdTU-vSCGrjpMN+rQoPZXihyTqPOa79pHGdbVN6W7zxOw@mail.gmail.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <CAKgT0UemPMN-30ubbKDR8za4w6f6T2R4GZt5atFzOkCpoSFhsA@mail.gmail.com>
 <20180119085952.u63kius4ud34lleq@f1.synalogic.ca>
 <20180119133648.s5nbm4gvby6c33av@f1.synalogic.ca>
 <CAKgT0Ue6HRZYq+jkmZjGgvZZD4-C1yb_y+xDhcxbYVBANDjMBg@mail.gmail.com>
 <20180119224517.klugizz5n5zznryx@f1.synalogic.ca>
 <20180119225500.lq2vpnjh5isxiovf@f1.synalogic.ca>
 <CAKgT0Ueu1T6UKf-yi13RN9+9=V5PPsFzhYrMSz+3sneXyxV9Lw@mail.gmail.com>
 <20180122071214.cv773dufu6n4lvnw@f1.synalogic.ca>
 <CAKgT0UdTU-vSCGrjpMN+rQoPZXihyTqPOa79pHGdbVN6W7zxOw@mail.gmail.com>
Message-ID: <20180124083539.nwwmmt7g2pxrcsej@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/01/22 10:01, Alexander Duyck wrote:
[...]
> >
> > If the patch that I submitted for the current vmware issue is merged,
> > the significant commits that are left are:
> >
> > 0a8047ac68e5 e1000e: Fix msi-x interrupt automask (v4.5-rc1)
> >         Fixes a problem in the irq disabling of the napi implementation.
> 
> This one I fully agree is still needed.
> 
> > 19110cfbb34d e1000e: Separate signaling for link check/link up
> >              (v4.15-rc1)
> >         Fixes link flapping caused by a race condition in link
> >         detection. It was found because the Other interrupt was being
> >         triggered sort of spuriously by rxo.
> 
> This one is somewhat iffy. I am not sure if the patch description
> really matches what it is doing. It doesn't appear to do what it says
> it is trying to do since clearing get_link_status will still trigger a
> link up, it just takes an extra 2 seconds. I think there may be issues
> if you aren't using autoneg, as I don't see how you are getting the
> link to report up other than the fact that mac->get_link_status has
> been cleared but we are reporting a pseduo-error. In addition it is
> only really needed after the RXO problem was introduced which really
> didn't exist until after we stopped checking for LSC. One interesting
> test we may want to look at is to see if there is an additional delay
> in a link coming up for a non-autoneg setup. If we find an additional
> 2 second delay then I would be even more confident that this patch has
> a bug.

It seems like you're right but I didn't look into this part of the problem in
detail yet. I'll get back to it.

> 
> > 4aea7a5c5e94 e1000e: Avoid receiver overrun interrupt bursts (v4.15-rc1)
> >         Fixes Other interrupt bursts during sustained rxo conditions.
> 
> So the RXO problem probably didn't exist until we stopped checking for
> the OTHER and LSC bits in the "other" interrupt handler. Yes there
> would be more "other" cause interrupts, but they shouldn't have been
> causing much in the way of issues since the get_link_status value
> never changed. Personally I would lean more toward the option of

I agree. I tested rxo behavior on commit 4d432f67ff00 ("e1000e: Remove
unreachable code", v4.5-rc1) which is before any significant change in that
area. (I force rxo by adding mdelay(10) to e1000_clean_rx_irq and sending a
netperf UDP_STREAM from another host). In case of sustained rxo condition, we
get repeated Other interrupts. Handling these irqs is useless work that could
be avoided when the system is already overloaded but it doesn't lead to
misbehavior like the race condition described in the log of commit
19110cfbb34d ("e1000e: Separate signaling for link check/link up", v4.15-rc1).

However, I noticed something unexpected. It seems like reading ICR doesn't
clear every bit that's set in IAM, most notably not rxo. In a different test,
I was doing a single write of RXO | OTHER to ICS, then two subsequent reads of
icr gave 0x01000041. OTOH, writing a bit to ICS reliably clears it. So if you
want to remove RXO interrupt mitigation, you should at least add a write of
RXO to ICR, to clear it. On my system it reduced Other interrupts from
~17000/s to ~1700/s when using the mdelay testing approach.

> reverting this patch and instead just focus on testing OTHER and LSC
> as we originally were so that we don't risk messing up NAPI by messing
> with ring state from a non-ring interrupt.
> 
> I will try to get to these later this week if you would like.
> Unfortunately I don't have any of these devices in any of my
> development systems so I have to go chase one down. Otherwise you are
> free to take these on and tell me if I have made another flawed
> assumption somewhere, but I am thinking the RXO issue goes away if we
> get the original "other" interrupt routine back to where it was.
> 
> So the last bit in all this ends up being that because of 0a8047ac68e5
> e1000e: Fix msi-x interrupt automask (v4.5-rc1) we don't seem to
> auto-clear interrupt causes anymore on ICR read. I am not certain what
> the impact of this is. I would be interested in finding out if a cause
> left set will trigger an interrupt storm or if it just goes quiet when
> we just leave the value high. If it goes quiet then that in itself
> might solve the RXO interrupt burst problem if we don't clear it.
> Otherwise we need to make certain to clear all of the causes that can
> trigger the "other" interrupt to fire regardless of if we service the
> events or not.

In MSI-X mode, as long as Other is not set in ICR, nothing will happen even if
the bits related to Other (LSC, RXO, MDAC, SRPD, ACK, MNG) are set. However,
that doesn't solve the rxo interrupt burst because an rxo condition in
hardware sets both RXO and Other, so it triggers an interrupt.

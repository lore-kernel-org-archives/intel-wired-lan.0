From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 26 Apr 2016 19:40:40 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e:
 e1000e_cyclecounter_read(): do overflow check only if needed
In-Reply-To: <571F9142.5000002@redhat.com>
References: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
 <1461167156-6737-3-git-send-email-dvlasenk@redhat.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81EF178F@ORSMSX101.amr.corp.intel.com>
 <571F9142.5000002@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EF1D6E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Denys Vlasenko [mailto:dvlasenk at redhat.com]
> Sent: Tuesday, April 26, 2016 9:03 AM
> To: Brown, Aaron F <aaron.f.brown@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH 3/3] e1000e:
> e1000e_cyclecounter_read(): do overflow check only if needed
> 
> On 04/26/2016 01:12 AM, Brown, Aaron F wrote:
> >> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> On
> >> Behalf Of Denys Vlasenko
> >> Sent: Wednesday, April 20, 2016 8:46 AM
> >> To: intel-wired-lan at lists.osuosl.org
> >> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> >> Subject: [Intel-wired-lan] [PATCH 3/3] e1000e:
> e1000e_cyclecounter_read():
> >> do overflow check only if needed
> >>
> >> SYSTIMH:SYSTIML registers are incremented by 24-bit value
> TIMINCA[23..0]
> >>
> >> er32(SYSTIML) are probably moderately expensive (they are pci bus
> reads).
> >> Can we avoid one of them? Yes, we can.
> >>
> >> If the SYSTIML value we see is smaller than 0xff000000, the overflow
> >> into SYSTIMH would require at least two increments.
> >>
> >> We do two reads, er32(SYSTIML) and er32(SYSTIMH), in this order.
> >>
> >> Even if one increment happens between them, the overflow into SYSTIMH
> >> is impossible, and we can avoid doing another er32(SYSTIML) read
> >> and overflow check.
> >>
> ...
> > Still just a warning and I'm not seeing functional problems with it.
> >
> > Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> 
> Aaron, there were some comments from Dima Ruinskiy
> <dima.ruinskiy@intel.com>
> that I might be underestimating the rate how quickly this counter increments:
> that it may be in fact incrementing something like every 40ns.

I did see that come through, for some reason the comment did not get captured in https://patchwork.ozlabs.org/patch/612833/ which I was reading from when I ran it through my regression rig.  Thanks for catching it.

Yes, I guess we should hold off on this until Raanan can weigh in.  Jeff, please ignore thisTested by for now.

> 
> In this case, more than one increment may happen between these two PCIe
> reads:
> 
> 	systimel = er32(SYSTIML);
> 	systimeh = er32(SYSTIMH);
> 
> and my check
> 
> 	/* Is systimel is so large that overflow is possible? */
> 	if (systimel >= (u32)0xffffffff - E1000_TIMINCA_INCVALUE_MASK) {
> 
> can fail to catch an overflow.
> 
> If you (Intel guys) indeed see that as possible, then either drop the 3/3
> patch, or tweak the constant so that more than one increment is needed
> for overflow. Say:
> 
> 	/* Is systimel is so large that overflow is possible? */
> 	if (systimel >= (u32)0xf0000000) {
> 
> This particular constant in comparison allows to skip overflow check
> if we are more than 16 updates away from overflow - should be ample.


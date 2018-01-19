From: Benjamin Poirier <bpoirier@suse.com>
Date: Fri, 19 Jan 2018 17:59:52 +0900
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <CAKgT0UemPMN-30ubbKDR8za4w6f6T2R4GZt5atFzOkCpoSFhsA@mail.gmail.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <CAKgT0UemPMN-30ubbKDR8za4w6f6T2R4GZt5atFzOkCpoSFhsA@mail.gmail.com>
Message-ID: <20180119085952.u63kius4ud34lleq@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/01/18 07:51, Alexander Duyck wrote:
> On Wed, Jan 17, 2018 at 10:50 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> > It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> > 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> > overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> > e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> > on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> > icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.
> 
> Isn't 0x80000004 (_INT_ASSERTED | _LSC)? The assumption I based my

Yes. The numeric value is correct. I made a mistake when writing down
the flag names.

> patch on was that the VMware code was sending _OTHER instead of _LSC
> to trigger LSC events. As such in my version of the workaround I just

It's not so deterministic, sadly. In my tests, upon entry into
e1000_msix_other() after e1000e_trigger_lsc(), with no workaround patch
I've seen:
icr=0x0
icr=0x3d
	Reserved RXDMT0 Reserved LSC TXDW
icr=0x46
	RXO LSC TXQE
and someone else reported:
icr=0x3c
	Reserved RXDMT0 Reserved LSC

> went through and did the testing if the _RXO bit was set, otherwise I
> assumed that whatever event was received must have been meant to
> trigger an _LSC type event since that worked in the past.
> 
> > Some experimentation showed that this flaw in vmware e1000e emulation can
> > be worked around by not setting Other in EIAC. This is how it was before
> > 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
> 
> Did this actually set the _LSC bit or was it just giving you the
> _OTHER bit? The ICR for that combination would come out 0x81000000.

With my patch, after e1000e_trigger_lsc(), it results in icr=0x81000004
on real and emulated hardware.

IMO, the resulting icr read is cleaner than with your patch but it
depends on an undocumented quirk of the emulated vmware e1000e, so I
don't know which of the two workarounds is more desirable.

If you'd like to stick with your patch though, I think that you should
definitely rewrite it as:

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9f18d39bdc8f..68c0bcb8287f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1928,7 +1928,12 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 			__napi_schedule(&adapter->napi);
 		}
 	}
-	if (icr & E1000_ICR_LSC) {
+	if (icr & E1000_ICR_LSC || !(icr & E1000_ICR_RXO)) {
+		/* We assume if the RXO bit is not set that this is a
+		 * link status change event. This is needed due to emulated
+		 * versions of the device that may not correctly populate
+		 * the LSC bit.
+		 */
 		ew32(ICR, E1000_ICR_LSC);
 		hw->mac.get_link_status = true;
 		/* guard against interrupt when we're going down */

> 
> > Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> > ---
> >
> > Jeff, I'm sending as RFC since it looks like a problem that should be fixed
> > in vmware. If you'd like to have the workaround in e1000e, I'll submit.
> 
> I would appreciate it if you could review/test the patch I submitted
> for the same issue. Specifically I would want to make certain that it
> still addresses the original RXO interrupt burst issue your reported.

I've tested both my patch and yours; they both allow link up on vmware;
link up on real 82574 and rxo mitigation on real 82574. I couldn't
conveniently test rxo on vmware.

> 
> Thanks.
> 
> - Alex
> 

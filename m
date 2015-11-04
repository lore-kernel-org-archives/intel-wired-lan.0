From: Benjamin Poirier <bpoirier@suse.com>
Date: Wed, 4 Nov 2015 15:19:45 -0800
Subject: [Intel-wired-lan] [PATCH v2 2/4] e1000e: Do not read icr in
	Other interrupt
In-Reply-To: <5633C2A4.90002@gmail.com>
References: <1446226264-29660-1-git-send-email-bpoirier@suse.com>
 <1446226264-29660-3-git-send-email-bpoirier@suse.com>
 <5633C2A4.90002@gmail.com>
Message-ID: <20151104231945.GA7111@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015/10/30 12:19, Alexander Duyck wrote:
> On 10/30/2015 10:31 AM, Benjamin Poirier wrote:
> >Using eiac instead of reading icr allows us to avoid interference with
> >rx and tx interrupts in the Other interrupt handler.
> >
> >According to the 82574 datasheet section 10.2.4.1, interrupt causes that
> >trigger the Other interrupt are
> >1) Link Status Change.
> >2) Receiver Overrun.
> >3) MDIO Access Complete.
> >4) Small Receive Packet Detected.
> >5) Receive ACK Frame Detected.
> >6) Manageability Event Detected.
> >
> >Causes 3, 4, 5 are related to features which are not enabled by the
> >driver. Always assume that cause 1 is what triggered the Other interrupt
> >and set get_link_status. Cause 2 and 6 should be rare enough that the
> >extra cost of needlessly re-reading the link status is negligible.
> >
> >Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> 
> You might want to instead use a write of LSC to the ICR instead of just
> using auto-clear and not enabling LSC.  My concern is that you might no
> longer be getting link status change events at all.  An easy test is to just
> unplug/plug the cable a few times, or run "ethtool -r" on the link partner
> if connected back to back.  You should see messages appear in the dmesg log
> indicating that the link state changed.
> 
> In addition you should probably clear the IAME bit in the CTRL_EXT register
> so that you don't risk masking the interrupts on the ICR read or write.

Thanks, your concern about not getting LSC events was right. After more
experimentation I noticed that in order for the Other interrupt to be
raised for each of these six conditions, the IMS bit for that condition
must also be set. I've restored setting LSC in IMS. OTOH, I don't see a
need to clear LSC from ICR. Even without an ICR read or write-to-clear
to clear the LSC bit, Other interrupts are raised to signal LSC events.

I'll wait for net-next to reopen and send v3.

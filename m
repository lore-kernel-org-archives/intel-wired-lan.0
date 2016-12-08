From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 8 Dec 2016 10:43:15 +0000
Subject: [Intel-wired-lan] [RFC PATCH] i40e: enable PCIe relax ordering
 for SPARC
In-Reply-To: <CAKgT0UfTP+BrvDBzUJAVr9-DRCKgM7T3aS=LgRic8UZz8x82eg@mail.gmail.com>
References: <1480957627-16825-1-git-send-email-tushar.n.dave@oracle.com>
 <CAKgT0UcyRSub0NCi7oHX2Vf+N4vQxzwdWmcc+V+jOX_J=RYgfg@mail.gmail.com>
 <ec140d5d-3eec-5fc6-6417-11bacc55b807@oracle.com>
 <CAKgT0UfTP+BrvDBzUJAVr9-DRCKgM7T3aS=LgRic8UZz8x82eg@mail.gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02382BD@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck
> Sent: 06 December 2016 17:10
...
> I was thinking about it and I realized we can probably simplify this
> even further.  In the case of most other architectures the
> DMA_ATTR_WEAK_ORDERING has no effect anyway.  So from what I can tell
> there is probably no reason not to just always pass that attribute
> with the DMA mappings.  From what I can tell the only other
> architecture that uses this is the PowerPC Cell architecture.

And I should have read all the thread :-(

> Also I was wondering if you actually needed to enable this attribute
> for both Rx and Tx buffers or just Rx buffers?  The patch that enabled
> DMA_ATTR_WEAK_ORDERING for Sparc64 seems to call out writes, but I
> didn't see anything about reads.  I'm just wondering if changing the
> code for Tx has any effect?  If not you could probably drop those
> changes and just focus on Rx.

'Weak ordering' only applies to PCIe read transfers, so can only have
an effect on descriptor reads and transmit buffer reads.

Basically PCIe is a comms protocol and an endpoint (or the host) can
have multiple outstanding read requests (each of which might generate
multiple response messages.
The responses for each request must arrive in order, but responses for
different requests can be interleaved.
Setting 'not weak ordering' lets the host interwork with broken endpoints.
(Or, like we did, you fix the fpga's PCIe implementation.)

In this case you need the reads of both transmit and receive rings to
'overtake' reads of transmit data.

I'm not at all clear how this 'flag' can be set on dma_map().
It is a property of the PCIe subsystem.

	David



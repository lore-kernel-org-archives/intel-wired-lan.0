From: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 8 Jul 2021 10:45:50 -0500
Subject: [Intel-wired-lan] [PATCH 1/2] igc: don't rd/wr iomem when PCI
 is removed
In-Reply-To: <CAOSf1CGVpogQGAatuY_N0db6OL2BFegGtj6VTLA9KFz0TqYBQg@mail.gmail.com>
Message-ID: <20210708154550.GA1019947@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jul 08, 2021 at 12:04:02PM +1000, Oliver O'Halloran wrote:
> On Thu, Jul 8, 2021 at 8:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > If we add the check as proposed in this patch, I think people will
> > read it and think this is the correct way to avoid MMIO errors.  It
> > does happen to avoid some MMIO errors, but it cannot avoid them all,
> > so it's not a complete solution and it gives a false sense of
> > security.
> 
> I think it's helpful to classify MMIO errors as either benign or
> poisonous with the poison MMIOs causing some kind of crash. Most of
> the discussions about pci_dev_is_disconnected(), including this one,
> seem to stem from people trying to use it to avoid the poison case. I
> agree that using pci_dev_is_disconnected() that way is hacky and
> doesn't really fix the problem, but considering poison MMIOs usually
> stem from broken hardware or firmware maybe we should allow it
> anyway. We can't do anything better and it's an improvement compared
> to crashing.

Apologies for rehashing what's probably obvious to everybody but me.
I'm trying to get a better handle on benign vs poisonous errors.

MMIO means CPU reads or writes to the device.  In PCI, writes are
posted and don't receive a response, so a driver will never see
writel() return an error (although an error may be reported
asynchronously via AER or similar).

So I think we're mostly talking about CPU reads here.  We expect a PCI
response containing the data.  Sometimes there's no response or an
error response.  The behavior of the host bridge in these error cases
is not defined by PCI, so what the CPU sees is not consistent across
platforms.  In some cases, the bridge handles this as a catastrophic
error that forces a system restart.

But in most cases, at least on x86, the bridge logs an error and
fabricates ~0 data so the CPU read can complete.  Then it's up to
software to recognize that an error occurred and decide what to do
about it.  Is this a benign or a poisonous error?

I'd say this is a benign error.  It certainly can't be ignored, but as
long as the driver recognizes the error, it should be able to deal
with it without crashing the whole system and forcing a restart.

Bjorn

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 19 Jul 2021 19:17:13 -0500
Subject: [Intel-wired-lan] [PATCH 1/2] igc: don't rd/wr iomem when PCI
 is removed
In-Reply-To: <CAOSf1CHOrUBfibO0t6Zr2=SZ7GjLTiAzfoKBeZL8RXdcC+Ou3A@mail.gmail.com>
Message-ID: <20210720001713.GA38755@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jul 19, 2021 at 12:49:18PM +1000, Oliver O'Halloran wrote:
> On Mon, Jul 19, 2021 at 8:51 AM Pali Roh?r <pali@kernel.org> wrote:
> >
> > And do we have some solution for this kind of issue? There are more PCIe
> > controllers / platforms which do not like MMIO read/write operation when
> > card / link is not connected.
> 
> Do you have some actual examples? The few times I've seen those
> crashes were due to broken firmware-first error handling. The AER
> notifications would be escalated into some kind of ACPI error which
> the kernel didn't have a good way of dealing with so it panicked
> instead.
> 
> Assuming it is a real problem then as Bjorn pointed out this sort of
> hack doesn't really fix the issue because hotplug and AER
> notifications are fundamentally asynchronous. If the driver is
> actively using the device when the error / removal happens then the
> pci_dev_is_disconnected() check will pass and the MMIO will go
> through. If the MMIO is poisonous because of dumb hardware then this
> sort of hack will only paper over the issue.
> 
> > If we do not provide a way how to solve these problems then we can
> > expect that people would just hack ethernet / wifi / ... device drivers
> > which are currently crashing by patches like in this thread.
> >
> > Maybe PCI subsystem could provide wrapper function which implements
> > above pattern and which can be used by device drivers?
> 
> We could do that and I think there was a proposal to add some
> pci_readl(pdev, <addr>) style wrappers at one point.

Obviously this wouldn't help user-space mmaps, but in the kernel,
Documentation/driver-api/device-io.rst [1] does say that drivers are
supposed to use readl() et al even though on most arches it "works"
to just dereference the result of ioremap(), so maybe we could make
a useful wrapper.

Seems like we should do *something*, even if it's just a generic
#define and some examples.  I took a stab at this [2] a couple years
ago, but it was only for the PCI core, and it didn't go anywhere.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/device-io.rst?id=v5.13#n160
[2] https://lore.kernel.org/linux-pci/20190822200551.129039-1-helgaas at kernel.org/

> On powerpc
> there's hooks in the arch provided MMIO functions to detect error
> responses and kick off the error handling machinery when a problem is
> detected. Those hooks are mainly there to help the platform detect
> errors though and they don't make life much easier for drivers. Due to
> locking concerns the driver's .error_detected() callback cannot be
> called in the MMIO hook so even when the platform detects errors
> synchronously the driver notifications must happen asynchronously. In
> the meanwhile the driver still needs to handle the 0xFFs response
> safely and there's not much we can do from the platform side to help
> there.
> 
> Oliver

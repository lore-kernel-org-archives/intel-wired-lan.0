From: Oliver O'Halloran <oohall@gmail.com>
Date: Mon, 19 Jul 2021 12:49:18 +1000
Subject: [Intel-wired-lan] [PATCH 1/2] igc: don't rd/wr iomem when PCI
 is removed
In-Reply-To: <20210718225059.hd3od4k4on3aopcu@pali>
References: <CAOSf1CGVpogQGAatuY_N0db6OL2BFegGtj6VTLA9KFz0TqYBQg@mail.gmail.com>
 <20210708154550.GA1019947@bjorn-Precision-5520>
 <CAOSf1CHtHLyEHC58jwemZS6j=jAU2OrrYitkUYmdisJtuFu4dw@mail.gmail.com>
 <20210718225059.hd3od4k4on3aopcu@pali>
Message-ID: <CAOSf1CHOrUBfibO0t6Zr2=SZ7GjLTiAzfoKBeZL8RXdcC+Ou3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jul 19, 2021 at 8:51 AM Pali Roh?r <pali@kernel.org> wrote:
>
> And do we have some solution for this kind of issue? There are more PCIe
> controllers / platforms which do not like MMIO read/write operation when
> card / link is not connected.

Do you have some actual examples? The few times I've seen those
crashes were due to broken firmware-first error handling. The AER
notifications would be escalated into some kind of ACPI error which
the kernel didn't have a good way of dealing with so it panicked
instead.

Assuming it is a real problem then as Bjorn pointed out this sort of
hack doesn't really fix the issue because hotplug and AER
notifications are fundamentally asynchronous. If the driver is
actively using the device when the error / removal happens then the
pci_dev_is_disconnected() check will pass and the MMIO will go
through. If the MMIO is poisonous because of dumb hardware then this
sort of hack will only paper over the issue.

> If we do not provide a way how to solve these problems then we can
> expect that people would just hack ethernet / wifi / ... device drivers
> which are currently crashing by patches like in this thread.
>
> Maybe PCI subsystem could provide wrapper function which implements
> above pattern and which can be used by device drivers?

We could do that and I think there was a proposal to add some
pci_readl(pdev, <addr>) style wrappers at one point. On powerpc
there's hooks in the arch provided MMIO functions to detect error
responses and kick off the error handling machinery when a problem is
detected. Those hooks are mainly there to help the platform detect
errors though and they don't make life much easier for drivers. Due to
locking concerns the driver's .error_detected() callback cannot be
called in the MMIO hook so even when the platform detects errors
synchronously the driver notifications must happen asynchronously. In
the meanwhile the driver still needs to handle the 0xFFs response
safely and there's not much we can do from the platform side to help
there.

Oliver

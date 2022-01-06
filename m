From: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 6 Jan 2022 12:14:09 -0600
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <74bf4fde-3972-1c36-ca04-58089da0d82b@huawei.com>
Message-ID: <20220106181409.GA297735@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 06, 2022 at 05:41:00PM +0000, John Garry wrote:
> On 05/01/2022 19:47, Bjorn Helgaas wrote:

> > IMO inb() should
> > be present but do something innocuous like return ~0, as it would if
> > I/O port space is supported but there's no device at that address.
> > 
> > [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/megaraid.c?id=v5.15#n4210
> > 
> 
> That driver would prob not be used on systems which does not support PIO,
> and so could have a HAS_IOPORT dependency. But it is not strictly necessary.

I don't want the path of "this driver isn't needed because the device
is unlikely to be used on this arch."

Maybe it's not _always_ possible, but if the device can be plugged
into the platform, I think we should be able to build the driver for
it.

If the device requires I/O port space and the platform doesn't support
it, the PCI core or the driver should detect that and give a useful
diagnostic.

Bjorn

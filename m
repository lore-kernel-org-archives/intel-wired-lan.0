From: Marc Zyngier <maz@kernel.org>
Date: Tue, 19 Oct 2021 08:39:51 +0100
Subject: [Intel-wired-lan] [PATCH v3 0/3] PCI/MSI: Clarify the IRQ sysfs
 ABI for PCI devices
In-Reply-To: <20211018215047.GA2265015@bhelgaas>
References: <20210825102636.52757-1-21cnbao@gmail.com>
 <20211018215047.GA2265015@bhelgaas>
Message-ID: <87wnm9o43c.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 18 Oct 2021 22:50:47 +0100,
Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Wed, Aug 25, 2021 at 06:26:33PM +0800, Barry Song wrote:
> > From: Barry Song <song.bao.hua@hisilicon.com>
> > 
> > 
> > /sys/bus/pci/devices/.../irq has been there for many years but it has never
> > been documented. This patchset is trying to clarify it.
> > 
> > -v3:
> >   - Don't attempt to modify the current behaviour of IRQ ABI for MSI-X
> >   - Make MSI IRQ ABI more explicit(return 1st IRQ of the IRQ vector)
> >   - Add Marc's patch of removing default_irq from the previous comment to
> >     the series.
> >   Note patch 3/3 indirectly changed the code of pci_restore_msi_state(),
> >   drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c is the only driver
> >   calling this API. I would appreciate testing done from this driver's
> >   maintainers.
> > 
> > -v2:
> >   - split into two patches according to Bjorn's comments;
> >   - Add Greg's Acked-by, thanks for reviewing!
> >   https://lore.kernel.org/lkml/20210820223744.8439-1-21cnbao at gmail.com/
> > 
> > -v1:
> >   https://lore.kernel.org/lkml/20210813122650.25764-1-21cnbao at gmail.com/#t
> > 
> > Barry Song (2):
> >   Documentation: ABI: sysfs-bus-pci: Add description for IRQ entry
> >   PCI/sysfs: Don't depend on pci_dev.irq for IRQ entry
> 
> I applied the first two (above) to pci/msi for v5.16, thanks!
> 
> As far as I can tell from the discussion so far, they should be safe
> and should preserve all existing behavior.  The second patch should
> remove the sysfs dependency on the PCI core to swap the INTx and first
> MSI IRQ values in dev->irq.
> 
> Marc's patch below is certainly desirable but my understanding is that
> it requires some driver updates first.

Indeed. It means that there will be an uphill battle to remove the
INTx/MSI confusion in a lot of drivers (Barry says about 700 of them,
and I can't say I'm surprised).

We can probably tackle that as a background task for the next few
releases (I need to relearn Coccinelle for the 27th time...).

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

From: Marc Zyngier <maz@kernel.org>
Date: Wed, 25 Aug 2021 14:38:22 +0100
Subject: [Intel-wired-lan] [PATCH v3 3/3] PCI/MSI: remove
 msi_attrib.default_irq in msi_desc
In-Reply-To: <20210825102636.52757-4-21cnbao@gmail.com>
References: <20210825102636.52757-1-21cnbao@gmail.com>
 <20210825102636.52757-4-21cnbao@gmail.com>
Message-ID: <87bl5lpru9.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 25 Aug 2021 11:26:36 +0100,
Barry Song <21cnbao@gmail.com> wrote:
> 
> From: Marc Zyngier <maz@kernel.org>
> 
> default_irq is hideous as it should be per-device but not per-desc.
> On the other hand, MSI-X case doesn't use it at all. Since sysfs
> IRQ has moved to use the msi_entry instead of pci_dev.irq, now it
> seems it is safe to remove msi_attrib.default_irq.

Thanks for doing the write-up. Maybe worth adding that drivers that
use dev->irq while having enabled MSI will break (INTx will be
disabled while MSI is enabled). That should give people a clue about
what to fix when they bisect the problem to this patch.

Also, a link to the discussion that lead to this patch would be useful
to give some context.

No need to respin this for now, let's give it a shake after 5.14.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

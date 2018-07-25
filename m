From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 25 Jul 2018 15:59:29 -0500
Subject: [Intel-wired-lan] [PATCH v1 0/4] PCI: Remove unnecessary
 includes of <linux/pci-aspm.h>
In-Reply-To: <43748afd-712a-48e5-97a9-0b6046f575b3@kernel.org>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <43748afd-712a-48e5-97a9-0b6046f575b3@kernel.org>
Message-ID: <20180725205929.GB173328@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jul 25, 2018 at 01:33:23PM -0700, Sinan Kaya wrote:
> On 7/25/2018 12:52 PM, Bjorn Helgaas wrote:
> > emove includes of <linux/pci-aspm.h> from files that don't need
> > it.  I'll apply all these via the PCI tree unless there's objection.
> > 
> > ---
> > 
> > Bjorn Helgaas (4):
> >        igb: Remove unnecessary include of <linux/pci-aspm.h>
> >        ath9k: Remove unnecessary include of <linux/pci-aspm.h>
> >        iwlwifi: Remove unnecessary include of <linux/pci-aspm.h>
> >        PCI: Remove unnecessary include of <linux/pci-aspm.h>
> 
> Thanks.
> 
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> 
> Is it possible to kill that file altogether? I haven't looked who is
> using outside of pci directory.

Thanks for taking a look!

It's possible we could remove it altogether; there's very little in
it, and in most cases the only reason drivers include it is to disable
certain ASPM link states to work around hardware defects.  It might
make sense to just move that interface into <linux/pci.h>.

From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 13 May 2015 17:50:12 +0000
Subject: [Intel-wired-lan] [PATCH] vfio-pci: PCI_DEV_FLAGS_ASSIGNED flag
 not set when PCI device is assigned
In-Reply-To: <1431484908.3625.10.camel@redhat.com>
References: <20150513013550.10328.1416.stgit@bwallan-smackover2.jf.intel.com>
 <1431484908.3625.10.camel@redhat.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1846BBD2E63@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson at redhat.com]
> Sent: Tuesday, May 12, 2015 7:42 PM
> To: Allan, Bruce W
> Cc: kvm at vger.kernel.org; netdev at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [PATCH] vfio-pci: PCI_DEV_FLAGS_ASSIGNED flag not set when
> PCI device is assigned
> 
> On Tue, 2015-05-12 at 18:35 -0700, Bruce Allan wrote:
> > A number of PCI device drivers supporting SR-IOV use pci_vfs_assigned()
> to
> > check if there are any VF devices assigned by a VMM prior to disabling
> > SR-IOV (i.e. bnx2x, be2net, fm10k, i40e, igb, ixgbe, qlcnic).  This check
> > works fine with the legacy device assignment (pci-stub enables the
> device)
> > which calls pci_set_dev_assigned().  The newer VFIO-based assignment
> > (vfio-pci enables device) doesn't call pci_set_dev_assigned() potentially
> > leading to issues in those drivers when disabling SR-IOV with VFs assigned.
> >
> > Add calls to pci_[set|clear]_dev_assigned() to set the flag as expected.
> >
> > Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> > ---
> >  drivers/vfio/pci/vfio_pci.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> 
> 
> Why should a device exposed to the user be handled differently than a
> device used by a host driver?  The reason the assigned flag exists is
> because legacy KVM device assignment doesn't actually claim the device
> using the driver model, it relies on pci-stub to act as a placeholder to
> prevent other drivers from binding to the device, but pci-stub has no
> visibility to the device usage and will immediately release it
> regardless of it being in use.  vfio-pci participates in the driver
> model, signals the user for the device to be released and blocks until
> it is released.  Beyond that, the assigned flag is a racy hack.  There's
> no locking whatsoever to imply that the flag as any meaning beyond the
> instant that it's tested.  I'd like to see the assigned flag deprecated
> along with legacy KVM device assignment, not perpetuated in newer
> drivers.  The patch is also wrong because we can tell when the device is
> actually opened by the user, not just bound to the vfio-pci driver.
> Thanks,
> 
> Alex

So for clarification, in the drivers mentioned above would you recommend
rather than checking pci_vfs_assigned() before disabling SR-IOV the drivers
should instead check if any of the VF devices are bound/opened by another
driver?

Thanks,
Bruce.


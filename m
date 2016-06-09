From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 9 Jun 2016 17:38:25 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: restore D0 power state upon
 probe
In-Reply-To: <CAKgT0Ueno8VjnHDZsqGOU+t5h2DJQOkOLO8vJk8z-ZMpgn5_MA@mail.gmail.com>
References: <20160608002043.10367-1-jacob.e.keller@intel.com>
 <CAKgT0UdmTRUesM9hD9ifUw=+rx117=Ck7bzEgezHX=WGR2rArQ@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5857AE09FD@ORSMSX115.amr.corp.intel.com>
 <CAKgT0UdjL=4d7vXi4oCYw4G7fTe864vA4=1=2HYTK9KBQPLuQA@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5857AE0C0D@ORSMSX115.amr.corp.intel.com>
 <CAKgT0Uft298E1zAkEJ+R7SGrA9oisS6Ufpkmo7V-KD+eBvLXnQ@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5857AE0C33@ORSMSX115.amr.corp.intel.com>
 <CAKgT0Ueno8VjnHDZsqGOU+t5h2DJQOkOLO8vJk8z-ZMpgn5_MA@mail.gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857AE19DE@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Wednesday, June 08, 2016 2:34 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH] fm10k: restore D0 power state upon
> probe
> 
> On Wed, Jun 8, 2016 at 2:23 PM, Keller, Jacob E
> <jacob.e.keller@intel.com> wrote:
> >> -----Original Message-----
> >> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> >> Sent: Wednesday, June 08, 2016 2:23 PM
> >> To: Keller, Jacob E <jacob.e.keller@intel.com>
> >> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> >> Subject: Re: [Intel-wired-lan] [PATCH] fm10k: restore D0 power state
> upon
> >> probe
> >>
> >> On Wed, Jun 8, 2016 at 2:18 PM, Keller, Jacob E
> >> <jacob.e.keller@intel.com> wrote:
> >> >> -----Original Message-----
> >> >> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> >> >> Sent: Wednesday, June 08, 2016 2:02 PM
> >> >> To: Keller, Jacob E <jacob.e.keller@intel.com>
> >> >> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> >> >> Subject: Re: [Intel-wired-lan] [PATCH] fm10k: restore D0 power state
> >> upon
> >> >> probe
> >> >>
> >> >> On Wed, Jun 8, 2016 at 12:11 PM, Keller, Jacob E
> >> >> <jacob.e.keller@intel.com> wrote:
> >> >> >> -----Original Message-----
> >> >> >> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> >> >> >> Sent: Tuesday, June 07, 2016 8:54 PM
> >> >> >> To: Keller, Jacob E <jacob.e.keller@intel.com>
> >> >> >> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> >> >> >> Subject: Re: [Intel-wired-lan] [PATCH] fm10k: restore D0 power
> state
> >> >> upon
> >> >> >> probe
> >> >> >>
> >> >> >> On Tue, Jun 7, 2016 at 5:20 PM, Jacob Keller
> >> <jacob.e.keller@intel.com>
> >> >> >> wrote:
> >> >> >> > It seems that under some circumstances, such as after
> performing
> >> an
> >> >> >> > unbind following an AER injection recovery, the power state of a
> VF
> >> >> >> > isn't set to PCI_D0. Following the unbind if we attempt to bind
> the
> >> >> >> > device, the MSI-X initialization fails due to incorrect power state.
> >> >> >>
> >> >> >> That doesn't make much sense.  I didn't think the VFs had their own
> >> >> >> power state control.  After all it isn't as if they could switch off
> >> >> >> while the PF is active on the host.
> >> >> >>
> >> >> >> > Fix this by always calling pci_set_power_state(pdev, PCI_D0) on
> >> driver
> >> >> >> > device probe.
> >> >> >>
> >> >> >> That should be redundant.  There is already code that is called to
> >> >> >> transition the power state to D0 in pci_enable_device_mem.  As
> long
> >> as
> >> >> >> nobody else has enabled the device it will be ran.
> >> >> >>
> >> >> >
> >> >> > That's weird. In this case, after doing aer-inject on the PF, if we
> unbind
> >> >> then bind the VF device, it fails in pci_enable_msix_range which I
> traced
> >> into
> >> >> eventually a call that fails because the state isn't PCI_D0. If I add a
> >> >> "pci_set_power_state(pdev, PCI_D0)" call in the probe routine it
> works
> >> >> fine...?
> >> >> >
> >> >> > I don't really know why that'd be the case... thoughts?
> >> >>
> >> >> Does the VF even advertise support for PCI power management
> >> >> capability?  If I recall a VF shouldn't.  As such I think a call to
> >> >> pci_set_power_state should be returning an error and not doing
> >> >> anything so I would think this code only has any effect on the PF.  So
> >> >> I am not certain what this patch is even doing if you aren't reloading
> >> >> the PF driver to trigger it.
> >> >>
> >> >> - Alex
> >> >
> >> > I'm not sure either but without it we're ending up with the failure in
> >> pci_msi_supported failing with -EINVAL because dev->current_state !=
> >> PCI_D0...
> >> >
> >> > It only happens after an unbind of the VF device then a bind. I think
> >> somehow the dev->current_state gets messed up but I don't know how
> this
> >> happens.
> >> >
> >> > Thanks,
> >> > Jake
> >>
> >> When you say unbind/bind are you talking about using the sysfs or is
> >> this via some other mechanism?
> >>
> >> - Alex
> >
> > Using sysfs. We echo the PCI address to fm10k's unbind, then echo it to
> bind.
> >
> > Thanks,
> > Jake
> 
> I'm wondering if we have a reference count bug being created
> somewhere.  One thing you might try tracking is the dev->enable_cnt
> value for the VF through probe and after a remove to see if we are
> leaking that somewhere.  The other thing to look for is to figure out
> where we are setting dev->current_state to something other than
> PCI_D0.  I'd be interested in knowing where we are messing on this
> with a VF and what we are setting it to.
> 
> - Alex

Yep, when we call pci_enable_device_mem() in fm10k_io_slot_reset() we leak an enable count and I think that?s at least partially responsible for the failure since I bet VFs don't actually expose power state, so once enabled it won't change back from unknown?

Thanks,
Jake

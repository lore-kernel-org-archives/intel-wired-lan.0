From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 8 Jun 2016 19:11:27 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: restore D0 power state upon
 probe
In-Reply-To: <CAKgT0UdmTRUesM9hD9ifUw=+rx117=Ck7bzEgezHX=WGR2rArQ@mail.gmail.com>
References: <20160608002043.10367-1-jacob.e.keller@intel.com>
 <CAKgT0UdmTRUesM9hD9ifUw=+rx117=Ck7bzEgezHX=WGR2rArQ@mail.gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857AE09FD@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Tuesday, June 07, 2016 8:54 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH] fm10k: restore D0 power state upon
> probe
> 
> On Tue, Jun 7, 2016 at 5:20 PM, Jacob Keller <jacob.e.keller@intel.com>
> wrote:
> > It seems that under some circumstances, such as after performing an
> > unbind following an AER injection recovery, the power state of a VF
> > isn't set to PCI_D0. Following the unbind if we attempt to bind the
> > device, the MSI-X initialization fails due to incorrect power state.
> 
> That doesn't make much sense.  I didn't think the VFs had their own
> power state control.  After all it isn't as if they could switch off
> while the PF is active on the host.
> 
> > Fix this by always calling pci_set_power_state(pdev, PCI_D0) on driver
> > device probe.
> 
> That should be redundant.  There is already code that is called to
> transition the power state to D0 in pci_enable_device_mem.  As long as
> nobody else has enabled the device it will be ran.
> 

That's weird. In this case, after doing aer-inject on the PF, if we unbind then bind the VF device, it fails in pci_enable_msix_range which I traced into eventually a call that fails because the state isn't PCI_D0. If I add a "pci_set_power_state(pdev, PCI_D0)" call in the probe routine it works fine...?

I don't really know why that'd be the case... thoughts?

Thanks,
Jake


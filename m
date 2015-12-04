From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 4 Dec 2015 09:07:57 -0800
Subject: [Intel-wired-lan] [RFC PATCH V2 0/3] IXGBE/VFIO: Add live
 migration support for SRIOV NIC
In-Reply-To: <5661C000.8070201@intel.com>
References: <CAKgT0UevBmRLpM1PvuuVDUW79A66RcPrfO8uGiqL1RiALW7apg@mail.gmail.com>
 <A12AC9D104E08D47BAF23C492F83C53B25CDE9E3@SHSMSX104.ccr.corp.intel.com>
 <CAKgT0Ucyq=7OSYBVvU9Z01b3f6scS+eBMLg+yphW7bwkNZosPQ@mail.gmail.com>
 <565BF285.4040507@intel.com>
 <CAKgT0Uc+-gFAetEfde6DmMOFK+vDE6UkgsNF8oLNqaQc4USSeg@mail.gmail.com>
 <565DB6FF.1050602@intel.com> <20151201171140-mutt-send-email-mst@redhat.com>
 <CAKgT0UfLEJpV-KdqRGfzBeas8bdqfHCmT5Xc8iVVP03g_pQO8A@mail.gmail.com>
 <20151201193026-mutt-send-email-mst@redhat.com>
 <CAKgT0UfJ7w6yYcZcF2YZyDKEwvE7Gh3P-jfGQGKLfPH2crVBzw@mail.gmail.com>
 <20151202105955-mutt-send-email-mst@redhat.com> <5661C000.8070201@intel.com>
Message-ID: <5661C86D.3010904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/04/2015 08:32 AM, Lan, Tianyu wrote:
> Hi Michael & Alexander:
> Thanks a lot for your comments and suggestions.
>
> We still need to support Windows guest for migration and this is why our
> patches keep all changes in the driver since it's impossible to change
> Windows kernel.

That is a poor argument.  I highly doubt Microsoft is interested in 
having to modify all of the drivers that will support direct assignment 
in order to support migration.  They would likely request something 
similar to what I have in that they will want a way to do DMA tracking 
with minimal modification required to the drivers.

> Following is my idea to do DMA tracking.
>
> Inject event to VF driver after memory iterate stage
> and before stop VCPU and then VF driver marks dirty all
> using DMA memory. The new allocated pages also need to
> be marked dirty before stopping VCPU. All dirty memory
> in this time slot will be migrated until stop-and-copy
> stage. We also need to make sure to disable VF via clearing the
> bus master enable bit for VF before migrating these memory.

The ordering of your explanation here doesn't quite work.  What needs to 
happen is that you have to disable DMA and then mark the pages as dirty. 
  What the disabling of the BME does is signal to the hypervisor that 
the device is now stopped.  The ixgbevf_suspend call already supported 
by the driver is almost exactly what is needed to take care of something 
like this.

The question is how we would go about triggering it.  I really don't 
think the PCI configuration space approach is the right idea.  I wonder 
if we couldn't get away with some sort of ACPI event instead.  We 
already require ACPI support in order to shut down the system 
gracefully, I wonder if we couldn't get away with something similar in 
order to suspend/resume the direct assigned devices gracefully.

> The dma page allocated by VF driver also needs to reserve space
> to do dummy write.

No, this will not work.  If for example you have a VF driver allocating 
memory for a 9K receive how will that work?  It isn't as if you can poke 
a hole in the contiguous memory.


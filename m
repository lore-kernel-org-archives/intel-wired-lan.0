From: Michael S. Tsirkin <mst@redhat.com>
Date: Wed, 9 Dec 2015 13:28:36 +0200
Subject: [Intel-wired-lan] [RFC PATCH V2 0/3] IXGBE/VFIO: Add live
 migration support for SRIOV NIC
In-Reply-To: <56680E33.6040204@intel.com>
References: <CAKgT0Uc+-gFAetEfde6DmMOFK+vDE6UkgsNF8oLNqaQc4USSeg@mail.gmail.com>
 <565DB6FF.1050602@intel.com>
 <20151201171140-mutt-send-email-mst@redhat.com>
 <CAKgT0UfLEJpV-KdqRGfzBeas8bdqfHCmT5Xc8iVVP03g_pQO8A@mail.gmail.com>
 <20151201193026-mutt-send-email-mst@redhat.com>
 <CAKgT0UfJ7w6yYcZcF2YZyDKEwvE7Gh3P-jfGQGKLfPH2crVBzw@mail.gmail.com>
 <20151202105955-mutt-send-email-mst@redhat.com>
 <5661C000.8070201@intel.com>
 <20151209122831-mutt-send-email-mst@redhat.com>
 <56680E33.6040204@intel.com>
Message-ID: <20151209132233-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Dec 09, 2015 at 07:19:15PM +0800, Lan, Tianyu wrote:
> On 12/9/2015 6:37 PM, Michael S. Tsirkin wrote:
> >On Sat, Dec 05, 2015 at 12:32:00AM +0800, Lan, Tianyu wrote:
> >>Hi Michael & Alexander:
> >>Thanks a lot for your comments and suggestions.
> >
> >It's nice that it's appreciated, but you then go on and ignore
> >all that I have written here:
> >https://www.mail-archive.com/kvm at vger.kernel.org/msg123826.html
> >
> 
> No, I will reply it separately and according your suggestion to snip it into
> 3 thread.
> 
> >>We still need to support Windows guest for migration and this is why our
> >>patches keep all changes in the driver since it's impossible to change
> >>Windows kernel.
> >
> >This is not a reasonable argument.  It makes no sense to duplicate code
> >on Linux because you must duplicate code on Windows.  Let's assume you
> >must do it in the driver on windows because windows has closed source
> >drivers.  What does it matter? Linux can still do it as part of DMA API
> >and have it apply to all drivers.
> >
> 
> Sure. Duplicated code should be encapsulated and make it able to reuse
> by other drivers. Just like you said the dummy write part.
> 
> I meant the framework should not require to change Windows kernel code
> (such as PM core or PCI bus driver)and this will block implementation on
> the Windows.

I remember reading that it's possible to implement a bus driver
on windows if required.  But basically I don't see how windows can be
relevant to discussing guest driver patches. That discussion
probably belongs on the qemu maling list, not on lkml.

> I think it's not problem to duplicate code in the Windows drivers.
> 
> >>Following is my idea to do DMA tracking.
> >>
> >>Inject event to VF driver after memory iterate stage
> >>and before stop VCPU and then VF driver marks dirty all
> >>using DMA memory. The new allocated pages also need to
> >>be marked dirty before stopping VCPU. All dirty memory
> >>in this time slot will be migrated until stop-and-copy
> >>stage. We also need to make sure to disable VF via clearing the
> >>bus master enable bit for VF before migrating these memory.
> >>
> >>The dma page allocated by VF driver also needs to reserve space
> >>to do dummy write.
> >
> >I suggested ways to do it all in the hypervisor without driver hacks, or
> >hide it within DMA API without need to reserve extra space. Both
> >approaches seem much cleaner.
> >
> 
> This sounds reasonable. We may discuss it detail in the separate thread.

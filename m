From: Michael S. Tsirkin <mst@redhat.com>
Date: Tue, 1 Dec 2015 17:28:48 +0200
Subject: [Intel-wired-lan] [RFC PATCH V2 0/3] IXGBE/VFIO: Add live
 migration support for SRIOV NIC
In-Reply-To: <565DB6FF.1050602@intel.com>
References: <5654722D.4010409@gmail.com> <56552888.90108@intel.com>
 <CAKgT0UcSrewenfM2YdVojHFFqfK2aVbBN5LH8=BFzc1p0f9hvQ@mail.gmail.com>
 <56556F98.5060507@intel.com>
 <CAKgT0UevBmRLpM1PvuuVDUW79A66RcPrfO8uGiqL1RiALW7apg@mail.gmail.com>
 <A12AC9D104E08D47BAF23C492F83C53B25CDE9E3@SHSMSX104.ccr.corp.intel.com>
 <CAKgT0Ucyq=7OSYBVvU9Z01b3f6scS+eBMLg+yphW7bwkNZosPQ@mail.gmail.com>
 <565BF285.4040507@intel.com>
 <CAKgT0Uc+-gFAetEfde6DmMOFK+vDE6UkgsNF8oLNqaQc4USSeg@mail.gmail.com>
 <565DB6FF.1050602@intel.com>
Message-ID: <20151201171140-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 01, 2015 at 11:04:31PM +0800, Lan, Tianyu wrote:
> 
> 
> On 12/1/2015 12:07 AM, Alexander Duyck wrote:
> >They can only be corrected if the underlying assumptions are correct
> >and they aren't.  Your solution would have never worked correctly.
> >The problem is you assume you can keep the device running when you are
> >migrating and you simply cannot.  At some point you will always have
> >to stop the device in order to complete the migration, and you cannot
> >stop it before you have stopped your page tracking mechanism.  So
> >unless the platform has an IOMMU that is somehow taking part in the
> >dirty page tracking you will not be able to stop the guest and then
> >the device, it will have to be the device and then the guest.
> >
> >>>Doing suspend and resume() may help to do migration easily but some
> >>>devices requires low service down time. Especially network and I got
> >>>that some cloud company promised less than 500ms network service downtime.
> >Honestly focusing on the downtime is getting the cart ahead of the
> >horse.  First you need to be able to do this without corrupting system
> >memory and regardless of the state of the device.  You haven't even
> >gotten to that state yet.  Last I knew the device had to be up in
> >order for your migration to even work.
> 
> I think the issue is that the content of rx package delivered to stack maybe
> changed during migration because the piece of memory won't be migrated to
> new machine. This may confuse applications or stack. Current dummy write
> solution can ensure the content of package won't change after doing dummy
> write while the content maybe not received data if migration happens before
> that point. We can recheck the content via checksum or crc in the protocol
> after dummy write to ensure the content is what VF received. I think stack
> has already done such checks and the package will be abandoned if failed to
> pass through the check.


Most people nowdays rely on hardware checksums so I don't think this can
fly.

> Another way is to tell all memory driver are using to Qemu and let Qemu to
> migrate these memory after stopping VCPU and the device. This seems safe but
> implementation maybe complex.

Not really 100% safe.  See below.

I think hiding these details behind dma_* API does have
some appeal. In any case, it gives us a good
terminology as it covers what most drivers do.

There are several components to this:
- dma_map_* needs to prevent page from
  being migrated while device is running.
  For example, expose some kind of bitmap from guest
  to host, set bit there while page is mapped.
  What happens if we stop the guest and some
  bits are still set? See dma_alloc_coherent below
  for some ideas.


- dma_unmap_* needs to mark page as dirty
  This can be done by writing into a page.

- dma_sync_* needs to mark page as dirty
  This is trickier as we can not change the data.
  One solution is using atomics.
  For example:
        int x = ACCESS_ONCE(*p);
        cmpxchg(p, x, x);
  Seems to do a write without changing page
  contents.

- dma_alloc_coherent memory (e.g. device rings)
  must be migrated after device stopped modifying it.
  Just stopping the VCPU is not enough:
  you must make sure device is not changing it.

  Or maybe the device has some kind of ring flush operation,
  if there was a reasonably portable way to do this
  (e.g. a flush capability could maybe be added to SRIOV)
  then hypervisor could do this.

  With existing devices,
  either do it after device reset, or disable
  memory access in the IOMMU. Maybe both.

  In case you need to resume on source, you
  really need to follow the same path
  as on destination, preferably detecting
  device reset and restoring the device
  state.

  A similar approach could work for dma_map_ above.

-- 
MST

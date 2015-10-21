From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 21 Oct 2015 16:26:47 -0700
Subject: [Intel-wired-lan] [RFC Patch 00/12] IXGBE: Add live migration
	support for SRIOV NIC
In-Reply-To: <1445455227.4059.867.camel@redhat.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <CAJ3xEMiStMJdGjgO9=MQrhLpBo8ZiTRoOL_P=aC9kyrNi91FSw@mail.gmail.com>
 <1445455227.4059.867.camel@redhat.com>
Message-ID: <56281F37.1050506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/21/2015 12:20 PM, Alex Williamson wrote:
> On Wed, 2015-10-21 at 21:45 +0300, Or Gerlitz wrote:
>> On Wed, Oct 21, 2015 at 7:37 PM, Lan Tianyu <tianyu.lan@intel.com> wrote:
>>> This patchset is to propose a new solution to add live migration support
>>> for 82599 SRIOV network card.
>>
>>> In our solution, we prefer to put all device specific operation into VF and
>>> PF driver and make code in the Qemu more general.
>>
>> [...]
>>
>>> Service down time test
>>> So far, we tested migration between two laptops with 82599 nic which
>>> are connected to a gigabit switch. Ping VF in the 0.001s interval
>>> during migration on the host of source side. It service down
>>> time is about 180ms.
>>
>> So... what would you expect service down wise for the following
>> solution which is zero touch and I think should work for any VF
>> driver:
>>
>> on host A: unplug the VM and conduct live migration to host B ala the
>> no-SRIOV case.
>
> The trouble here is that the VF needs to be unplugged prior to the start
> of migration because we can't do effective dirty page tracking while the
> device is connected and doing DMA.  So the downtime, assuming we're
> counting only VF connectivity, is dependent on memory size, rate of
> dirtying, and network bandwidth; seconds for small guests, minutes or
> more (maybe much, much more) for large guests.

The question of dirty page tracking though should be pretty simple.  We 
start the Tx packets out as dirty so we don't need to add anything 
there.  It seems like the Rx data and Tx/Rx descriptor rings are the issue.

> This is why the typical VF agnostic approach here is to using bonding
> and fail over to a emulated device during migration, so performance
> suffers, but downtime is something acceptable.
>
> If we want the ability to defer the VF unplug until just before the
> final stages of the migration, we need the VF to participate in dirty
> page tracking.  Here it's done via an enlightened guest driver.  Alex
> Graf presented a solution using a device specific enlightenment in QEMU.
> Otherwise we'd need hardware support from the IOMMU.

My only real complaint with this patch series is that it seems like 
there was to much focus on instrumenting the driver instead of providing 
the code necessary to enable a driver ecosystem that enables migration.

I don't know if what we need is a full hardware IOMMU.  It seems like a 
good way to take care of the need to flag dirty pages for DMA capable 
devices would be to add functionality to the dma_map_ops calls 
sync_{sg|single}for_cpu and unmap_{page|sg} so that they would take care 
of mapping the pages as dirty for us when needed.  We could probably 
make do with just a few tweaks to existing API in order to make this work.

As far as the descriptor rings I would argue they are invalid as soon as 
we migrate.  The problem is there is no way to guarantee ordering as we 
cannot pre-emptively mark an Rx data buffer as being a dirty page when 
we haven't even looked at the Rx descriptor for the given buffer yet. 
Tx has similar issues as we cannot guarantee the Tx will disable itself 
after a complete frame.  As such I would say the moment we migrate we 
should just give up on the frames that are still in the descriptor 
rings, drop them, and then start over with fresh rings.

- Alex

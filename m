From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 21 Oct 2015 13:20:27 -0600
Subject: [Intel-wired-lan] [RFC Patch 00/12] IXGBE: Add live migration
 support for SRIOV NIC
In-Reply-To: <CAJ3xEMiStMJdGjgO9=MQrhLpBo8ZiTRoOL_P=aC9kyrNi91FSw@mail.gmail.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <CAJ3xEMiStMJdGjgO9=MQrhLpBo8ZiTRoOL_P=aC9kyrNi91FSw@mail.gmail.com>
Message-ID: <1445455227.4059.867.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-10-21 at 21:45 +0300, Or Gerlitz wrote:
> On Wed, Oct 21, 2015 at 7:37 PM, Lan Tianyu <tianyu.lan@intel.com> wrote:
> > This patchset is to propose a new solution to add live migration support
> > for 82599 SRIOV network card.
> 
> > In our solution, we prefer to put all device specific operation into VF and
> > PF driver and make code in the Qemu more general.
> 
> [...]
> 
> > Service down time test
> > So far, we tested migration between two laptops with 82599 nic which
> > are connected to a gigabit switch. Ping VF in the 0.001s interval
> > during migration on the host of source side. It service down
> > time is about 180ms.
> 
> So... what would you expect service down wise for the following
> solution which is zero touch and I think should work for any VF
> driver:
> 
> on host A: unplug the VM and conduct live migration to host B ala the
> no-SRIOV case.

The trouble here is that the VF needs to be unplugged prior to the start
of migration because we can't do effective dirty page tracking while the
device is connected and doing DMA.  So the downtime, assuming we're
counting only VF connectivity, is dependent on memory size, rate of
dirtying, and network bandwidth; seconds for small guests, minutes or
more (maybe much, much more) for large guests.

This is why the typical VF agnostic approach here is to using bonding
and fail over to a emulated device during migration, so performance
suffers, but downtime is something acceptable.

If we want the ability to defer the VF unplug until just before the
final stages of the migration, we need the VF to participate in dirty
page tracking.  Here it's done via an enlightened guest driver.  Alex
Graf presented a solution using a device specific enlightenment in QEMU.
Otherwise we'd need hardware support from the IOMMU.  Thanks,

Alex

> on host B:
> 
> when the VM "gets back to live", probe a VF there with the same assigned mac
> 
> next, udev on the VM will call the VF driver to create netdev instance
> 
> DHCP client would run to get the same IP address
> 
> + under config directive (or from Qemu) send Gratuitous ARP to notify
> the switch/es on the new location for that mac.
> 
> Or.
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




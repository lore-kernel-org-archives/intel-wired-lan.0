From: Leon Romanovsky <leon@kernel.org>
Date: Tue, 14 Sep 2021 06:10:07 +0300
Subject: [Intel-wired-lan] [PATCH RESEND net] ice: Correctly deal with
 PFs that do not support RDMA
In-Reply-To: <4bc2664ac89844a79242339f5e971335@intel.com>
References: <20210909151223.572918-1-david.m.ertman@intel.com>
 <YTsjDsFbBggL2X/8@unreal>
 <4bc2664ac89844a79242339f5e971335@intel.com>
Message-ID: <YUASj03w0RMunvCa@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 13, 2021 at 03:49:43PM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH RESEND net] ice: Correctly deal with PFs that do not
> > support RDMA
> > 
> > On Thu, Sep 09, 2021 at 08:12:23AM -0700, Dave Ertman wrote:
> > > There are two cases where the current PF does not support RDMA
> > > functionality.  The first is if the NVM loaded on the device is set to
> > > not support RDMA (common_caps.rdma is false).  The second is if the
> > > kernel bonding driver has included the current PF in an active link
> > > aggregate.
> > >
> > > When the driver has determined that this PF does not support RDMA,
> > > then auxiliary devices should not be created on the auxiliary bus.
> > 
> > This part is wrong, auxiliary devices should always be created, in your case it will
> > be one eth device only without extra irdma device.
> 
> It is worth considering having an eth aux device/driver but is it a hard-and-fast rule?
> In this case, the RDMA-capable PCI network device spawns an auxiliary device for RDMA
> and the core driver is a network driver.
> 
> > 
> > Your "bug" is that you mixed auxiliary bus devices with "regular" ones and created
> > eth device not as auxiliary one. This is why you are calling to auxiliary_device_init()
> > for RDMA only and fallback to non-auxiliary mode.
> 
> It's a design choice on how you carve out function(s) off your PCI core device to be
> managed by auxiliary driver(s) and not a bug.

I'm not the one who is setting rules, just explaining what is wrong with
the current design and proposed solution.

The driver/core design expects three building blocks: logic that
enumerates (creates) devices, bus that connects those devices
(load/unload drivers) and specific drivers for every such device.

Such separation allows clean view from locking perspective (separated
devices), proper sysfs layout and same logic for the user space tools.

In your case, you connected ethernet driver to be "enumerator" and
replaced (duplicated) general driver/core logic that decides if to load
or not auxiliary device driver with your custom code.

Thanks

> 
> Shiraz

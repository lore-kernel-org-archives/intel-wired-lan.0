From: Leon Romanovsky <leon@kernel.org>
Date: Tue, 14 Sep 2021 06:16:27 +0300
Subject: [Intel-wired-lan] [PATCH RESEND net] ice: Correctly deal with
 PFs that do not support RDMA
In-Reply-To: <PH0PR11MB49667F5B029D37D0E257A256DDD99@PH0PR11MB4966.namprd11.prod.outlook.com>
References: <20210909151223.572918-1-david.m.ertman@intel.com>
 <YTsjDsFbBggL2X/8@unreal>
 <4bc2664ac89844a79242339f5e971335@intel.com>
 <PH0PR11MB49667F5B029D37D0E257A256DDD99@PH0PR11MB4966.namprd11.prod.outlook.com>
Message-ID: <YUAUC1AJP6JVMxBr@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 13, 2021 at 04:07:28PM +0000, Ertman, David M wrote:
> > -----Original Message-----
> > From: Saleem, Shiraz <shiraz.saleem@intel.com>
> > Sent: Monday, September 13, 2021 8:50 AM
> > To: Leon Romanovsky <leon@kernel.org>; Ertman, David M
> > <david.m.ertman@intel.com>
> > Cc: davem at davemloft.net; kuba at kernel.org; yongxin.liu at windriver.com;
> > Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> > netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Brandeburg, Jesse
> > <jesse.brandeburg@intel.com>; intel-wired-lan at lists.osuosl.org; linux-
> > rdma at vger.kernel.org; jgg at ziepe.ca; Williams, Dan J
> > <dan.j.williams@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>;
> > Parikh, Neerav <neerav.parikh@intel.com>; Samudrala, Sridhar
> > <sridhar.samudrala@intel.com>
> > Subject: RE: [PATCH RESEND net] ice: Correctly deal with PFs that do not
> > support RDMA
> > 
> > > Subject: Re: [PATCH RESEND net] ice: Correctly deal with PFs that do not
> > > support RDMA
> > >
> > > On Thu, Sep 09, 2021 at 08:12:23AM -0700, Dave Ertman wrote:
> > > > There are two cases where the current PF does not support RDMA
> > > > functionality.  The first is if the NVM loaded on the device is set to
> > > > not support RDMA (common_caps.rdma is false).  The second is if the
> > > > kernel bonding driver has included the current PF in an active link
> > > > aggregate.
> > > >
> > > > When the driver has determined that this PF does not support RDMA,
> > > > then auxiliary devices should not be created on the auxiliary bus.
> > >
> > > This part is wrong, auxiliary devices should always be created, in your case it
> > will
> > > be one eth device only without extra irdma device.
> > 
> > It is worth considering having an eth aux device/driver but is it a hard-and-
> > fast rule?
> > In this case, the RDMA-capable PCI network device spawns an auxiliary
> > device for RDMA
> > and the core driver is a network driver.
> > 
> > >
> > > Your "bug" is that you mixed auxiliary bus devices with "regular" ones and
> > created
> > > eth device not as auxiliary one. This is why you are calling to
> > auxiliary_device_init()
> > > for RDMA only and fallback to non-auxiliary mode.
> > 
> > It's a design choice on how you carve out function(s) off your PCI core device
> > to be
> > managed by auxiliary driver(s) and not a bug.
> > 
> > Shiraz
> 
> Also, regardless of whether netdev functionality is carved out into an auxiliary device or not, this code would still be necessary.

Right

> 
> We don't want to carve out an auxiliary device to support a functionality that the base PCI device does not support.  Not having
> the RDMA auxiliary device for an auxiliary driver to bind to is how we differentiate between devices that support RDMA and those
> that don't.

This is right too.

My complain is that you mixed enumerator logic with eth driver and
create auxiliary bus only if your RDMA device exists. It is wrong.

Thanks

> 
> Thanks,
> DaveE
> 

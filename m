From: Saleem, Shiraz <shiraz.saleem@intel.com>
Date: Mon, 13 Sep 2021 15:49:43 +0000
Subject: [Intel-wired-lan] [PATCH RESEND net] ice: Correctly deal with
 PFs that do not support RDMA
In-Reply-To: <YTsjDsFbBggL2X/8@unreal>
References: <20210909151223.572918-1-david.m.ertman@intel.com>
 <YTsjDsFbBggL2X/8@unreal>
Message-ID: <4bc2664ac89844a79242339f5e971335@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Subject: Re: [PATCH RESEND net] ice: Correctly deal with PFs that do not
> support RDMA
> 
> On Thu, Sep 09, 2021 at 08:12:23AM -0700, Dave Ertman wrote:
> > There are two cases where the current PF does not support RDMA
> > functionality.  The first is if the NVM loaded on the device is set to
> > not support RDMA (common_caps.rdma is false).  The second is if the
> > kernel bonding driver has included the current PF in an active link
> > aggregate.
> >
> > When the driver has determined that this PF does not support RDMA,
> > then auxiliary devices should not be created on the auxiliary bus.
> 
> This part is wrong, auxiliary devices should always be created, in your case it will
> be one eth device only without extra irdma device.

It is worth considering having an eth aux device/driver but is it a hard-and-fast rule?
In this case, the RDMA-capable PCI network device spawns an auxiliary device for RDMA
and the core driver is a network driver.

> 
> Your "bug" is that you mixed auxiliary bus devices with "regular" ones and created
> eth device not as auxiliary one. This is why you are calling to auxiliary_device_init()
> for RDMA only and fallback to non-auxiliary mode.

It's a design choice on how you carve out function(s) off your PCI core device to be
managed by auxiliary driver(s) and not a bug.

Shiraz

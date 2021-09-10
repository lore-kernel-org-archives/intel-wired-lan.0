From: Leon Romanovsky <leon@kernel.org>
Date: Fri, 10 Sep 2021 12:19:10 +0300
Subject: [Intel-wired-lan] [PATCH RESEND net] ice: Correctly deal with
 PFs that do not support RDMA
In-Reply-To: <20210909151223.572918-1-david.m.ertman@intel.com>
References: <20210909151223.572918-1-david.m.ertman@intel.com>
Message-ID: <YTsjDsFbBggL2X/8@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 09, 2021 at 08:12:23AM -0700, Dave Ertman wrote:
> There are two cases where the current PF does not support RDMA
> functionality.  The first is if the NVM loaded on the device is set
> to not support RDMA (common_caps.rdma is false).  The second is if
> the kernel bonding driver has included the current PF in an active
> link aggregate.
> 
> When the driver has determined that this PF does not support RDMA, then
> auxiliary devices should not be created on the auxiliary bus. 

This part is wrong, auxiliary devices should always be created, in your case it
will be one eth device only without extra irdma device.

Your "bug" is that you mixed auxiliary bus devices with "regular" ones
and created eth device not as auxiliary one. This is why you are calling
to auxiliary_device_init() for RDMA only and fallback to non-auxiliary mode.

I hope that this is simple mistake while Intel folks rushed to merge irdma
and not deliberate decision to find a way to support out-of-tree drivers.

As a reminder, the whole idea of auxiliary bus is to have small,
independent vendor driver core logic that manages capabilities and
based on that creates/removes sub-devices (eth, rdma, vdpa ...), so
driver core can properly load/unload their respective drivers.

Thanks

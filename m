From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 9 Sep 2021 14:48:33 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: Correctly deal with PFs that
 do not support RDMA
In-Reply-To: <20210909085612.570229-1-david.m.ertman@intel.com>
References: <20210909085612.570229-1-david.m.ertman@intel.com>
Message-ID: <20210909144833.2ca0069d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu,  9 Sep 2021 01:56:12 -0700 Dave Ertman wrote:
> There are two cases where the current PF does not support RDMA
> functionality.  The first is if the NVM loaded on the device is set
> to not support RDMA (common_caps.rdma is false).  The second is if
> the kernel bonding driver has included the current PF in an active
> link aggregate.
> 
> When the driver has determined that this PF does not support RDMA, then
> auxiliary devices should not be created on the auxiliary bus.  Without
> a device on the auxiliary bus, even if the irdma driver is present, there
> will be no RDMA activity attempted on this PF.
> 
> Currently, in the reset flow, an attempt to create auxiliary devices is
> performed without regard to the ability of the PF.  There needs to be a
> check in ice_aux_plug_dev (as the central point that creates auxiliary
> devices) to see if the PF is in a state to support the functionality.
> 
> When disabling and re-enabling RDMA due to the inclusion/removal of the PF
> in a link aggregate, we also need to set/clear the bit which controls
> auxiliary device creation so that a reset recovery in a link aggregate
> situation doesn't try to create auxiliary devices when it shouldn't.
> 
> Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
> Reported-by: Yongxin Liu <yongxin.liu@windriver.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Why CC lkml but not CC RDMA or Leon?

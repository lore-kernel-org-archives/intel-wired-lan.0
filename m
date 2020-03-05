From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 5 Mar 2020 22:34:11 +0000
Subject: [Intel-wired-lan] [PATCH S34 v4 6/6] ice: Pass through
 communications to VF
In-Reply-To: <20200302233107.4691-6-anthony.l.nguyen@intel.com>
References: <20200302233107.4691-1-anthony.l.nguyen@intel.com>
 <20200302233107.4691-6-anthony.l.nguyen@intel.com>
Message-ID: <d46f8c4527334d28bef838e45633f2ea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, March 2, 2020 3:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S34 v4 6/6] ice: Pass through
> communications to VF
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Allow for forwarding of RDMA and VF virt channel messages. The driver will
> forward messages from the RDMA driver to the VF via the vc_send operation
> and invoke the peer's vc_receive() call when receiving a virt channel message
> destined for the peer driver.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 34 +++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 34 +++++++++++++++++++
>  3 files changed, 69 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



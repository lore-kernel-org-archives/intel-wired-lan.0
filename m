From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:36:11 +0000
Subject: [Intel-wired-lan] [PATCH S34 v3 6/6] ice: Pass through
 communications to VF
In-Reply-To: <20200121162021.17107-6-anthony.l.nguyen@intel.com>
References: <20200121162021.17107-1-anthony.l.nguyen@intel.com>
 <20200121162021.17107-6-anthony.l.nguyen@intel.com>
Message-ID: <47420ac4e8554b3595fc9c78a3bef3a3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, January 21, 2020 8:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S34 v3 6/6] ice: Pass through
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

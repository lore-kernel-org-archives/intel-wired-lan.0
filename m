From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:28:31 +0000
Subject: [Intel-wired-lan] [v4, 04/15] ice: Get switch config,
 scheduler config and device capabilities
In-Reply-To: <20180320145819.19133-5-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-5-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F099@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Anirudh Venkataramanan
> [mailto:anirudh.venkataramanan at intel.com]
> Sent: Tuesday, March 20, 2018 7:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [v4, 04/15] ice: Get switch config, scheduler config and device
> capabilities
> 
> This patch adds to the initialization flow by getting switch configuration,
> scheduler configuration and device capabilities.
> 
> Switch configuration:
> On boot, an L2 switch element is created in the firmware per physical
> function. Each physical function is also mapped to a port, to which its switch
> element is connected. In other words, this switch can be visualized as an
> embedded vSwitch that can connect a physical functions's virtual station
> interfaces (VSIs) to the egress/ingress port. Egress/ingress filters will be
> eventually created and applied on this switch element.
> As part of the initialization flow, the driver gets configuration data from this
> switch element and stores it.
> 
> Scheduler configuration:
> The Tx scheduler is a subsystem responsible for setting and enforcing QoS.
> As part of the initialization flow, the driver queries and stores the default
> scheduler configuration for the given physical function.
> 
> Device capabilities:
> As part of initialization, the driver has to determine what the device is
> capable of (ex. max queues, VSIs, etc). This information is obtained from the
> firmware and stored by the driver.
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile         |   4 +-
>  drivers/net/ethernet/intel/ice/ice.h            |   2 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 209 ++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 231 ++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |   2 +
>  drivers/net/ethernet/intel/ice/ice_sched.c      | 354
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_sched.h      |  42 +++
>  drivers/net/ethernet/intel/ice/ice_switch.c     | 158 +++++++++++
>  drivers/net/ethernet/intel/ice/ice_switch.h     |  28 ++
>  drivers/net/ethernet/intel/ice/ice_type.h       | 109 ++++++++
>  10 files changed, 1138 insertions(+), 1 deletion(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_sched.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_sched.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_switch.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_switch.h


Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>



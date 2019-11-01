From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:41:24 +0000
Subject: [Intel-wired-lan] [PATCH S32 02/15] ice: Add NDO callback to
 set the maximum per-queue bitrate
In-Reply-To: <20191025143441.50151-2-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
 <20191025143441.50151-2-anthony.l.nguyen@intel.com>
Message-ID: <a05f5a6f5ddc4086bfe4ddec4b011396@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 02/15] ice: Add NDO callback to set the
> maximum per-queue bitrate
> 
> From: Usha Ketineni <usha.k.ketineni@intel.com>
> 
> Allow for rate limiting Tx queues. Bitrate is set in
> Mbps(megabits per second).
> 
> Mbps max-rate is set for the queue via sysfs:
> /sys/class/net/<iface>/queues/tx-<queue>/tx_maxrate
> ex: echo 100 >/sys/class/net/ens7/queues/tx-0/tx_maxrate
>     echo 200 >/sys/class/net/ens7/queues/tx-1/tx_maxrate
> Note: A value of zero for tx_maxrate means disabled,
> default is disabled.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
> Co-developed-by: Tarun Singh <tarun.k.singh@intel.com>
> Signed-off-by: Tarun Singh <tarun.k.singh@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   46 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |   10 +-
>  drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   10 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |    8 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   43 +
>  drivers/net/ethernet/intel/ice/ice_sched.c    | 1264 ++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_sched.h    |   39 +
>  drivers/net/ethernet/intel/ice/ice_switch.h   |    5 -
>  drivers/net/ethernet/intel/ice/ice_type.h     |   63 +-
>  10 files changed, 1480 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



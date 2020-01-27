From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:15:28 +0000
Subject: [Intel-wired-lan] [PATCH S38 08/15] ice: Handle LAN overflow
 event for VF queues
In-Reply-To: <20200122152138.41585-8-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-8-anthony.l.nguyen@intel.com>
Message-ID: <dbd4d3b2d0db4bfca002c14264b8e30b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 08/15] ice: Handle LAN overflow event
> for VF queues
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we are not handling LAN overflow events. There can be cases
> where LAN overflow events occur on VF queues, especially with Link Flow
> Control (LFC) enabled on the controlling PF. In order to recover from the LAN
> overflow event caused by a VF we need to determine if the queue belongs
> to a VF and reset that VF accordingly.
> 
> The struct ice_aqc_event_lan_overflow returns a copy of the GLDCB_RTCTQ
> register, which tells us what the queue index is in the global/device space.
> The global queue index needs to first be converted to a PF space queue
> index and then it can be used to find if a VF owns it.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 11 ++++
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  3 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 66 +++++++++++++++++++
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  4 ++
>  5 files changed, 86 insertions(+)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



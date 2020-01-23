From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:34:47 +0000
Subject: [Intel-wired-lan] [PATCH S34 v3 3/6] ice: Support resource
 allocation requests
In-Reply-To: <20200121162021.17107-3-anthony.l.nguyen@intel.com>
References: <20200121162021.17107-1-anthony.l.nguyen@intel.com>
 <20200121162021.17107-3-anthony.l.nguyen@intel.com>
Message-ID: <d341592df961476cb181a4caec3045b9@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S34 v3 3/6] ice: Support resource allocation
> requests
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Enable the peer device to request queue sets from the PF.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  32 +++
>  drivers/net/ethernet/intel/ice/ice_common.c   | 188 ++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   9 +
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 244 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  69 ++++-
>  drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
>  9 files changed, 547 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



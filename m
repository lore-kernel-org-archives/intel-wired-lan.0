From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 5 Mar 2020 22:32:34 +0000
Subject: [Intel-wired-lan] [PATCH S34 v4 2/6] ice: Complete RDMA peer
 registration
In-Reply-To: <20200302233107.4691-2-anthony.l.nguyen@intel.com>
References: <20200302233107.4691-1-anthony.l.nguyen@intel.com>
 <20200302233107.4691-2-anthony.l.nguyen@intel.com>
Message-ID: <17944530967c417b856bc2c918c066b6@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S34 v4 2/6] ice: Complete RDMA peer
> registration
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Ensure that the peer supports the minimal set of operations required for
> operation and, if so, open the connection to the peer.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 288 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h  |  36 +++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  33 ++
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  23 ++
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   2 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  25 --
>  8 files changed, 401 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



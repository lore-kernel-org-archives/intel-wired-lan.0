From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:34:19 +0000
Subject: [Intel-wired-lan] [PATCH S34 v3 2/6] ice: Complete RDMA peer
 registration
In-Reply-To: <20200121162021.17107-2-anthony.l.nguyen@intel.com>
References: <20200121162021.17107-1-anthony.l.nguyen@intel.com>
 <20200121162021.17107-2-anthony.l.nguyen@intel.com>
Message-ID: <c5520c4c74bf4970b820af4deb9da291@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S34 v3 2/6] ice: Complete RDMA peer
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



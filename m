From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:05:10 +0000
Subject: [Intel-wired-lan] [PATCH S40 04/15] ice: Add support for tunnel
 offloads
In-Reply-To: <20200227181505.61720-4-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-4-anthony.l.nguyen@intel.com>
Message-ID: <89b9213b46264fe0b578b1b4b675af50@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 04/15] ice: Add support for tunnel
> offloads
> 
> Create a boost TCAM entry for each tunnel port in order to get a tunnel
> PTYPE. Update netdev feature flags and implement the appropriate logic to
> get and set values for hardware offloads.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   4 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 477 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |   5 +
>  .../net/ethernet/intel/ice/ice_flex_type.h    |  32 ++
>  drivers/net/ethernet/intel/ice/ice_flow.c     |  36 +-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |   3 +
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  25 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  98 +++-
>  .../ethernet/intel/ice/ice_protocol_type.h    |   1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 126 ++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   3 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  21 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
>  13 files changed, 820 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



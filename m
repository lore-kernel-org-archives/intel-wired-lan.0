From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:09:40 +0000
Subject: [Intel-wired-lan] [PATCH S36 2/8] ice: Allocate flow profile
In-Reply-To: <20200117153919.50321-2-anthony.l.nguyen@intel.com>
References: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
 <20200117153919.50321-2-anthony.l.nguyen@intel.com>
Message-ID: <f3be0d450d33416a8c97d91c965680f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, January 17, 2020 7:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S36 2/8] ice: Allocate flow profile
> 
> Create an extraction sequence based on the packet header protocols to be
> programmed and allocate a flow profile for the extraction sequence.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   6 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  75 +++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   6 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 216 ++++++++
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |   3 +
>  .../net/ethernet/intel/ice/ice_flex_type.h    |  15 +
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 490 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  23 +
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   8 +
>  .../ethernet/intel/ice/ice_protocol_type.h    |  24 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  36 --
>  drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
>  12 files changed, 864 insertions(+), 40 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_protocol_type.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



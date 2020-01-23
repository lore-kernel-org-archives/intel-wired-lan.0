From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:35:40 +0000
Subject: [Intel-wired-lan] [PATCH S34 v3 5/6] ice: Allow reset operations
In-Reply-To: <20200121162021.17107-5-anthony.l.nguyen@intel.com>
References: <20200121162021.17107-1-anthony.l.nguyen@intel.com>
 <20200121162021.17107-5-anthony.l.nguyen@intel.com>
Message-ID: <ca3f53494e45450d9efd338c2b9a57c0@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S34 v3 5/6] ice: Allow reset operations
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Enable the PF to notify peers when it's going to reset so that peer devices
> can prepare accordingly. Also enable the peer devices to request the PF to
> reset.
> 
> Implement ice_peer_is_vsi_ready() so the peer device can determine when
> the VSI is ready for operations following a reset.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_idc.c     | 140 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h |   1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c     |   6 +
>  drivers/net/ethernet/intel/ice/ice_main.c    |   3 +
>  4 files changed, 150 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:42:57 +0000
Subject: [Intel-wired-lan] [PATCH S32 06/15] ice: configure software
 LLDP in ice_init_pf_dcb
In-Reply-To: <20191025143441.50151-6-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
 <20191025143441.50151-6-anthony.l.nguyen@intel.com>
Message-ID: <5728bdfd6a5848488160ed1109a190dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 06/15] ice: configure software LLDP in
> ice_init_pf_dcb
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Move software LLDP configuration when FW DCBX is disabled to
> ice_init_pf_dcb, since that is where the FW DCBX state is determined.
> Remove this software LLDP configuration from ice_vsi_setup and
> ice_set_priv_flags. Software configuration includes redirecting Rx LLDP
> packets up the stack, when FW DCBX is not running.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 15 +++++++++++++++
> drivers/net/ethernet/intel/ice/ice_ethtool.c |  5 -----
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 14 ++++----------
>  3 files changed, 19 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



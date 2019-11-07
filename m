From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:37:23 +0000
Subject: [Intel-wired-lan] [PATCH S32 v3 06/15] ice: configure software
 LLDP in ice_init_pf_dcb
In-Reply-To: <20191106100541.48639-6-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
 <20191106100541.48639-6-anthony.l.nguyen@intel.com>
Message-ID: <9b564e74c77446c7b06e035731a2905d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 6, 2019 2:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 v3 06/15] ice: configure software LLDP
> in ice_init_pf_dcb
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



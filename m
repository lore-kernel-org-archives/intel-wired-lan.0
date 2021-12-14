From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 14 Dec 2021 04:31:55 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 06/14] ice: Use the proto
 argument for VLAN ops
In-Reply-To: <20211202163852.36436-6-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-6-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB336760BBC7CA20951578B575FC759@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Thursday, December 2, 2021 10:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 06/14] ice: Use the proto
> argument for VLAN ops
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the proto argument is unused. This is because the driver only
> supports 802.1Q VLAN filtering. This policy is enforced via netdev features that
> the driver sets up when configuring the netdev, so the proto argument won't
> ever be anything other than 802.1Q. However, this will allow for future
> iterations of the driver to seemlessly support 802.1ad filtering. Begin using the
> proto argument and extend the related structures to support its use.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fltr.c     |  2 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++-----
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  5 ++
>  drivers/net/ethernet/intel/ice/ice_switch.h   |  2 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 10 ++--
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  2 +-
>  drivers/net/ethernet/intel/ice/ice_vlan.h     |  3 +-
>  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 48 ++++++++++++++++++-
> .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |  4 +-
> .../net/ethernet/intel/ice/ice_vsi_vlan_ops.h |  4 +-
>  11 files changed, 78 insertions(+), 26 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)

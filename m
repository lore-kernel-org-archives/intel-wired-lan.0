From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 24 Dec 2021 09:33:50 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 05/14] ice: Refactor
 vf->port_vlan_info to use ice_vlan
In-Reply-To: <20211202163852.36436-5-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-5-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB336703E61D0C7B43FFA4B988FC7F9@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 05/14] ice: Refactor vf-
> >port_vlan_info to use ice_vlan
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> The current vf->port_vlan_info variable is a packed u16 that contains the port
> VLAN ID and QoS/prio value. This is fine, but changes are incoming that allow
> for an 802.1ad port VLAN. Add flexibility by changing the vf->port_vlan_info
> member to be an ice_vlan structure.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 76 ++++++++++---------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  3 +-
>  2 files changed, 44 insertions(+), 35 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)

From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 17 Jan 2022 20:31:23 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 13/14] ice: Add support
 for 802.1ad port VLANs VF
In-Reply-To: <20211202163852.36436-13-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-13-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB5621B2AD262C1A5EB6960790AB579@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: czwartek, 2 grudnia 2021 17:39
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 13/14] ice: Add support for
> 802.1ad port VLANs VF
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently there is only support for 802.1Q port VLANs on SR-IOV VFs. Add
> support to also allow 802.1ad port VLANs when double VLAN mode is
> enabled.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 51 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index de74a2b4f846..f1802de98b82 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -768,6 +768,11 @@ bool ice_vf_is_port_vlan_ena(struct ice_vf *vf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

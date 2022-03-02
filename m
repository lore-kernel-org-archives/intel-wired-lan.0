From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:02:20 +0000
Subject: [Intel-wired-lan] [net-next PATCH 08/25] ice: move
 ice_set_vf_port_vlan near other .ndo ops
In-Reply-To: <20220223002712.2771809-9-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-9-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629923F216DDA675D97B003AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 23, 2022 1:27 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH 08/25] ice: move
> ice_set_vf_port_vlan near other .ndo ops
> 
> The ice_set_vf_port_vlan function is located in ice_sriov.c very far away from
> the other .ndo operations that it is similar to. Move this so that its located
> near the other .ndo operation definitions.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 192 ++++++++++-----------
>  1 file changed, 96 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 8d22b5d94706..eebff1824be2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -4249,102 +4249,6 @@ static int ice_vc_request_qs_msg(struct ice_vf

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

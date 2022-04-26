From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 26 Apr 2022 05:50:22 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/6] ice: always check VF VSI
 pointer values
In-Reply-To: <20220411232907.1022602-3-jacob.e.keller@intel.com>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
 <20220411232907.1022602-3-jacob.e.keller@intel.com>
Message-ID: <DM8PR11MB5621223FB2D965FFCFB0F9B7ABFB9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Tuesday, April 12, 2022 1:29 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH net-next 2/6] ice: always check VF VSI
> pointer values
> 
> The ice_get_vf_vsi function can return NULL in some cases, such as if
> handling messages during a reset where the VSI is being removed and
> recreated.
> 
> Several places throughout the driver do not bother to check whether this VSI
> pointer is valid. Static analysis tools maybe report issues because they detect
> paths where a potentially NULL pointer could be dereferenced.
> 
> Fix this by checking the return value of ice_get_vf_vsi everywhere.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c  |  5 ++-
>  drivers/net/ethernet/intel/ice/ice_repr.c     |  7 +++-
>  drivers/net/ethernet/intel/ice/ice_sriov.c    | 32 +++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 28 +++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c |  5 +++
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  7 +++-
>  6 files changed, 77 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c
> b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index a230edb38466..4a9de59121d8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -753,9 +753,12 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> 
>  	pf = vf->pf;
>  	dev = ice_pf_to_dev(pf);
> -	vsi = ice_get_vf_vsi(vf);
>  	devlink_port = &vf->devlink_port;
> 
> +	vsi = ice_get_vf_vsi(vf);
> +	if (!vsi)
> +		return -EINVAL;
> +
>  	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
>  	attrs.pci_vf.pf = pf->hw.bus.func;
>  	attrs.pci_vf.vf = vf->vf_id;
> diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c
> b/drivers/net/ethernet/intel/ice/ice_repr.c
> index 848f2adea563..a91b81c3088b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_repr.c
> +++ b/drivers/net/ethernet/intel/ice/ice_repr.c
> @@ -293,8 +293,13 @@ static int ice_repr_add(struct ice_vf *vf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

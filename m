From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 8 Dec 2021 08:05:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 4/6] iavf: Add support for
 VIRTCHNL_VF_OFFLOAD_VLAN_V2 hotpath
In-Reply-To: <20211130001604.22112-5-anthony.l.nguyen@intel.com>
References: <20211130001604.22112-1-anthony.l.nguyen@intel.com>
 <20211130001604.22112-5-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB56212CAD9F53FCF8F0CF059BAB6F9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: wtorek, 30 listopada 2021 01:16
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 4/6] iavf: Add support for
> VIRTCHNL_VF_OFFLOAD_VLAN_V2 hotpath
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> The new VIRTCHNL_VF_OFFLOAD_VLAN_V2 capability added support that
> allows the PF to set the location of the Tx and Rx VLAN tag for insertion and
> stripping offloads. In order to support this functionality a few changes are
> needed.
> 
> 1. Add a new method to cache the VLAN tag location based on negotiated
>    capabilities for the Tx and Rx ring flags. This needs to be called in
>    the initialization and reset paths.
> 
> 2. Refactor the transmit hotpath to account for the new Tx ring flags.
>    When IAVF_TXR_FLAGS_VLAN_LOC_L2TAG2 is set, then the driver needs
> to
>    insert the VLAN tag in the L2TAG2 field of the transmit descriptor.
>    When the IAVF_TXRX_FLAGS_VLAN_LOC_L2TAG1 is set, then the driver
> needs
>    to use the l2tag1 field of the data descriptor (same behavior as
>    before).
> 
> 3. Refactor the iavf_tx_prepare_vlan_flags() function to simplify
>    transmit hardware VLAN offload functionality by only depending on the
>    skb_vlan_tag_present() function. This can be done because the OS
>    won't request transmit offload for a VLAN unless the driver told the
>    OS it's supported and enabled.
> 
> 4. Refactor the receive hotpath to account for the new Rx ring flags and
>    VLAN ethertypes. This requires checking the Rx ring flags and
>    descriptor status bits to determine the location of the VLAN tag.
>    Also, since only a single ethertype can be supported at a time, check
>    the enabled netdev features before specifying a VLAN ethertype in
>    __vlan_hwaccel_put_tag().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  1 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 82 +++++++++++++++++++
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 71 ++++++++--------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.h   | 30 ++++---
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  2 +
>  5 files changed, 135 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 5fb6ebf9a760..2660d46da1b5 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -488,6 +488,7 @@ int iavf_send_vf_config_msg(struct iavf_adapter

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

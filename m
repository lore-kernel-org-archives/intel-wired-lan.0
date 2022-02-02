From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Feb 2022 08:50:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: refactor processing
 of VLAN V2 capability message
In-Reply-To: <20220114093636.20848-1-mateusz.palczewski@intel.com>
References: <20220114093636.20848-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB56217DB78B39BAECE7B8C510AB279@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Friday, January 14, 2022 10:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: refactor processing of
> VLAN V2 capability message
> 
> In order to handle the capability exchange necessary for
> VIRTCHNL_VF_OFFLOAD_VLAN_V2, the driver must send a
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS message. This must occur
> prior to __IAVF_CONFIG_ADAPTER, and the driver must wait for the
> response from the PF.
> 
> To handle this, the __IAVF_INIT_GET_OFFLOAD_VLAN_V2_CAPS state was
> introduced. This state is intended to process the response from the VLAN
> V2 caps message. This works ok, but is difficult to extend to adding more
> extended capability exchange.
> 
> Existing (and future) AVF features are relying more and more on these sort
> of extended ops for processing additional capabilities. Just like VLAN V2, this
> exchange must happen prior to __IAVF_CONFIG_ADPATER.
> 
> Since we only send one outstanding AQ message at a time during init, it is not
> clear where to place this state. Adding more capability specific states
> becomes a mess. Instead of having the "previous" state send a message and
> then transition into a capability-specific state, introduce
> __IAVF_EXTENDED_CAPS state. This state will use a list of extended_caps
> that determines what messages to send and receive. As long as there are
> extended_caps bits still set, the driver will remain in this state performing
> one send or one receive per state machine loop.
> 
> Refactor the VLAN V2 negotiation to use this new state, and remove the
> capability-specific state. This makes it significantly easier to add a new similar
> capability exchange going forward.
> 
> Extended capabilities are processed by having an associated SEND and RECV
> extended capability bit. During __IAVF_EXTENDED_CAPS, the driver checks
> these bits in order by feature, first the send bit for a feature, then the recv
> bit for a feature. Each send flag will call a function that sends the necessary
> response, while each receive flag will wait for the response from the PF. If a
> given feature can't be negotiated with the PF, the associated flags will be
> cleared in order to skip processing of that feature.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      |  17 ++-
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 109 ++++++++++++++------
>  2 files changed, 95 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 59806d1..16cd06f 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 18 Jan 2022 18:10:50 +0000
Subject: [Intel-wired-lan] [PATCH net v3] iavf: Fix promiscuous mode
 configuration flow messages
In-Reply-To: <20211208092859.1876593-1-karen.sornek@intel.com>
References: <20211208092859.1876593-1-karen.sornek@intel.com>
Message-ID: <DM8PR11MB5621C55A3A72E439B83B2774AB589@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sornek, Karen
> Sent: ?roda, 8 grudnia 2021 10:29
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v3] iavf: Fix promiscuous mode
> configuration flow messages
> 
> From: Karen Sornek <karen.sornek@intel.com>
> 
> Currently when configuring promiscuous mode on the AVF we detect a
> change in the netdev->flags. We use IFF_PROMISC and IFF_ALLMULTI to
> determine whether or not we need to request/release promiscuous mode
> and/or multicast promiscuous mode. The problem is that the AQ calls for
> setting/clearing promiscuous/multicast mode are treated separately. This
> leads to a case where we can trigger two promiscuous mode AQ calls in a row
> with the incorrect state. To fix this make a few changes.
> 
> Use IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE instead of the previous
> IAVF_FLAG_AQ_[REQUEST|RELEASE]_[PROMISC|ALLMULTI] flags.
> 
> In iavf_set_rx_mode() detect if there is a change in the
> netdev->flags in comparison with adapter->flags and set the
> IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE aq_required bit. Then in
> iavf_process_aq_command() only check for
> IAVF_FLAG_CONFIGURE_PROMISC_MODE and call iavf_set_promiscuous()
> if it's set.
> 
> In iavf_set_promiscuous() check again to see which (if any) promiscuous
> mode bits have changed when comparing the netdev->flags with the
> adapter->flags. Use this to set the flags which get sent to the PF driver.
> 
> Add a spinlock that is used for updating current_netdev_promisc_flags and
> only allows one promiscuous mode AQ at a time.
> 
> [1] Fixes the fact that we will only have one AQ call in the aq_required queue
> at any one time.
> 
> [2] Streamlines the change in promiscuous mode to only set one AQ required
> bit.
> 
> [3] This allows us to keep track of the current state of the flags and also
> makes it so we can take the most recent netdev->flags promiscuous mode
> state.
> 
> [4] This fixes the problem where a change in the netdev->flags can cause
> IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE to be set in
> iavf_set_rx_mode(), but cleared in iavf_set_promiscuous() before the
> change is ever made via AQ call.
> 
> Fixes: 47d3483988f6 ("i40evf: Add driver support for promiscuous mode")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
> v3: Previous version had applying issue
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        | 16 +++--
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 45 +++++--------
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 66 ++++++++++++++-----
>  3 files changed, 75 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 4d62231ec6b5..14e120a82b1c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

I am not able to force the promiscuous message correctly

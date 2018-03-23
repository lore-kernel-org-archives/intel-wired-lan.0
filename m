From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:47:35 +0000
Subject: [Intel-wired-lan] [v4,
 08/15] ice: Add support for switch filter programming
In-Reply-To: <20180320145819.19133-9-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-9-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F152@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Anirudh Venkataramanan
> [mailto:anirudh.venkataramanan at intel.com]
> Sent: Tuesday, March 20, 2018 7:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [v4,08/15] ice: Add support for switch filter programming
> 
> A VSI needs traffic directed towards it. This is done by programming
> filter rules on the switch (embedded vSwitch) element in the hardware,
> which connects the VSI to the ingress/egress port.
> 
> This patch introduces data structures and functions necessary to add
> remove or update switch rules on the switch element. This is a pretty low
> level function that is generic enough to add a whole range of filters.
> 
> This patch also introduces two top level functions ice_add_mac and
> ice_remove mac which through a series of intermediate helper functions
> eventually call ice_aq_sw_rules to add/delete simple MAC based filters.
> It's worth noting that one invocation of ice_add_mac/ice_remove_mac
> is capable of adding/deleting multiple MAC filters.
> 
> Also worth noting is the fact that the driver maintains a list of currently
> active filters, so every filter addition/removal causes an update to this
> list. This is done for a couple of reasons:
> 
> 1) If two VSIs try to add the same filters, we need to detect it and do
>    things a little differently (i.e. use VSI lists, described below) as
>    the same filter can't be added more than once.
> 
> 2) In the event of a hardware reset we can simply walk through this list
>    and restore the filters.
> 
> VSI Lists:
> In a multi-VSI situation, it's possible that multiple VSIs want to add the
> same filter rule. For example, two VSIs that want to receive broadcast
> traffic would both add a filter for destination MAC ff:ff:ff:ff:ff:ff.
> This can become cumbersome to maintain and so this is handled using a
> VSI list.
> 
> A VSI list is resource that can be allocated in the hardware using the
> ice_aq_alloc_free_res admin queue command. Simply put, a VSI list can
> be thought of as a subscription list containing a set of VSIs to which
> the packet should be forwarded, should the filter match.
> 
> For example, if VSI-0 has already added a broadcast filter, and VSI-1
> wants to do the same thing, the filter creation flow will detect this,
> allocate a VSI list and update the switch rule so that broadcast traffic
> will now be forwarded to the VSI list which contains VSI-0 and VSI-1.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  249 ++++
>  drivers/net/ethernet/intel/ice/ice_common.c     |   74 +-
>  drivers/net/ethernet/intel/ice/ice_main.c       |   92 ++
>  drivers/net/ethernet/intel/ice/ice_status.h     |    3 +
>  drivers/net/ethernet/intel/ice/ice_switch.c     | 1378
> +++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_switch.h     |  120 ++
>  drivers/net/ethernet/intel/ice/ice_type.h       |   21 +
>  7 files changed, 1935 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>



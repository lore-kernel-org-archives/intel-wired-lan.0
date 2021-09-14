From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 14 Sep 2021 23:50:32 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix promiscuous mode
 configuration flow messages
In-Reply-To: <20210914064346.3376-1-karen.sornek@intel.com>
References: <20210914064346.3376-1-karen.sornek@intel.com>
Message-ID: <6ee88bc8f34dedbddd528272f67704f2d62e49a3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-09-14 at 08:43 +0200, Karen Sornek wrote:
> Currently when configuring promiscuous mode on the AVF we detect a
> change in the netdev->flags. We use IFF_PROMISC and IFF_ALLMULTI to
> determine whether or not we need to request/release promiscuous mode
> and/or multicast promiscuous mode. The problem is that the AQ calls
> for
> setting/clearing promiscuous/multicast mode are treated separately.
> This
> leads to a case where we can trigger two promiscuous mode AQ calls in
> a row with the incorrect state. To fix this make a few changes.
> 
> Use IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE instead of the previous
> IAVF_FLAG_AQ_[REQUEST|RELEASE]_[PROMISC|ALLMULTI] flags.
> 
> In iavf_set_rx_mode() detect if there is a change in the
> netdev->flags in comparison with adapter->flags and set the
> IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE aq_required bit. Then in
> iavf_process_aq_command() only check for
> IAVF_FLAG_CONFIGURE_PROMISC_MODE
> and call iavf_set_promiscuous() if it's set.
> 
> In iavf_set_promiscuous() check again to see which (if any)
> promiscuous mode bits have changed when comparing the netdev->flags
> with
> the adapter->flags. Use this to set the flags which get sent to the
> PF
> driver.
> 
> Add a spinlock that is used for updating current_netdev_promisc_flags
> and only allows one promiscuous mode AQ at a time.
> 
> [1] Fixes the fact that we will only have one AQ call in the
> aq_required
> queue at any one time.
> 
> [2] Streamlines the change in promiscuous mode to only set one AQ
> required bit.
> 
> [3] This allows us to keep track of the current state of the flags
> and
> also makes it so we can take the most recent netdev->flags
> promiscuous
> mode state.
> 
> [4] This fixes the problem where a change in the netdev->flags can
> cause
> IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE to be set in iavf_set_rx_mode(),
> but cleared in iavf_set_promiscuous() before the change is ever made
> via
> AQ call.


This patch still doesn't apply.

Were there any changes made or is this a resend of the same patch[1]?
Please include proper tags, revisions, and/or changelogs to make
reviews easier.

> Fixes: 129cf89e5856 ("iavf: rename functions and structs to new
> name")
> Signed-off-by: Brett Creeley brett.creeley at intel.com
> Signed-off-by: Karen Sornek karen.sornek at intel.com
> 
[1] https://patchwork.ozlabs.org/project/intel-wired-
lan/patch/20210902124436.162039-1-karen.sornek at intel.com/

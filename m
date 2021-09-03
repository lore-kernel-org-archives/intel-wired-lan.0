From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 3 Sep 2021 15:06:52 -0700
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: add support for
 reading SyncE DPLL state
In-Reply-To: <20210903151436.529478-3-maciej.machnikowski@intel.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <20210903151436.529478-3-maciej.machnikowski@intel.com>
Message-ID: <20210903150652.6e763cb6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri,  3 Sep 2021 17:14:36 +0200 Maciej Machnikowski wrote:
> Implement SyncE DPLL monitoring for E810-T devices.
> Poll loop will periodically check the state of the DPLL and cache it
> in the pf structure. State changes will be logged in the system log.
> 
> Cached state can be read using the RTM_GETEECSTATE rtnetlink
> message.
> 
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>

kdoc issues here:

drivers/net/ethernet/intel/ice/ice_main.c:5990: warning: Function parameter or member 'eec_flags' not described in 'ice_get_eec_state'
drivers/net/ethernet/intel/ice/ice_main.c:5990: warning: Function parameter or member 'extack' not described in 'ice_get_eec_state'
drivers/net/ethernet/intel/ice/ice_main.c:5990: warning: Excess function parameter 'sync_src' description in 'ice_get_eec_state'

./scripts/kernel-doc -none and/or W=1 is your friend.

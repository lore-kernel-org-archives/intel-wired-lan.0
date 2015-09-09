From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 16:43:10 +0000
Subject: [Intel-wired-lan] [next PATCH S11 14/15] i40e/i40evf: fix
 unicast	mac address add
In-Reply-To: <1440616461-110869-15-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-15-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5CC0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 14/15] i40e/i40evf: fix unicast mac
> address add
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> When using something like "ip maddr add ..." to add another unicast mac
> address to the netdev, the mac address comes into the set_rx_mode
> handler in the multicast list whether it is a unicast or multicast address.
> This was confusing the code when it was trying to search for addresses that
> needed to be deleted from the VSI, because it was looking for the VSI
> unicast address in the netdev unicast list.  The result was that a new unicast
> address would get added to the VSI list and then immediately removed, and
> would never actually make it down into the hardware.
> 
> This patch removes the separation from unicast and multicast in the search
> for filters to be deleted.  It also simplifies the logic a little with a jump to the
> bottom of the loop when an address is found.  Now it doesn't matter which
> netdev list the address is hiding in, we'll check them all.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ie3685a92427ae7d2212bf948919ce295bc7a874c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 41 +++++++++-------------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 45 ++++++++++++--------
> -----
>  2 files changed, 38 insertions(+), 48 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree

From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 31 Aug 2017 18:59:14 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 01/13] i40e: add private
 flag	to control source pruning
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA94D0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Williams, Mitch A <mitch.a.williams@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S79-V2 01/13] i40e: add private flag to
> control source pruning
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> By default, our devices do source pruning, that is, they drop receive packets
> that have the source MAC matching one of the receive filters.
> Unfortunately, this breaks ARP monitoring in channel bonding, as the
> bonding driver expects devices to receive ARPs containing their own source
> address.
> 
> Add an ethtool private flag to control this feature.
> 
> Also, remove the netif_running() check when we process our private flags.
> It's OK to reset when the device is closed and in most cases we need the
> reset the apply these changes.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  7 +++++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 25
> +++++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



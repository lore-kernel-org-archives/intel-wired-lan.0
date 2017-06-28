From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Jun 2017 22:44:07 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 02/10] i40e/i40evf:
	adjust	packet size to account for double VLANs
In-Reply-To: <20170623082451.32671-2-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC048@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, June 23, 2017 1:25 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S74-V2 02/10] i40e/i40evf: adjust
> packet size to account for double VLANs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Now that the kernel supports double VLAN tags, we should at least play nice.
> Adjust the max packet size to account for two VLAN tags, not just one.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
>  4 files changed, 6 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



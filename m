From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 15 Jun 2017 23:40:47 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] ixgbe: Enable LASI interrupts
	for	X552 devices
In-Reply-To: <20170607213621.18256-2-anthony.l.nguyen@intel.com>
References: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
 <20170607213621.18256-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB289@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 7, 2017 2:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/5] ixgbe: Enable LASI interrupts for X552
> devices
> 
> Enable LASI interrupts on X552 devices in order to receive notifications of link
> configurations of the external PHY and support the configuration of the
> internal iXFI link since iXFI does not support auto-negotiation.  This is not
> required for X553 devices; add a check to avoid enabling LASI interrupts for
> X553 devices.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 31
> +++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 29 Mar 2016 18:17:26 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for single-port
 X550	device
In-Reply-To: <20160321182131.33845.74687.stgit@mdrustad-wks.jf.intel.com>
References: <20160321182131.33845.74687.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99F722@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Monday, March 21, 2016 11:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for single-port X550
> device
> 
> Add support for a single-port X550 device.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |    2 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |    1 +
>  3 files changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver correctly recognizes single-port X550

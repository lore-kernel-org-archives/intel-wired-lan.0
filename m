From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Jun 2018 16:23:54 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Do not allow LRO or MTU change
 with XDP
In-Reply-To: <20180530231423.28864-1-anthony.l.nguyen@intel.com>
References: <20180530231423.28864-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C631F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, May 30, 2018 4:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Do not allow LRO or MTU change
> with XDP
> 
> XDP does not support jumbo frames or LRO.  These checks are being made
> outside the driver when an XDP program is loaded, however, there is nothing
> preventing these from changing after an XDP program is loaded.
> Add the checks so that while an XDP program is loaded, do not allow MTU to
> be changed or LRO to be enabled.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



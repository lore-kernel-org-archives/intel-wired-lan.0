From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Jun 2017 19:15:04 +0000
Subject: [Intel-wired-lan] [PATCH 5/5] ixgbe: Disable flow control for
 XFI
In-Reply-To: <20170607213621.18256-5-anthony.l.nguyen@intel.com>
References: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
 <20170607213621.18256-5-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAABCC@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 5/5] ixgbe: Disable flow control for XFI
> 
> Flow control autonegotiation is not supported for XFI.  Make sure that
> ixgbe_device_supports_autoneg_fc() returns false and
> hw->fc.disable_fc_autoneg is set to true to avoid running the fc_autoneg
> function for that device.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |  5 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   | 57 ++++++++++++++------
> -----
>  2 files changed, 35 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



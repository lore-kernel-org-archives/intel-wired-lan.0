From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 1 Jun 2016 21:14:31 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct reporting of
 timestamping	for x550
In-Reply-To: <1464799843-2589-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1464799843-2589-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E2FDB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 01, 2016 9:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct reporting of timestamping
> for x550
> 
> Update ixgbe_ethtool_get_ts_info() to show that x550 supports hardware
> timestamping of all packets.
> 
> Reported-by: Guy Harris <guy@alum.mit.edu>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethtool correctly reports hardware timestamping capabilities of the device

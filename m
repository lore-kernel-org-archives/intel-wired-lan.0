From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 30 Jan 2019 19:40:18 +0000
Subject: [Intel-wired-lan] [net] ixgbe: fix older devices that do not
 support IXGBE_MRQC_L3L4TXSWEN
In-Reply-To: <20190128174501.26421-1-jeffrey.t.kirsher@intel.com>
References: <20190128174501.26421-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D35400C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, January 28, 2019 9:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net] ixgbe: fix older devices that do not support
> IXGBE_MRQC_L3L4TXSWEN
> 
> The enabling L3/L4 filtering for transmit switched packets for all devices
> caused unforeseen issue on older devices when trying to send UDP traffic in
> an ordered sequence.  This bit was originally intended for X550 devices,
> which supported this feature, so limit the scope of this bit to only X550
> devices.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



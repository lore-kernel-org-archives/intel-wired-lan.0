From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 10 Apr 2017 21:39:50 +0000
Subject: [Intel-wired-lan] [PATCH] net: i40evf: Use net_device_stats
 from	struct net_device
In-Reply-To: <20170406064628.13459-1-tklauser@distanz.ch>
References: <20170406064628.13459-1-tklauser@distanz.ch>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B52A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tobias Klauser
> Sent: Wednesday, April 5, 2017 11:46 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] net: i40evf: Use net_device_stats from
> struct net_device
> 
> Instead of using a private copy of struct net_device_stats in struct
> i40evf_adapter, use stats from struct net_device. Also remove the now
> unnecessary .ndo_get_stats function.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 -
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 16 ----------------
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 22 +++++++++++-----------
>  3 files changed, 11 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



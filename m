From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Aug 2018 16:50:54 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: report correct statistics when
 XDP is enabled
In-Reply-To: <20180824112159.32298-1-bjorn.topel@intel.com>
References: <20180824112159.32298-1-bjorn.topel@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EAFAD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bj?rn T?pel
> Sent: Friday, August 24, 2018 4:22 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: brouer at redhat.com; Topel, Bjorn <bjorn.topel@intel.com>;
> magnus.karlsson at gmail.com; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: report correct statistics when XDP is
> enabled
> 
> When XDP is enabled, the driver will report incorrect statistics. Received
> frames will reported as transmitted frames.
> 
> This commits fixes the i40e implementation of ndo_get_stats64 (struct
> net_device_ops), so that iproute2 will report correct statistics (e.g. when
> running "ip -stats link show dev eth0") even when XDP is enabled.
> 
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++++++----------
>  1 file changed, 13 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


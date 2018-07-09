From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Jul 2018 21:17:43 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 5/7] net: Add
 generic ndo_select_queue functions
In-Reply-To: <20180709161954.8383.69951.stgit@ahduyck-green-test.jf.intel.com>
References: <20180709161743.8383.97754.stgit@ahduyck-green-test.jf.intel.com>
 <20180709161954.8383.69951.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2D46CC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, July 9, 2018 9:20 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 5/7] net: Add
> generic ndo_select_queue functions
> 
> This patch adds a generic version of the ndo_select_queue functions for
> either returning 0 or selecting a queue based on the processor ID. This is
> generally meant to just reduce the number of functions we have to change
> in the future when we have to deal with ndo_select_queue changes.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/lantiq_etop.c   |   10 +---------
>  drivers/net/ethernet/ti/netcp_core.c |    9 +--------
>  drivers/staging/netlogic/xlr_net.c   |    9 +--------
>  include/linux/netdevice.h            |    4 ++++
>  net/core/dev.c                       |   14 ++++++++++++++
>  net/packet/af_packet.c               |    2 +-
>  6 files changed, 22 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



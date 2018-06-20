From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jun 2018 17:20:28 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 5/7] net: Add
 generic ndo_select_queue functions
In-Reply-To: <20180612151851.86792.50638.stgit@ahduyck-green-test.jf.intel.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
 <20180612151851.86792.50638.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C8109@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, June 12, 2018 8:19 AM
> To: intel-wired-lan at osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org
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



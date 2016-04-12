From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Apr 2016 17:40:09 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: add support for
 per-queue	ethtool stats
In-Reply-To: <20160407225844.28139.2180.stgit@localhost6.localdomain6>
References: <20160407225839.28139.26733.stgit@localhost6.localdomain6>
 <20160407225844.28139.2180.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9CF3CA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, April 07, 2016 3:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: add support for per-queue
> ethtool stats
> 
> Implement per-queue statistics for packets, bytes and busy poll specific
> counters.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c |  127
> +++++++++++++++++++-------
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |   10 --
>  2 files changed, 91 insertions(+), 46 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
New stats show in Ethtool

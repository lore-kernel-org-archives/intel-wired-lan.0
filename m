From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:30:40 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix size of queue stats
 length
In-Reply-To: <20170331034902.6530.34141.stgit@localhost6.localdomain6>
References: <20170331034902.6530.34141.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B0FA@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, March 30, 2017 8:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix size of queue stats length
> 
> IXGBEVF_QUEUE_STATS_LEN is based on ixgebvf_stats, not ixgbe_stats.
> 
> This change fixes a bug where ethtool -S displayed some empty fields.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



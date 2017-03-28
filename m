From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Mar 2017 23:10:34 +0000
Subject: [Intel-wired-lan] [PATCH v7 1/2] ixgbe: add XDP support for
 pass	and drop actions
In-Reply-To: <20170324043110.10293.50132.stgit@john-Precision-Tower-5810>
References: <20170324042949.10293.43329.stgit@john-Precision-Tower-5810>
 <20170324043110.10293.50132.stgit@john-Precision-Tower-5810>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A549@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of John Fastabend
> Sent: Thursday, March 23, 2017 9:31 PM
> To: john.fastabend at gmail.com; alexander.duyck at gmail.com
> Cc: intel-wired-lan at lists.osuosl.org; u9012063 at gmail.com
> Subject: [Intel-wired-lan] [PATCH v7 1/2] ixgbe: add XDP support for pass and
> drop actions
> 
> Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics on XDP
> programs instead of rcu primitives as suggested by Daniel Borkmann and Alex
> Duyck.
> 
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    4 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    4 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  163
> +++++++++++++++++++---
>  3 files changed, 144 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



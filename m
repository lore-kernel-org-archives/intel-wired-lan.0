From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 16:40:56 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 01/16] ixgbe: Fix
 interaction between SR-IOV and macvlan offload
In-Reply-To: <20171122185616.29785.79685.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185616.29785.79685.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFC1A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, November 22, 2017 10:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 01/16] ixgbe: Fix
> interaction between SR-IOV and macvlan offload
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> When SR-IOV was enabled the macvlan offload was configuring several filters
> with the wrong pool value. This would result in the macvlan interfaces not
> being able to receive traffic that had to pass over the physical interface.
> 
> To fix it wrap the pool argument in the VMDQ_P macro which will add the
> necessary offset to get to the actual VMDq pool
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



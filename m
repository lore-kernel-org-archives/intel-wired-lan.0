From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:11:07 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 15/16] net: Cap
 number of queues even with accel_priv
In-Reply-To: <20171122185741.29785.75334.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185741.29785.75334.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFD05@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, November 22, 2017 10:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 15/16] net: Cap
> number of queues even with accel_priv
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> With the recent fix to ixgbe we can cap the number of queues always
> regardless of if accel_priv is being used or not since the actual number of
> queues are being reported via real_num_tx_queues.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  net/core/dev.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



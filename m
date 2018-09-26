From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:37:07 +0000
Subject: [Intel-wired-lan] [PATCH 1/8] ice: use [sr]q.count when
 checking if queue is initialized
In-Reply-To: <20180920002311.10891-2-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
 <20180920002311.10891-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FB3A0@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/8] ice: use [sr]q.count when checking if
> queue is initialized
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When shutting down the controlqs, we check if they are initialized before we
> shut them down and destroy the lock. This is important, as it prevents
> attempts to access the lock of an already shutdown queue.
> 
> Unfortunately, we checked rq.head and sq.head as the value to determine if
> the queue was initialized. This doesn't work, because head is not reset when
> the queue is shutdown. In some flows, the adminq will have already been
> shut down prior to calling ice_shutdown_all_ctrlqs. This can result in a crash
> due to attempting to access the already destroyed mutex.
> 
> Fix this by using rq.count and sq.count instead. Indeed, ice_shutdown_sq
> and ice_shutdown_rq already indicate that this is the value we should be
> using to determine of the queue was initialized.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



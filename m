From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:31:27 +0000
Subject: [Intel-wired-lan] [PATCH v4 05/13] ice: Clean control queues
 only when they are initialized
In-Reply-To: <20180809132903.22819-6-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-6-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545A80@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 05/13] ice: Clean control queues only
> when they are initialized
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> Clean control queues only when they are initialized. One of the ways to
> validate if the basic initialization is done is by checking value of
> cq->sq.head and cq->rq.head variables that specify the register address.
> This patch adds a check to avoid NULL pointer dereference crash when tried
> to shutdown uninitialized control queue.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 24 ++++++++++++-------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>



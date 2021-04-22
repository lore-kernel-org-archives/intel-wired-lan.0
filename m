From: Switzer, David <david.switzer@intel.com>
Date: Thu, 22 Apr 2021 21:00:26 +0000
Subject: [Intel-wired-lan] [PATCH v1 3/3] i40e: use minimal admin queue
 for kdump
In-Reply-To: <20210304025543.334912-4-coxu@redhat.com>
References: <20210304025543.334912-1-coxu@redhat.com>
 <20210304025543.334912-4-coxu@redhat.com>
Message-ID: <MW3PR11MB474829A1CB3A794198D0B319EB469@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Coiby Xu <coxu@redhat.com>
>Sent: Wednesday, March 3, 2021 6:56 PM
To: netdev@vger.kernel.org
>Cc: kexec at lists.infradead.org; intel-wired-lan at lists.osuosl.org; Jakub Kicinski
><kuba@kernel.org>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen,
>Anthony L <anthony.l.nguyen@intel.com>; David S. Miller
><davem@davemloft.net>; open list <linux-kernel@vger.kernel.org>
>Subject: [PATCH v1 3/3] i40e: use minimal admin queue for kdump
>
>The minimum size of admin send/receive queue is 1 and 2 respectively.
>The admin send queue can't be set to 1 because in that case, the firmware would
>fail to init.
>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> drivers/net/ethernet/intel/i40e/i40e.h      | 2 ++
> drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++--
> 2 files changed, 9 insertions(+), 2 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com


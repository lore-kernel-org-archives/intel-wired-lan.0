From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Dec 2021 04:18:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 3/4] igb: support PEROUT
 on 82580/i354/i350
In-Reply-To: <20211028143459.903439-4-kernel.hbk@gmail.com>
References: <20211028143459.903439-1-kernel.hbk@gmail.com>
 <20211028143459.903439-4-kernel.hbk@gmail.com>
Message-ID: <BYAPR11MB3367FA42221280DBD9ADDDC4FC7D9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Ruud
> Bos
> Sent: Thursday, October 28, 2021 8:05 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; richardcochran at gmail.com; Ruud Bos
> <kernel.hbk@gmail.com>; davem at davemloft.net; kuba at kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 3/4] igb: support PEROUT on
> 82580/i354/i350
> 
> Support for the PEROUT PTP pin function on 82580/i354/i350 based adapters.
> Because the time registers of these adapters do not have the nice split in
> second rollovers as the i210 has, the implementation is slightly more complex
> compared to the i210 implementation.
> 
> Signed-off-by: Ruud Bos <kernel.hbk@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |  59 +++++++++-
> drivers/net/ethernet/intel/igb/igb_ptp.c  | 127 +++++++++++++++++++++-
>  2 files changed, 182 insertions(+), 4 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)

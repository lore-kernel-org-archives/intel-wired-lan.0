From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Dec 2021 04:19:20 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 2/4] igb: move PEROUT and
 EXTTS isr logic to separate functions
In-Reply-To: <20211028143459.903439-3-kernel.hbk@gmail.com>
References: <20211028143459.903439-1-kernel.hbk@gmail.com>
 <20211028143459.903439-3-kernel.hbk@gmail.com>
Message-ID: <BYAPR11MB3367641744302F850356B0F5FC7D9@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 2/4] igb: move PEROUT and EXTTS
> isr logic to separate functions
> 
> Remove code duplication in the tsync interrupt handler function by moving this
> logic to separate functions. This keeps the interrupt handler readable and
> allows the new functions to be extended for adapter types other than i210.
> 
> Signed-off-by: Ruud Bos <kernel.hbk@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 81 +++++++++++++----------
>  1 file changed, 46 insertions(+), 35 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)

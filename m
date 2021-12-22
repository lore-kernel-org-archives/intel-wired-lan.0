From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Dec 2021 04:20:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/4] igb: move SDP config
 initialization to separate function
In-Reply-To: <20211028143459.903439-2-kernel.hbk@gmail.com>
References: <20211028143459.903439-1-kernel.hbk@gmail.com>
 <20211028143459.903439-2-kernel.hbk@gmail.com>
Message-ID: <BYAPR11MB3367CA2FDB67CE39D6C8EB51FC7D9@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 1/4] igb: move SDP config
> initialization to separate function
> 
> Allow reuse of SDP config struct initialization by moving it to a separate
> function.
> 
> Signed-off-by: Ruud Bos <kernel.hbk@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 27 +++++++++++++++++-------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)

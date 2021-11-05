From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 5 Nov 2021 09:12:28 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 2/4] ice: use prefetch
 methods
In-Reply-To: <20211027193836.372561-1-jesse.brandeburg@intel.com>
References: <20211023004128.86999-1-jesse.brandeburg@intel.com>
 <20211027193836.372561-1-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB336709A4FBBF84BF112ED8B9FC8E9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
> Brandeburg
> Sent: Thursday, October 28, 2021 1:09 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v1 2/4] ice: use prefetch methods
> 
> The kernel provides some prefetch mechanisms to speed up commonly cold
> cache line accesses during receive processing. Since these are software
> structures it helps to have these strategically placed prefetches.
> 
> Be careful to call BQL prefetch complete only for non XDP queues.
> 
> Co-developed-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> Testing Hints:
> Run AF_XDP socket and then terminate it or run xdp2 sample and send some
> traffic into the port.
> 
> Performance numbers for xdp2 sample are not noticeably affected by
> introducing branch from this patch.
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)

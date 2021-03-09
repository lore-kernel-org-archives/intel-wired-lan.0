From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 9 Mar 2021 23:45:11 +0000
Subject: [Intel-wired-lan] [PATCH net 05/13] ice: Increase control queue
 timeout
In-Reply-To: <20210226211932.46683-5-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-5-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105E66798DA6CE50D0BC542FA929@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, February 26, 2021 1:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 05/13] ice: Increase control queue
> timeout
> 
> From: Fabio Pricoco <fabio.pricoco@intel.com>
> 
> 250 msec timeout is insufficient for some AQ commands. Advice from FW
> team was to increase the timeout. Increase to 1 second.
> 
> Fixes: 7ec59eeac804 ("ice: Add support for control queues")
> Signed-off-by: Fabio Pricoco <fabio.pricoco@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel



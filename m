From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:24:01 +0000
Subject: [Intel-wired-lan] [PATCH S44 05/14] ice: Change number of XDP
 Tx queues to match number of Rx queues
In-Reply-To: <20200516004226.4795-5-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-5-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16597327FED5F3F8F87FFE248CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 05/14] ice: Change number of XDP Tx
> queues to match number of Rx queues
> 
> From: Marta Plantykow <marta.a.plantykow@intel.com>
> 
> In current implementation number of XDP Tx queues is the same as the
> number of transmit queues, which is not always true. This patch changes this
> number to match the number of receive queues.
> XDP programs are running on Rx rings, so what we actually need to provide is
> the XDP Tx ring per each Rx ring so that the whole XDP ecosystem is
> functional, e.g. if the result of XDP prog is XDP_TX then you have the need to
> access the XDP Tx ring.
> 
> Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 2 +-
> drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



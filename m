From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:23:09 +0000
Subject: [Intel-wired-lan] [PATCH S44 03/14] ice: Change number of XDP
 TxQ to 0 when destroying rings
In-Reply-To: <20200516004226.4795-3-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-3-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659CF09488C632C6B8EC8F08CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S44 03/14] ice: Change number of XDP TxQ
> to 0 when destroying rings
> 
> From: Marta Plantykow <marta.a.plantykow@intel.com>
> 
> When XDP Tx rings are destroyed the number of XDP Tx queues is not
> changing. This patch is changing this number to 0.
> 
> Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



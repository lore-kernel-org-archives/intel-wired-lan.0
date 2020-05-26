From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:23:36 +0000
Subject: [Intel-wired-lan] [PATCH S44 04/14] ice: Add XDP Tx to VSI ring
 stats
In-Reply-To: <20200516004226.4795-4-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-4-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659B5707BEE57B09FCA227A8CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S44 04/14] ice: Add XDP Tx to VSI ring stats
> 
> From: Marta Plantykow <marta.a.plantykow@intel.com>
> 
> When XDP Tx program is loaded and packets are sent from interface, VSI
> statistics are not updated. This patch adds packets sent on Tx XDP ring to VSI
> ring stats.
> 
> Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 42 ++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



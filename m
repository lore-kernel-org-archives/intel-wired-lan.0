From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 10 Jun 2020 22:27:14 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] iavf: use appropriate enum for
 comparison
In-Reply-To: <20200605170946.23494-2-anthony.l.nguyen@intel.com>
References: <20200605170946.23494-1-anthony.l.nguyen@intel.com>
 <20200605170946.23494-2-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145CF4EDEBD1D157866725C8C830@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, June 5, 2020 10:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/4] iavf: use appropriate enum for
> comparison
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> adapter->link_speed has type enum virtchnl_link_speed but our
> adapter->comparisons
> are against enum iavf_aq_link_speed. Though they are, currently, the same
> values, change the comparison to the matching enum virtchnl_link_speed
> since that may not always be the case.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c  | 17 ++++++-----------
>  drivers/net/ethernet/intel/iavf/iavf_main.c     | 12 ++++++------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c     | 12 ++++++------
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 ++++++------
>  4 files changed, 24 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



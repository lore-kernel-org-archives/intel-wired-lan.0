From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 10 Jun 2020 22:28:12 +0000
Subject: [Intel-wired-lan] [PATCH 4/4] iavf: increase reset complete
 wait time
In-Reply-To: <20200605170946.23494-4-anthony.l.nguyen@intel.com>
References: <20200605170946.23494-1-anthony.l.nguyen@intel.com>
 <20200605170946.23494-4-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21458A1961CC7FCDA9F58D778C830@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH 4/4] iavf: increase reset complete wait time
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> With an increased number of VFs, it's possible to encounter the following
> issue during reset.
> 
>     iavf b8d4:00:02.0: Hardware reset detected
>     iavf b8d4:00:02.0: Reset never finished (0)
>     iavf b8d4:00:02.0: Reset task did not complete, VF disabled
> 
> Increase the reset complete wait count to allow for 128 VFs to complete
> reset.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      |  4 ++++
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 12 +++++-------
>  2 files changed, 9 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



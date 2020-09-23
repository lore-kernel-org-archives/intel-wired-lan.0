From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Sep 2020 02:02:19 +0000
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 02/11] i40e: clean up
 W=1 warnings in i40e
In-Reply-To: <20200911012337.14015-3-jesse.brandeburg@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-3-jesse.brandeburg@intel.com>
Message-ID: <DM6PR11MB2890C90E8CBF2EE17ECAF95ABC380@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Thursday, September 10, 2020 6:23 PM
> To: netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [RFC PATCH net-next v1 02/11] i40e: clean up W=1
> warnings in i40e
> 
> Inspired by Lee Jones, this eliminates the remaining W=1 warnings in i40e.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c   |  2 --
>  drivers/net/ethernet/intel/i40e/i40e_common.c   |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 17 ++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c      |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     |  7 ++++---
>  .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c  |  9 +++++----
>  6 files changed, 21 insertions(+), 19 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Not sure if this is intended to be the final form, but it's in the tree I'm testing with and seems to work...

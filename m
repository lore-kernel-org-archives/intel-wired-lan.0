From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Sep 2020 03:56:53 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ixgbe: clean up W=1 warnings
 in ixgbe
In-Reply-To: <20200902222708.2144290-1-jesse.brandeburg@intel.com>
References: <20200902222708.2144290-1-jesse.brandeburg@intel.com>
Message-ID: <DM6PR11MB2890EAFBDA808B5B0533F3E1BC380@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Wednesday, September 2, 2020 3:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net v1] ixgbe: clean up W=1 warnings in
> ixgbe
> 
> Inspired by Lee Jones, this elminates the remaining W=1 warnings in
> ixgbe.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>


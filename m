From: Switzer, David <david.switzer@intel.com>
Date: Fri, 23 Apr 2021 22:38:49 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 10/11] ixgbe: use checker
 safe conversions
In-Reply-To: <20210326003834.3886241-11-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
 <20210326003834.3886241-11-jesse.brandeburg@intel.com>
Message-ID: <MW3PR11MB474884D687AB3D39BAD04AC1EB459@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
>Brandeburg
>Sent: Thursday, March 25, 2021 5:39 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v2 10/11] ixgbe: use checker safe
>conversions
>
>The ixgbe hardware needs some very specific programming for certain registers,
>which led to some misguided usage of ntohs instead of using be16_to_cpu(), as
>well as a home grown swap followed by an ntohs. Sparse didn't like this at all, and
>this fixes the C=2 build, with code that uses native kernel interface.
>
>Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>---
>Warning Details:
>.../ixgbe/ixgbe_82599.c:1660:20: warning: cast to restricted __be16
>.../ixgbe/ixgbe_82599.c:1660:20: warning: cast to restricted __be16
>.../ixgbe/ixgbe_82599.c:1660:20: warning: cast to restricted __be16
>.../ixgbe/ixgbe_82599.c:1660:20: warning: cast to restricted __be16
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>

 


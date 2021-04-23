From: Switzer, David <david.switzer@intel.com>
Date: Fri, 23 Apr 2021 22:39:13 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 11/11] ixgbe: reduce
 checker warnings
In-Reply-To: <20210326003834.3886241-12-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
 <20210326003834.3886241-12-jesse.brandeburg@intel.com>
Message-ID: <MW3PR11MB4748A2C17B59931651DD7ED0EB459@MW3PR11MB4748.namprd11.prod.outlook.com>
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
>Cc: Shannon Nelson <snelson@pensando.io>
>Subject: [Intel-wired-lan] [PATCH net-next v2 11/11] ixgbe: reduce checker
>warnings
>
>Fix the sparse warnings in the ixgbe crypto offload code. These changes were
>made in the most conservative way (force cast) in order to hopefully not break
>the code. I suspect that the code might still be broken on big-endian
>architectures, but no one is complaining, so I'm just leaving it functionally the
>same.
>
>Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>Cc: Shannon Nelson <snelson@pensando.io>
>---
>Warning Detail:
>.../ixgbe/ixgbe_ipsec.c:514:56: warning: restricted __be32 degrades to integer
>.../ixgbe/ixgbe_ipsec.c:521:48: warning: restricted __be32 degrades to integer
>.../ixgbe/ixgbe_ipsec.c:536:59: warning: restricted __be32 degrades to integer
>.../ixgbe/ixgbe_ipsec.c:546:59: warning: restricted __be32 degrades to integer
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>

 


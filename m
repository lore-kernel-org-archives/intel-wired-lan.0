From: Switzer, David <david.switzer@intel.com>
Date: Tue, 18 Jan 2022 22:42:28 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Remove non-inclusive
 language from Intel code
In-Reply-To: <20220111102723.3546-1-piotrx.skajewski@intel.com>
References: <20220111102723.3546-1-piotrx.skajewski@intel.com>
Message-ID: <SN6PR11MB3518687236AC4A8D6624E2CCEB589@SN6PR11MB3518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Piotr Skajewski
>Sent: Tuesday, January 11, 2022 2:27 AM
To: intel-wired-lan@lists.osuosl.org; pmenzel at molgen.mpg.de
>Cc: Skajewski, PiotrX <piotrx.skajewski@intel.com>
>Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Remove non-inclusive language
>from Intel code
>
>Remove non-inclusive language from Intel code as our entire industry
>removes non-inclusive language from our documentation, user-interfaces and
>code.
>
>Additionally correct the duplication "from from"
>reported by checkpatch after the changes above.
>
>Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
>---
>v2:
> - removed dot/period from commit message summary
> - commit message updated with word duplication
>---
> .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 36 +++++++++----------
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 +--
>drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 10 +++---
> 3 files changed, 25 insertions(+), 25 deletions(-)

Tested-by: Dave Switzer <david.switzer@intel.com>

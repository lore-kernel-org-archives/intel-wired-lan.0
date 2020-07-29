From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2020 17:11:33 +0000
Subject: [Intel-wired-lan] [PATCH 4/4] ixgbe/ixgbe_ethtool.c: Remove
 unnecessary usages of memset.
In-Reply-To: <20200714194212.GA21612@blackclown>
References: <20200714194212.GA21612@blackclown>
Message-ID: <BN6PR1101MB214560CE80E83A83A9BFEF318C700@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Suraj Upadhyay
> Sent: Tuesday, July 14, 2020 12:42 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net;
> kuba at kernel.org
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 4/4] ixgbe/ixgbe_ethtool.c: Remove
> unnecessary usages of memset.
> 
> Replace memsets of 1 byte with simple assignment.
> Issue found with checkpatch.pl
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



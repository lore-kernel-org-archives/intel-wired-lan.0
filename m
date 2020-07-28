From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 28 Jul 2020 20:49:18 +0000
Subject: [Intel-wired-lan] [PATCH 3/4] igb/igb_ethtool.c : Remove
 unnecessary usages of memset.
In-Reply-To: <20200714194147.GA21537@blackclown>
References: <20200714194147.GA21537@blackclown>
Message-ID: <DM6PR11MB28901E92AF05925C1C6488C8BC730@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Suraj Upadhyay <usuraj35@gmail.com>
> Sent: Tuesday, July 14, 2020 12:42 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net;
> kuba at kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; kernel-janitors at vger.kernel.org
> Subject: [PATCH 3/4] igb/igb_ethtool.c : Remove unnecessary usages of
> memset.
> 
> Replace memsets of 1 byte with simple assignment.
> Issue found with checkpatch.pl
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>


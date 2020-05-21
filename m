From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 May 2020 07:27:59 +0000
Subject: [Intel-wired-lan] [PATCH net-next] igb: make
 igb_set_fc_watermarks() return void
In-Reply-To: <20200507110915.38349-1-yanaijie@huawei.com>
References: <20200507110915.38349-1-yanaijie@huawei.com>
Message-ID: <DM6PR11MB2890A3BB1993EF97E4368F06BCB70@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org> On
> Behalf Of Jason Yan
> Sent: Thursday, May 7, 2020 4:09 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net;
> yanaijie at huawei.com; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH net-next] igb: make igb_set_fc_watermarks() return void
> 
> This function always return 0 now, we can make it return void to
> simplify the code. This fixes the following coccicheck warning:
> 
> drivers/net/ethernet/intel/igb/e1000_mac.c:728:5-12: Unneeded variable:
> "ret_val". Return "0" on line 751
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_mac.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>


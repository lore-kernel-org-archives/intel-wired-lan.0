From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Wed, 10 Feb 2021 11:47:03 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: Log error for
 oversized MTU on device
In-Reply-To: <20210114161706.9224-1-eryk.roch.rybak@intel.com>
References: <20210114161706.9224-1-eryk.roch.rybak@intel.com>
Message-ID: <DM6PR11MB32927882DF0FA774BCF6DBCAF18D9@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Eryk Rybak
> Sent: Thursday, January 14, 2021 9:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Rybak, Eryk Roch <eryk.roch.rybak@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: Log error for oversized
> MTU on device
> 
> When attempting to link XDP prog with MTU larger than supported, user is
> not informed why XDP linking fails. Adding proper error message: "MTU too
> large to enable XDP".
> Due to the lack of support for non-static variables in netlinks extended ACK
> feature, additional information has been added to dmesg to better inform
> about invalid MTU setting.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
> ---
> v2: add dmesg trace, change commit message
> drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel

From: Switzer, David <david.switzer@intel.com>
Date: Wed, 7 Apr 2021 22:57:04 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse error:
 uninitialized symbol 'ring'
In-Reply-To: <20210326184343.133396-2-arkadiusz.kubalewski@intel.com>
References: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
 <20210326184343.133396-2-arkadiusz.kubalewski@intel.com>
Message-ID: <MW3PR11MB47485BB88F843116CD6C6A7CEB759@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Arkadiusz Kubalewski
>Sent: Friday, March 26, 2021 11:44 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
>Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse error: uninitialized symbol
>'ring'
>
>Init pointer with NULL in default switch case statement.
>
>Previously the error was produced when compiling against sparse.
>i40e_debugfs.c:582 i40e_dbg_dump_desc() error: uninitialized symbol 'ring'.
>
>Fixes: 44ea803e2fa7 ("i40e: introduce new dump desc XDP command")
>Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 3 +++
> 1 file changed, 3 insertions(+)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
 


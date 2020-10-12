From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 12 Oct 2020 21:53:51 +0000
Subject: [Intel-wired-lan] [PATCH] igbvf: Refactor traces
In-Reply-To: <20200910103619.10467-1-karen.sornek@intel.com>
References: <20200910103619.10467-1-karen.sornek@intel.com>
Message-ID: <DM6PR11MB289063710054770764B9A0D2BC070@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Karen
> Sornek
> Sent: Thursday, September 10, 2020 3:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH] igbvf: Refactor traces
> 
> Refactoring "PF still resetting" and changing "Failed
>  to add vlan id" to "Vlan id is not added"
> messages because previous version looked like a bug
> - it informed about changes that worked as
> designed but might confuse users
> 
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/igbvf/netdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

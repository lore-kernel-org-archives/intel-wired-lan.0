From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 2 Nov 2021 23:02:57 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] igbvf: Refactor trace
In-Reply-To: <20210707064025.55096-1-karen.sornek@intel.com>
References: <20210707064025.55096-1-karen.sornek@intel.com>
Message-ID: <MN2PR11MB422482939EDB463B72D9A62D828B9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sornek, Karen
> Sent: Tuesday, July 6, 2021 11:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] igbvf: Refactor trace
> 
> Refactoring "PF still resetting" message, because previous version looked like
> a bug - it informed about changes that worked as designed but might
> confuse users. Changes requested to make message more user-friendly.
> 
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>



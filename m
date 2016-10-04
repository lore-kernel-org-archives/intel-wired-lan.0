From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 4 Oct 2016 18:16:27 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix call
	of	ndo_dflt_bridge_getlink()
In-Reply-To: <1474876278-28640-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1474876278-28640-1-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0F7AC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Nicolas Dichtel
> Sent: Monday, September 26, 2016 12:51 AM
> To: davem at davemloft.net; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; Huaibin Wang <huaibin.wang@6wind.com>;
> intel-wired-lan at lists.osuosl.org; Nicolas Dichtel
> <nicolas.dichtel@6wind.com>
> Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix call of
> ndo_dflt_bridge_getlink()
> 
> From: Huaibin Wang <huaibin.wang@6wind.com>
> 
> Order of arguments is wrong.
> The wrong code has been introduced by commit 7d4f8d871ab1, but is
> compiled only since commit 9df70b66418e.
> 
> Note that this may break netlink dumps.
> 
> Fixes: 9df70b66418e ("i40e: Remove incorrect #ifdef's")
> Fixes: 7d4f8d871ab1 ("switchdev; add VLAN support for port's
> bridge_getlink")
> CC: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Huaibin Wang <huaibin.wang@6wind.com>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
> 
> v1 -> v2
>  - remove CC
>  - rebase on the last net tree
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



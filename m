From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 25 Jun 2021 22:39:44 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Fix an error handling path in
 'igb_probe()'
In-Reply-To: <0b5cab7b74ca2544d3c616da89f50635e827bc6f.1623528463.git.christophe.jaillet@wanadoo.fr>
References: <0b5cab7b74ca2544d3c616da89f50635e827bc6f.1623528463.git.christophe.jaillet@wanadoo.fr>
Message-ID: <SJ0PR11MB56620F7C26BCA6EC7D798FABFA069@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Christophe JAILLET
> Sent: Saturday, June 12, 2021 1:09 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> jeffrey.t.kirsher at intel.com; alexander.h.duyck at intel.com
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; Christophe
> JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-lan at lists.osuosl.org;
> linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] igb: Fix an error handling path in
> 'igb_probe()'
> 
> If an error occurs after a 'pci_enable_pcie_error_reporting()' call, it must be
> undone by a corresponding 'pci_disable_pcie_error_reporting()'
> call, as already done in the remove function.
> 
> Fixes: 40a914fa72ab ("igb: Add support for pci-e Advanced Error Reporting")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)



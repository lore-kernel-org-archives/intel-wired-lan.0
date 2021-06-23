From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 23 Jun 2021 20:17:15 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix an error handling path in
 'ixgbe_probe()'
In-Reply-To: <e3cc7010f6bd15d8ca49b935847450e92122dee8.1623505485.git.christophe.jaillet@wanadoo.fr>
References: <e3cc7010f6bd15d8ca49b935847450e92122dee8.1623505485.git.christophe.jaillet@wanadoo.fr>
Message-ID: <SJ0PR11MB5662DBD0FD854E20709E5D3EFA089@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Christophe JAILLET
> Sent: Saturday, June 12, 2021 6:46 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> jeffrey.t.kirsher at intel.com; peter.p.waskiewicz.jr at intel.com
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; Christophe
> JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-lan at lists.osuosl.org;
> linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix an error handling path in
> 'ixgbe_probe()'
> 
> If an error occurs after a 'pci_enable_pcie_error_reporting()' call, it must be
> undone by a corresponding 'pci_disable_pcie_error_reporting()'
> call, as already done in the remove function.
> 
> Fixes: 6fabd715e6d8 ("ixgbe: Implement PCIe AER support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)



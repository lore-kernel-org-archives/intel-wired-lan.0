From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 24 Jun 2021 16:37:44 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix an error handling path in
 'e1000_probe()'
In-Reply-To: <2651bb1778490c45d963122619fe3403fdf6b9de.1623819901.git.christophe.jaillet@wanadoo.fr>
References: <2651bb1778490c45d963122619fe3403fdf6b9de.1623819901.git.christophe.jaillet@wanadoo.fr>
Message-ID: <c2ed2d13-6949-3f78-a28f-752cff8b08ee@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/16/2021 08:05, Christophe JAILLET wrote:
> If an error occurs after a 'pci_enable_pcie_error_reporting()' call, it
> must be undone by a corresponding 'pci_disable_pcie_error_reporting()'
> call, as already done in the remove function.
> 
> Fixes: 111b9dc5c981 ("e1000e: add aer support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
>   1 file changed, 1 insertion(+)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>

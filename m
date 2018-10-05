From: Vinod <vkoul@kernel.org>
Date: Fri, 5 Oct 2018 19:56:34 +0530
Subject: [Intel-wired-lan] [PATCH] XXX PCI/AER: remove unused variables
In-Reply-To: <20181002210426.2447078-1-arnd@arndb.de>
References: <20181002210426.2447078-1-arnd@arndb.de>
Message-ID: <20181005142634.GL2372@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 02-10-18, 23:02, Arnd Bergmann wrote:
> A couple of files now contain a function with a return
> code variable that is no longer used:
> 
> drivers/net/ethernet/sfc/efx.c: In function 'efx_io_slot_reset':
> drivers/net/ethernet/sfc/efx.c:3824:6: error: unused variable 'rc' [-Werror=unused-variable]
>   int rc;
>       ^~
> drivers/net/ethernet/sfc/falcon/efx.c: In function 'ef4_io_slot_reset':
> Oza Pawandeep <poza@codeaurora.org>
> drivers/net/ethernet/sfc/falcon/efx.c:3163:6: error: unused variable 'rc' [-Werror=unused-variable]
>   int rc;
>       ^~
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_io_slot_reset':
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11143:6: error: unused variable 'err' [-Werror=unused-variable]
>   int err;
>       ^~~
> drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_pci_error_slot_reset':
> drivers/net/ethernet/intel/i40e/i40e_main.c:14555:6: error: unused variable 'err' [-Werror=unused-variable]
>   int err;
> 
> drivers/dma/ioat/init.c: In function 'ioat_pcie_error_slot_reset':
> drivers/dma/ioat/init.c:1255:6: error: unused variable 'err' [-Werror=unused-variable]
>   int err;
> 
> This removes all the ones I found during randconfig build testing.
> 
> Fixes: 6dcde3e574b2 ("XXX PCI/AER: Remove pci_cleanup_aer_uncorrect_error_status() calls")
> Cc: Oza Pawandeep <poza@codeaurora.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/ioat/init.c                       | 1 -

For this:

Acked-by: Vinod Koul <vkoul@kernel.org>
-- 
~Vinod

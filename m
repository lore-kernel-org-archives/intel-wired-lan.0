From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 13 Oct 2018 02:01:44 +0000
Subject: [Intel-wired-lan] [PATCH v8 06/11] igc: Add transmit and
 receive fastpath and interrupt handlers
In-Reply-To: <20181011071722.1799-1-sasha.neftin@intel.com>
References: <20181011071722.1799-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657ACFA@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Sasha Neftin
> Sent: Thursday, October 11, 2018 12:17 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v8 06/11] igc: Add transmit and receive
> fastpath and interrupt handlers
> 
> This patch adds support for allocating, configuring, and freeing Tx/Rx ring
> resources.  With these changes in place the descriptor queues are in a
> state where they are ready to transmit or receive if provided buffers.
> 
> This also adds the transmit and receive fastpath and interrupt handlers.
> With this code in place the network device is now able to send and receive
> frames over the network interface using a single queue.
> 
> Sasha Neftin (v2):
> removed obsolete code
> refactor transmit and receive methods
> 
> Sasha Neftin (v3):
> removed unused mac type
> code optimization, remome switch statement where it is not necessary
> resolve conflicts
> 
> Sasha Neftin (v4):
> address comments
> fix comments
> remove obsolete Helbert's patch
> fix xmas tree layout
> remove obsolete IGC_SET_FLAG definition
> re-work PAGE_SIZE definition
> fix code indentation
> re-work igc_tx_olinfo_status method
> replace e1000_ prefix with igc_ prefix
> remove unused descriptors definition
> 
> Sasha Neftin (v5):
> code clean
> remove obsolete flash_address reference
> remove unused defines
> 
> Sasha Neftin (v6):
> remove duplication of define MAX_Q_VECTORS
> minor cosmetic changes
> 
> Sasha Neftin (v7):
> no changes
> 
> Sasha Neftin (v8):
> fix whitespaces in comments
> replace space with tab
> remove unneeded forward declarations
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |   66 ++
>  drivers/net/ethernet/intel/igc/igc_base.h    |   15 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |   45 ++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 1123
> +++++++++++++++++++++++++-
>  4 files changed, 1205 insertions(+), 44 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

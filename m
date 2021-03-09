From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 9 Mar 2021 09:17:25 +0100
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix prototype warning
In-Reply-To: <20210307084427.2882842-1-sasha.neftin@intel.com>
References: <20210307084427.2882842-1-sasha.neftin@intel.com>
Message-ID: <ebb9190c-ac57-9c3a-29d6-1e752e9d9608@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


Thank you for the patch.


Am 07.03.21 um 09:44 schrieb Sasha Neftin:
> Correct report warnings in igc_i225.c

It?d be great, if you added somewhere it?s about the comment/function 
documentation (DoxyGen). Maybe as summary:

> igc: Fix function name in `igc_acquire_nvm_i225()` Doxygen comment

> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_i225.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
> index 7ec04e48860c..cc83bb5c15e8 100644
> --- a/drivers/net/ethernet/intel/igc/igc_i225.c
> +++ b/drivers/net/ethernet/intel/igc/igc_i225.c
> @@ -6,7 +6,7 @@
>   #include "igc_hw.h"
>   
>   /**
> - * igc_get_hw_semaphore_i225 - Acquire hardware semaphore
> + * igc_acquire_nvm_i225 - Acquire exclusive access to EEPROM
>    * @hw: pointer to the HW structure
>    *
>    * Acquire the necessary semaphores for exclusive access to the EEPROM.

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

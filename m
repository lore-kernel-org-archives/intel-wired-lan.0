From: naamax.meir <naamax.meir@linux.intel.com>
Date: Thu, 19 May 2022 12:49:41 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] Revert "e1000e: Fix possible
 HW unit hang after an s0ix exit"
In-Reply-To: <20220509085254.2436296-1-sasha.neftin@intel.com>
References: <20220509085254.2436296-1-sasha.neftin@intel.com>
Message-ID: <d01c1c94-3088-942d-cd18-942e4c519c6d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/9/2022 11:52, Sasha Neftin wrote:
> This reverts commit 1866aa0d0d6492bc2f8d22d0df49abaccf50cddd.
> 
> Commit 1866aa0d0d64("e1000e: Fix possible HW unit hang after an s0ix exit")
> was a workaround for CSME problem to handle messages comes via H2ME
> mailbox. This problem has been fixed by patch "e1000e: Enable the GPT
> clock before sending message to the CSME".
> 
> Fixes: 3e55d231716e ("e1000e: Add handshake with the CSME to support S0ix")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214821
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/hw.h      |  1 -
>   drivers/net/ethernet/intel/e1000e/ich8lan.c |  4 ----
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |  1 -
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 26 ---------------------
>   4 files changed, 32 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>

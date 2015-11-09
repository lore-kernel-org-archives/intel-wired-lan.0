From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Nov 2015 18:47:25 +0000
Subject: [Intel-wired-lan] [next PATCH S21 04/14] i40e: Detection
	and	recovery of TX queue hung logic moved to service_task
	from	tx_timeout
In-Reply-To: <1446852372-25480-5-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-5-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E181E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, November 06, 2015 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 04/14] i40e: Detection and
> recovery of TX queue hung logic moved to service_task from tx_timeout
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> This patch contains following changes:
>    - detection and recovery logic (issue SW interrupt) has been moved to
>      service_task from timeout function.
>    - added some more debug info from tx_timeout.
> 
> Logic to detect and recover TX queue hung is now two step process:
>   - service_task detects TX queue hung and sets a bit(hung_detected) if
>     it was not set.
>   - if bit was set (means this is back-back hung condition detected),
>     issue SW interrupt and clear the bit.
>   - napi_poll clears the bit unconditionally since it cleans TX/RX queues.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: Ieed03a48927c845a988b3ff375090bf37caeb903
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  3 +++
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 36
> ++++++++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 21 ++++++++++------
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h | 15 +++++++++++
>  5 files changed, 64 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied

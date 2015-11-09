From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Nov 2015 19:02:46 +0000
Subject: [Intel-wired-lan] [next PATCH S21 05/14] i40e: Fix memory leaks,
 sideband filter programming
In-Reply-To: <1446852372-25480-6-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-6-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1836@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S21 05/14] i40e: Fix memory leaks,
> sideband filter programming
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> This patch fixes the memory leak which would be seen otherwise when user
> programs flow-director filter using ethtool (sideband filter programming).
> 
> When ethtool is used to program flow directory filter, 'raw_buf' gets
> allocated and it is supposed to be freed as part of queue cleanup. But check
> of 'tx_buffer->skb' was preventing it from being freed.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: Ief4f0a1a32a653180498bf6e987c1b4342ab8923
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 19 ++++++++++++++-----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 10 +++++-----
>  2 files changed, 19 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, memory usage does not increase with repeated flow director filter/table changes.

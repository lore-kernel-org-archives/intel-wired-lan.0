From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 May 2017 18:13:57 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix state flags for bit set
 and	clean operations of PF
In-Reply-To: <1494642416-21796-1-git-send-email-maurosr@linux.vnet.ibm.com>
References: <1494642416-21796-1-git-send-email-maurosr@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA40B8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Mauro S. M. Rodrigues
> Sent: Friday, May 12, 2017 7:27 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Cc: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>;
> gpiccoli at linux.vnet.ibm.com
> Subject: [Intel-wired-lan] [PATCH net] i40e: Fix state flags for bit set and
> clean operations of PF
> 
> Commit 0da36b9774cc ("i40e: use DECLARE_BITMAP for state fields")
> introduced changes in the way i40e works with state flags converting them to
> bitmaps using kernel bitmap API. This change introduced a regression due to
> a mistaken substitution using __I40E_VSI_DOWN instead of __I40E_DOWN
> when testing state of a PF at i40e_reset_subtask() function. This caused a
> flood in the kernel log with the follow message:
> 
> [49.013] i40e 0002:01:00.0: bad reset request 0x00000020
> 
> Commit d19cb64b9222 ("i40e: separate PF and VSI state flags") also
> introduced some misuse of the VSI and PF flags, so both could be considered
> as the offenders.
> 
> This patch simply fixes the flags where it makes sense by changing
> __I40E_VSI_DOWN to __I40E_DOWN.
> 
> Fixes: 0da36b9774cc ("i40e: use DECLARE_BITMAP for state fields")
> Fixes: d19cb64b9222 ("i40e: separate PF and VSI state flags")
> 
> Reviewed-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 36 ++++++++++++++----------
> -----
>  1 file changed, 18 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



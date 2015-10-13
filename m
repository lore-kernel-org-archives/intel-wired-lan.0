From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Oct 2015 16:36:38 +0000
Subject: [Intel-wired-lan] [next-queue v2 2/6] i40e: add missing
 kernel-doc	argument
In-Reply-To: <1444719992-301-2-git-send-email-sakiwit@gmail.com>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
 <1444719992-301-2-git-send-email-sakiwit@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D117A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jean Sacren
> Sent: Tuesday, October 13, 2015 12:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v2 2/6] i40e: add missing kernel-doc
> argument
> 
> From: Jean Sacren <sakiwit@gmail.com>
> 
> The following kernell-doc arguments for their respective functions are
> missing:
> 
> 1) @cd_type_cmd_tso_mss for i40e_tso();
> 2) @cd_type_cmd_tso_mss for i40e_tsyn();
> 3) @tx_ring for i40e_tx_enable_csum().
> 
> Add them all for the kernel-doc requirement.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes except for the serial number.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied

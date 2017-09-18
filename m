From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 16:59:52 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: Use seq_putc()
	in	fm10k_dbg_desc_break()
In-Reply-To: <4f8686c6-76cb-3d12-934e-6af67b6f084b@users.sourceforge.net>
References: <4f8686c6-76cb-3d12-934e-6af67b6f084b@users.sourceforge.net>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF65B8@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of SF Markus Elfring
> Sent: Monday, May 8, 2017 9:18 AM
> To: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: kernel-janitors at vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
> Subject: [Intel-wired-lan] [PATCH] fm10k: Use seq_putc() in
> fm10k_dbg_desc_break()
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 8 May 2017 18:10:39 +0200
> 
> Two single characters should be put into a sequence.
> Thus use the corresponding function "seq_putc".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>


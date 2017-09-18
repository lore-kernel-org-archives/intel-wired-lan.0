From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:22:47 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: Fix misuse of net_ratelimit()
In-Reply-To: <83d6fcab6a180d7006c8eb396c9aa3169dc6a84d.1502468221.git.joe@perches.com>
References: <83d6fcab6a180d7006c8eb396c9aa3169dc6a84d.1502468221.git.joe@perches.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF67F9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Joe Perches
> Sent: Friday, August 11, 2017 9:17 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] fm10k: Fix misuse of net_ratelimit()
> 
> Correct the backward logic using !net_ratelimit()
> 
> Miscellanea:
> 
> o Add a blank line before the error return label
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>


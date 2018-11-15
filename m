From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 15 Nov 2018 00:17:17 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Fix format with line
 continuation whitespace
In-Reply-To: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
References: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965C10B5@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Joe Perches
> Sent: Thursday, November 1, 2018 12:04 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: David S. Miller <davem@davemloft.net>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH] igb: Fix format with line continuation whitespace
> 
> The line continuation unintentionally adds whitespace so
> instead use a coalesced format to remove the whitespace.
> 
> Miscellanea:
> 
> o Use a more typical style for ternaries and arguments
>   for this logging message
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

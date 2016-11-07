From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 7 Nov 2016 23:55:35 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Workaround for igb i210 firmware
	issue.
In-Reply-To: <1478096032-22119-1-git-send-email-christopherarges@gmail.com>
References: <1478096032-22119-1-git-send-email-christopherarges@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81FC45B5@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Chris J Arges
> Sent: Wednesday, November 2, 2016 7:14 AM
> To: jh at henneberg-systemdesign.com
> Cc: intel-wired-lan at lists.osuosl.org; Chris J Arges
> <christopherarges@gmail.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Subject: [PATCH] igb: Workaround for igb i210 firmware issue.
> 
> Sometimes firmware may not properly initialize I347AT4_PAGE_SELECT
> causing
> the probe of an igb i210 NIC to fail. This patch adds an addition zeroing of
> this register during igb_get_phy_id to workaround this issue.
> 
> Thanks for Jochen Henneberg for the idea and original patch.
> 
> Signed-off-by: Chris J Arges <christopherarges@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_phy.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

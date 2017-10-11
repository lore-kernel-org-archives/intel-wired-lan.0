From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 11 Oct 2017 01:45:13 +0000
Subject: [Intel-wired-lan] [net-next,
	RESEND] igb: add function to get maximum RSS queues
In-Reply-To: <1505828454-2826-1-git-send-email-zhangshengju@cmss.chinamobile.com>
References: <1505828454-2826-1-git-send-email-zhangshengju@cmss.chinamobile.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6BE24C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Zhang Shengju
> Sent: Tuesday, September 19, 2017 6:41 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [net-next,RESEND] igb: add function to get maximum RSS queues
> 
> This patch adds a new function igb_get_max_rss_queues() to get maximum
> RSS queues, this will reduce duplicate code and facilitate future
> maintenance.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 32 +---------------------------
>  drivers/net/ethernet/intel/igb/igb_main.c    | 12 +++++++++--
>  3 files changed, 12 insertions(+), 33 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 25 Aug 2016 19:23:02 +0000
Subject: [Intel-wired-lan] [PATCH -next] igb: fix non static symbol
	warning
In-Reply-To: <1471964889-511-1-git-send-email-weiyj.lk@gmail.com>
References: <1471964889-511-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F7746A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Wei Yongjun
> Sent: Tuesday, August 23, 2016 8:08 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [PATCH -next] igb: fix non static symbol warning
> 
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2707:5: warning:
>  symbol 'igb_rxnfc_write_vlan_prio_filter' was not declared. Should it be
> static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

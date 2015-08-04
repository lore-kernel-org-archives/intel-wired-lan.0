From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 4 Aug 2015 22:41:21 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] missing rtnl_unlock in
	igb_sriov_reinit()
In-Reply-To: <559BF609.4020705@virtuozzo.com>
References: <559BF609.4020705@virtuozzo.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81ADF4C9@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Vasily Averin
> Sent: Tuesday, July 07, 2015 8:54 AM
> To: David S. Miller; netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T; Fujinaka, Todd
> Subject: [PATCH 2/3] missing rtnl_unlock in igb_sriov_reinit()
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

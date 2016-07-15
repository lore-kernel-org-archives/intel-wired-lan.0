From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Jul 2016 23:27:24 +0000
Subject: [Intel-wired-lan] [net-next v6 4/4] igb: fix error code in
 igb_add_ethtool_nfc_entry()
In-Reply-To: <1467782577-25659-5-git-send-email-gangfeng.huang@ni.com>
References: <1467782577-25659-1-git-send-email-gangfeng.huang@ni.com>
 <1467782577-25659-5-git-send-email-gangfeng.huang@ni.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F30D1E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Gangfeng [mailto:gangfeng.huang at ni.com]
> Sent: Tuesday, July 5, 2016 10:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gangfeng Huang <gangfeng.huang@ni.com>; Brown, Aaron F
> <aaron.f.brown@intel.com>
> Subject: [net-next v6 4/4] igb: fix error code in igb_add_ethtool_nfc_entry()
> 
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> Use error "rmgr: Cannot insert RX class rule: Operation not supported" is
> more meaningful than "rmgr: Cannot insert RX class rule: Unknown error
> 524"
> 
> CC: Brown Aaron F <aaron.f.brown@intel.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

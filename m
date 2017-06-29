From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 29 Jun 2017 00:30:23 +0000
Subject: [Intel-wired-lan] [PATCH v2] igb: Fix error of RX network
	flow	classification
In-Reply-To: <1495847873-845-1-git-send-email-gangfeng.huang@ni.com>
References: <1495847873-845-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6260FB@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Gangfeng
> Sent: Friday, May 26, 2017 6:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gangfeng Huang <gangfeng.huang@ni.com>
> Subject: [Intel-wired-lan] [PATCH v2] igb: Fix error of RX network flow
> classification
> 
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> After add an ethertype filter, if user change the adapter speed several
> times, the error "ethtool -N: etype filters are all used" is reported by
> igb driver.
> 
> In older patch, function igb_nfc_filter_exit() and igb_nfc_filter_restore()
> is not paried. igb_nfc_filter_restore() exist in igb_up(), but function
> igb_nfc_filter_exit() is exist in __igb_close(). In the process of speed
> changing, only igb_nfc_filter_restore() is called, it will take a position
> of ethertype bitmap.
> 
> Reproduce steps:
> Step 1: Add a etype filter by ethtool
> $ethtool -N eth0 flow-type ether proto 0x88F8 action 1
> Step 2: Change the adapter speed to 100M/full duplex
> $ethtool -s eth0 speed 100 duplex full
> Step 3: Change the adapter speed to 1000M/full duplex
> ethtool -s eth0 speed 1000 duplex full
> Repeat step2 and step3, then dmesg the system log, you can find the error
> message, add new ethtype filter is also failed.
> 
> This fixing is move igb_nfc_filter_exit() from __igb_close() to igb_down()
> to make igb_nfc_filter_restore()/igb_nfc_filter_exit() is paired.
> 
> Signed-off-by: Gangfeng <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

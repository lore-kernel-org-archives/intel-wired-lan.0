From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 4 May 2017 15:39:21 -0700
Subject: [Intel-wired-lan] [PATCH] igb: Fix error of RX network flow
 classification
In-Reply-To: <1493864606-9716-1-git-send-email-gangfeng.huang@ni.com>
References: <1493864606-9716-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <20170504153921.00002201@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 4 May 2017 10:23:26 +0800
Gangfeng <gangfeng.huang@ni.com> wrote:

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

Thank you, this looks much better!

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

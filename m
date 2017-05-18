From: David Miller <davem@davemloft.net>
Date: Thu, 18 May 2017 10:46:14 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Don't return uninitialized
	stats
In-Reply-To: <20170517202413.18321-1-bpoirier@suse.com>
References: <20170425175433.ykc6ilm6uo7e6my2@f1.synalogic.ca>
 <20170517202413.18321-1-bpoirier@suse.com>
Message-ID: <20170518.104614.1739169308591707817.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Benjamin Poirier <bpoirier@suse.com>
Date: Wed, 17 May 2017 16:24:13 -0400

> Some statistics passed to ethtool are garbage because e1000e_get_stats64()
> doesn't write them, for example: tx_heartbeat_errors. This leaks kernel
> memory to userspace and confuses users.
> 
> Do like ixgbe and use dev_get_stats() which first zeroes out
> rtnl_link_stats64.
> 
> Fixes: 5944701df90d ("net: remove useless memset's in drivers get_stats64")
> Reported-by: Stefan Priebe <s.priebe@profihost.ag>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Jeff, please be sure to pick this up, thanks.

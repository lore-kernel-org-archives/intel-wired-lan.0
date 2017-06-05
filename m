From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2017 11:01:45 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH] net/{mii,
 smsc}: Make mii_ethtool_get_link_ksettings and smc_netdev_get_ecmd
 return void
In-Reply-To: <20170604172200.4177-1-yuval.shaia@oracle.com>
References: <20170604172200.4177-1-yuval.shaia@oracle.com>
Message-ID: <20170605.110145.2053472151656679350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  4 Jun 2017 20:22:00 +0300

> Make return value void since functions never returns meaningfull value.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>

Applied to net-next.

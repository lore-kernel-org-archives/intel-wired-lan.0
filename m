From: David Miller <davem@davemloft.net>
Date: Mon, 17 Oct 2016 10:42:00 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH net-next 02/11] net: Introduce new api
 for walking upper and lower devices
In-Reply-To: <20161017052121.2322279d@xeon-e3>
References: <1476494931-31813-1-git-send-email-dsa@cumulusnetworks.com>
 <1476494931-31813-3-git-send-email-dsa@cumulusnetworks.com>
 <20161017052121.2322279d@xeon-e3>
Message-ID: <20161017.104200.2266025643403507437.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 17 Oct 2016 05:21:21 -0700

> You should write this more succinctly as:
> 
> static bool __netdev_has_upper_dev(struct net_device *upper_dev, void *data)
> {
> 	struct net_device *dev = data;
> 
> 	return upper_dev == dev;
> }
> 
> bool netdev_has_upper_dev_all_rcu(struct net_device *dev,
> 				  struct net_device *upper_dev)
> {
> 	return netdev_walk_all_upper_dev_rcu(dev,
> 			__netdev_has_upper_dev, upper_dev);
> }
> 
> No if/else needed. No cast of void * ptr need. Use const if possible?

Agreed.

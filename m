From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 29 Aug 2021 22:16:06 +0200
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
 <20210829151017.GA6016@hoboy.vegasvil.org>
 <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
Message-ID: <YSvrBvLJ3IRTn9FR@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > I have nothing against exposing the DPLL if you need to, however I'd like to have
> > an interface that support plain Gigabit as well.  This could be done in a generic
> > way by offering Control Register 9 as described in 802.3.

Are we talking about Clause 22, register 9, also known as MII_CTRL1000?

> This part of Gigabit interface is a different part of SyncE device. It controls Master/Slave
> operation of auto-negotiation.

This is controlled using ethtool -s

      ethtool -s devname [speed N] [duplex half|full] [port tp|aui|bnc|mii]
              ....
              [sopass xx:yy:zz:aa:bb:cc] [master-slave preferred-
              master|preferred-slave|forced-master|forced-slave]

      Andrew

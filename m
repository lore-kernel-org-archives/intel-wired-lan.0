From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 23 Sep 2020 21:28:13 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: Power cycle phy on PM resume
In-Reply-To: <79f01082-c9b1-f80a-7af4-b61bdbf40c90@molgen.mpg.de>
References: <20200923074751.10527-1-kai.heng.feng@canonical.com>
 <17092088-86ff-2d31-b3de-2469419136a3@molgen.mpg.de>
 <AC6D77B8-244D-4816-8FFE-A4480378EC4C@canonical.com>
 <79f01082-c9b1-f80a-7af4-b61bdbf40c90@molgen.mpg.de>
Message-ID: <20200923192813.GE3764123@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > > How much does this increase the resume time?

Define resume time? Until you get the display manager unlock screen?
Or do you need working networking?

It takes around 1.5 seconds for auto negotiation to get a link. I know
it takes me longer than that to move my fingers to the keyboard and
type in my password to unlock the screen. So by the time you actually
get to see your desktop, you should have link.

I've no idea about how the e1000e driver does link negotiation. But
powering the PHY off means there is going to be a negotiation sometime
later. But if you don't turn it off, the driver might be able to avoid
doing an autoneg if the PHY has already done one when it got powered
up.

      Andrew

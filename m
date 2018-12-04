From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 4 Dec 2018 11:40:38 +0100
Subject: [Intel-wired-lan] [PATCH net-next v4 0/2] Add mii_bus to ixgbe
 driver for dsa devs
In-Reply-To: <c8e3976f-73f9-80be-f6d6-c9a1f064a096@gmail.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203201432.18252-1-stephend@silicom-usa.com>
 <19b22292-f2b3-ccb8-bb37-0952cfa93135@gmail.com>
 <5c8b517a-6632-931d-c695-ec8a5302bfa4@silicom-usa.com>
 <c8e3976f-73f9-80be-f6d6-c9a1f064a096@gmail.com>
Message-ID: <20181204104038.GB741@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Yes the current solution whereby we need to get a hold on the network
> device's struct device reference is not quite ideal, AFAIR, Andrew has
> had the same problem.

Yes, it is not nice, and there is a race with systemd renaming the
interfaces using its naming rules. We need a way to lookup an
interface based on a bus location, or similar, not by name.

	  Andrew

From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 3 Dec 2018 20:00:47 +0100
Subject: [Intel-wired-lan] [PATCH net-next v3 1/2] ixgbe: register a
 mdiobus
In-Reply-To: <20181203185454.6357-2-stephend@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203185454.6357-1-stephend@silicom-usa.com>
 <20181203185454.6357-2-stephend@silicom-usa.com>
Message-ID: <20181203190047.GP25748@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 03, 2018 at 06:55:22PM +0000, Steve Douthit wrote:
> Most dsa devices expect a 'struct mii_bus' pointer to talk to switches
> via the MII interface.
> 
> While this works for dsa devices, it will not work safely with Linux
> PHYs in all configurations since the firmware of the ixgbe device may
> be polling some PHY addresses in the background.
> 
> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

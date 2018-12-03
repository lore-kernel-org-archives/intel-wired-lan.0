From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 3 Dec 2018 20:01:22 +0100
Subject: [Intel-wired-lan] [PATCH net-next v3 2/2] ixgbe: use mii_bus to
 handle MII related ioctls
In-Reply-To: <20181203185454.6357-3-stephend@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203185454.6357-1-stephend@silicom-usa.com>
 <20181203185454.6357-3-stephend@silicom-usa.com>
Message-ID: <20181203190122.GQ25748@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 03, 2018 at 06:55:26PM +0000, Steve Douthit wrote:
> Use the mii_bus callbacks to address the entire clause 22/45 address
> space.  Enables userspace to poke switch registers instead of a single
> PHY address.
> 
> The ixgbe firmware may be polling PHYs in a way that is not protected by
> the mii_bus lock.  This isn't new behavior, but as Andrew Lunn pointed
> out there are more addresses available for conflicts.
> 
> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

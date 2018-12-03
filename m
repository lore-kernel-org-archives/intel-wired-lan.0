From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 3 Dec 2018 11:07:59 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 2/2] ixgbe: use mii_bus to
 handle MII related ioctls
In-Reply-To: <20181203185454.6357-3-stephend@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203185454.6357-1-stephend@silicom-usa.com>
 <20181203185454.6357-3-stephend@silicom-usa.com>
Message-ID: <d2f6a079-058c-fc54-cb6b-77ca830d65af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/3/18 10:55 AM, Steve Douthit wrote:
> Use the mii_bus callbacks to address the entire clause 22/45 address
> space.  Enables userspace to poke switch registers instead of a single
> PHY address.
> 
> The ixgbe firmware may be polling PHYs in a way that is not protected by
> the mii_bus lock.  This isn't new behavior, but as Andrew Lunn pointed
> out there are more addresses available for conflicts.
> 
> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

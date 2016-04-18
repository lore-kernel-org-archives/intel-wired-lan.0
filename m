From: David Miller <davem@davemloft.net>
Date: Mon, 18 Apr 2016 00:03:58 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH] ixgbe: use msleep for long delays
In-Reply-To: <1460838941-1251989-1-git-send-email-arnd@arndb.de>
References: <1460838941-1251989-1-git-send-email-arnd@arndb.de>
Message-ID: <20160418.000358.1382874942962616205.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 16 Apr 2016 22:35:08 +0200

> The newly added x550em_a support causes a link failure on ARM because of
> an overly long time passed into udelay():
> 
> ERROR: "__bad_udelay" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
> 
> There are multiple variants of the ixgbe_acquire_swfw_sync_*() function,
> and the other ones all use msleep(), so we can safely assume that all
> callers are allowed to sleep, which makes msleep() a better replacement
> than mdelay().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")

I'm assuming Jeff will pick this up.

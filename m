From: David Miller <davem@davemloft.net>
Date: Tue, 24 Jan 2017 13:50:06 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH] net: intel: e1000: use new api
 ethtool_{get|set}_link_ksettings
In-Reply-To: <1485011163-7402-1-git-send-email-tremyfr@gmail.com>
References: <1485011163-7402-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20170124.135006.1371369423527179260.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sat, 21 Jan 2017 16:06:03 +0100

> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> As I don't have the hardware, I'd be very pleased if
> someone may test this patch.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

I am expecting the upstream Intel NIC folks to pick this up.

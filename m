From: David Miller <davem@davemloft.net>
Date: Sun, 12 Mar 2017 19:28:36 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH v2] net: intel: ixgbe: use new api
 ethtool_{get|set}_link_ksettings
In-Reply-To: <1488925945-32313-1-git-send-email-tremyfr@gmail.com>
References: <1488925945-32313-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20170312.192836.731724475972026446.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Philippe Reynes <tremyfr@gmail.com>
Date: Tue,  7 Mar 2017 23:32:25 +0100

> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> As I don't have the hardware, I'd be very pleased if
> someone may test this patch.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
> Changelog:
> v2:
> - fix compilation (thanks andrewx bowers)

Applied.

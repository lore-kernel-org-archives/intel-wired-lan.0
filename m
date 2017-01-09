From: David Miller <davem@davemloft.net>
Date: Mon, 09 Jan 2017 12:10:56 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH] net: intel: e100: use new api
 ethtool_{get|set}_link_ksettings
In-Reply-To: <1483827487-20355-1-git-send-email-tremyfr@gmail.com>
References: <1483827487-20355-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20170109.121056.1317727626572941687.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sat,  7 Jan 2017 23:18:07 +0100

> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.

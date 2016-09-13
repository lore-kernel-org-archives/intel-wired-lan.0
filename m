From: David Miller <davem@davemloft.net>
Date: Mon, 12 Sep 2016 20:28:45 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH 00/15] drivers: net: use IS_ENABLED()
 instead of checking for built-in or module
In-Reply-To: <1473689026-6983-1-git-send-email-javier@osg.samsung.com>
References: <1473689026-6983-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20160912.202845.1229112190826763502.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Mon, 12 Sep 2016 10:03:31 -0400

> This trivial series is similar to [0] for net/ that you already merged, but
> for drivers/net. The patches replaces the open coding to check for a Kconfig
> symbol being built-in or module, with IS_ENABLED() macro that does the same.

Series applied, thanks.

From: David Miller <davem@davemloft.net>
Date: Sun, 27 Sep 2020 13:57:07 -0700 (PDT)
Subject: [Intel-wired-lan] [patch 00/35] net: in_interrupt() cleanup and
 fixes
In-Reply-To: <20200927194846.045411263@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927.135707.1699954431349573308.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:48:46 +0200

> in the discussion about preempt count consistency accross kernel configurations:

Please respin this against net-next, some of the patches in here are already
in net-next (the wireless debug macro one) and even after that the series
doesn't build:

drivers/net/ethernet/cisco/enic/enic_main.c: In function ?enic_reset?:
drivers/net/ethernet/cisco/enic/enic_main.c:2315:2: error: implicit declaration of function ?enic_set_api_state?; did you mean ?enic_set_api_busy?? [-Werror=implicit-function-declaration]
 2315 |  enic_set_api_state(enic, true);
      |  ^~~~~~~~~~~~~~~~~~
      |  enic_set_api_busy
At top level:
drivers/net/ethernet/cisco/enic/enic_main.c:2298:13: warning: ?enic_set_api_busy? defined but not used [-Wunused-function]
 2298 | static void enic_set_api_busy(struct enic *enic, bool busy)
      |             ^~~~~~~~~~~~~~~~~

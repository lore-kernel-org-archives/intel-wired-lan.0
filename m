From: David Miller <davem@davemloft.net>
Date: Mon, 05 Oct 2015 03:17:04 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH 00/12] net: assorted y2038 changes
In-Reply-To: <1443612402-3000775-1-git-send-email-arnd@arndb.de>
References: <1443612402-3000775-1-git-send-email-arnd@arndb.de>
Message-ID: <20151005.031704.767722033063704258.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Sep 2015 13:26:30 +0200

> This is a set of changes for network drivers and core code to
> get rid of the use of time_t and derived data structures.

Applied patches #1-#10 to net-next, using the updated v2 version of
the zatm change.

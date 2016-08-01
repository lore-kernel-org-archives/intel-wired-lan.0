From: David Miller <davem@davemloft.net>
Date: Sun, 31 Jul 2016 20:45:23 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH 1/1] net: e1000: do not use
	uninitalized variable.
In-Reply-To: <1469957458-494-1-git-send-email-xypron.glpk@gmx.de>
References: <1469957458-494-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <20160731.204523.1618478478722431612.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Sun, 31 Jul 2016 11:30:58 +0200

> phy_data has to be set to zero to avoid undefined
> behavior.

In your opinion.

phy_data is only used in conditions where it has been initialized
in this function.

Therefore, please read the function carefully instead of just having
knee jerk reactions to whatever the compiler spits out.

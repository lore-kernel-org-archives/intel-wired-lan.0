From: zyjzyj2000@gmail.com <zyjzyj2000@gmail.com>
Date: Wed, 30 Dec 2015 17:16:32 +0800
Subject: [Intel-wired-lan] [PATCH V4] ixgbe: synchronize the link_speed and
	link_up of a slave interface
In-Reply-To: <53C6554C-8692-4EF3-BF5D-7217D2C9FDA0@intel.com>
References: <53C6554C-8692-4EF3-BF5D-7217D2C9FDA0@intel.com>
Message-ID: <1451466995-19015-1-git-send-email-zyjzyj2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Hi, all

According to Rustad, Mark D, maybe it is related with copper phy. To make fiber phy more
robust, synchronize both the link_up and link_speed of a slave interface in ixgbe driver.

Best Regards!
Zhu Yanjun

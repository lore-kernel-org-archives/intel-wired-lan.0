From: zyjzyj2000@gmail.com <zyjzyj2000@gmail.com>
Date: Thu, 24 Dec 2015 11:12:31 +0800
Subject: [Intel-wired-lan] [V2 PATCH 1/1] ixgbe: force to synchronize
	reporting "link on" and
In-Reply-To: <1450868046.3316.11.camel@intel.com>
References: <1450868046.3316.11.camel@intel.com>
Message-ID: <1450926752-11392-1-git-send-email-zyjzyj2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Hi, Jeff

Thanks for your reply.

Changes:
Since there is a time span between link_up and link_speed to X540 NIC, it is not appropriate to continue in the function ixgbe_watchdog_link_is_up if only link_up is ready.

Best Regards!
Zhu Yanjun

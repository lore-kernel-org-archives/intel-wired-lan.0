From: David Miller <davem@davemloft.net>
Date: Tue, 01 Dec 2015 21:27:00 -0500 (EST)
Subject: [Intel-wired-lan] [RFC 1/4] net: support per queue tx_usecs in
	sysfs
In-Reply-To: <20151201154454.000041a3@unknown>
References: <1448956892-15509-1-git-send-email-kan.liang@intel.com>
 <565E1B8E.4040603@gmail.com> <20151201154454.000041a3@unknown>
Message-ID: <20151201.212700.1291998408162014445.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 1 Dec 2015 15:44:54 -0800

> While I agree that ethtool provides a similar functionality, ethtool
> was designed (particularly the ethtool -C/c commands) around one queue
> NICs.  We can't change the output or functionality of the user
> interface without breaking a bunch of user's scripts and stuff.

See my suggestion, we can encapsulate existing ethtool commands inside
of a new command that specifies operations that are to be applied to
specific queues.

Do not use sysfs for this.

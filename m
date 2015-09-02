From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:26:06 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2] ixgbe support for
	ethtool	set_rxfh
In-Reply-To: <1435326018-6097-1-git-send-email-tom.barbette@ulg.ac.be>
References: <1435326018-6097-1-git-send-email-tom.barbette@ulg.ac.be>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B568E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Tom Barbette
Sent: Friday, June 26, 2015 6:40 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [net-next PATCH v2] ixgbe support for ethtool set_rxfh

Allows to change the rxfh indirection table and/or key using  ethtool interface.

V2: added checks for maximum number of queues per MAC type.

Signed-off-by: Tom Barbette <tom.barbette@ulg.ac.be>
---

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>


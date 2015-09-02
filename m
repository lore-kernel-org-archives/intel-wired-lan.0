From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 22:38:19 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Assign set_phy_power
 dynamically where needed.
In-Reply-To: <20150611004230.18302.56111.stgit@dcs-desk.jf.intel.com>
References: <20150611004230.18302.56111.stgit@dcs-desk.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5C49@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Donald C Skidmore
Sent: Wednesday, June 10, 2015 5:43 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Assign set_phy_power dynamically where needed.

There are various reasons why this method may or may not need to be defined and some of these we don't know until runtime.  So we will set the value in get_invariants.

Signed-off-by: Donald C Skidmore <donald.c.skidmore@intel.com>
---
 
Tested-By: Krishneil Singh <Krishneil.k.singh@intel.com>



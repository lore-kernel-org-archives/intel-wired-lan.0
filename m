From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:24:48 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Remove second
 instance of	lan_id variable
In-Reply-To: <20150619162336.23319.95448.stgit@dcs-desk.jf.intel.com>
References: <20150619162336.23319.95448.stgit@dcs-desk.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5672@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Donald C Skidmore
Sent: Friday, June 19, 2015 9:24 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Remove second instance of lan_id variable

This patch removes the redundant lan_id in the phy struct and uses the bus version.  Both variables exist and intend to represent the STATUS register LAN_ID field.  However, phy.lan_id is not bit shifted so the phy.lan_id = 0x0 for LAN Id 0 and phy.lan_id = 0x4 for LAN Id 1.
Where bus.lan_id is bit shifted so bus.lan_id = 0x0 for LAN Id 0 and bus.lan_id = 0x1 for LAN Id 1. There seems no need for the additional lan_id variable and this should make the code less confusing.

Signed-off-by: Donald C Skidmore <donald.c.skidmore@intel.com>
---
 
Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>


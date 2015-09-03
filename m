From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 3 Sep 2015 18:37:52 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Add fdir support for
 SCTP	on X550
In-Reply-To: <20150624210330.19338.45485.stgit@dcs-desk.jf.intel.com>
References: <20150624210330.19338.45485.stgit@dcs-desk.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5FC6@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Donald C Skidmore
Sent: Wednesday, June 24, 2015 2:04 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Add fdir support for SCTP on X550

X550 has HW support for SCTP flow director filters SCTP mask. This patch adds it like we do for UDP and TCP.

Signed-off-by: Donald C Skidmore <donald.c.skidmore@intel.com>
---

Tested-By: Krishneil Singh <Krishneil.k.singh@intel.com>
 


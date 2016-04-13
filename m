From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:43:06 +0000
Subject: [Intel-wired-lan] [PATCH v2 4/4] fm10k: fix incorrect IPv6
 extended	header checksum
In-Reply-To: <1460044373-32747-1-git-send-email-jacob.e.keller@intel.com>
References: <1460044373-32747-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27371510@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, April 7, 2016 8:53 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 4/4] fm10k: fix incorrect IPv6 extended header checksum

Check for and handle IPv6 extended headers so that tx checksum offload can be done. Also use skb_checksum_help for unexpected cases. This was originally discovered in ixgbe.

Reported-by: Mark Rustad <mark.d.rustad@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


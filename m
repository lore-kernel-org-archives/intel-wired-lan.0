From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 4 Nov 2015 18:05:49 +0000
Subject: [Intel-wired-lan] [next-queue v2] fm10k: consistently refer
	to	VLANs and VLAN IDs
In-Reply-To: <1446495022-30852-1-git-send-email-jacob.e.keller@intel.com>
References: <1446495022-30852-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27226374@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, November 2, 2015 12:10 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue v2] fm10k: consistently refer to VLANs and VLAN IDs

Instead of using lowercase vlan, vid, or VID, always use VLAN or VLAN ID in comments when referring to VLANs. The original driver code was consistent, but recent patches have not been as consistent with this naming scheme.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
---
-v2
* fix two forgotten instances in fm10k_pf.c

This patch replaces what was on the queue in place.


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


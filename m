From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:17:17 +0000
Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: only prevent removal
	of	default VID rules
In-Reply-To: <1434405656-10465-3-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
 <1434405656-10465-3-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B55CA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, June 15, 2015 3:01 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: only prevent removal of default VID rules

This allows us to correctly add a VLAN even if it matches our default VID. However, we don't want to remove the VID rules once that VLAN is deleted. Correctly remove the stack layers information of the VLAN, but then return to forwarding that VID as untagged frames. If we deleted the VID rules here, we would begin dropping traffic due to VLAN membership violations.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:14:23 +0000
Subject: [Intel-wired-lan] [rc2 15/15] fm10k: fix
	iov_msg_lport_state_pf	issue
In-Reply-To: <1433374272-6684-16-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
 <1433374272-6684-16-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B555A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, June 3, 2015 4:31 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [rc2 15/15] fm10k: fix iov_msg_lport_state_pf issue

When a VF issues an LPORT_STATE request to enable a port that is already enabled, the PF will first disable the VF LPORT. Then it should re-enable the VF again with the new requested settings. This ensures that any switch rules are cleared by deleting the LPORT on the switch.
However, the flow is bugged because we actually check if the VF is enabled at the end, and thus don't re-enable it. Fix the flow so that we actually clear the enabled flags as part of our removal of the LPORT.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:28:29 +0000
Subject: [Intel-wired-lan] [PATCH net] fm10k: fix multi-bit VLAN
	update	requests from VF
In-Reply-To: <1459443150-3461-1-git-send-email-jacob.e.keller@intel.com>
References: <1459443150-3461-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273713F2@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, March 31, 2016 9:53 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH net] fm10k: fix multi-bit VLAN update requests from VF

The VF uses a multi-bit update request to clear unused VLANs whenever it resets. However, an accident in a previous refector broke multi-bit updates for VFs, due to misreading a comment in fm10k_vf.c and attempting to reduce code duplication. The problem occurs because a multi-bit request has a non-zero length, and the PF would simply drop any request with the upper 16 bits set.

We can't simply remove the check of the upper 16 bits and the call to fm10k_iov_select vid, because this would remove the checks for default VID and for ensuring no other VLANs can be enabled except pf_vid when it has been set. To resolve that issue, this revision uses the iov_select_vid when we have a single-bit update, and denies any multi-bit update when the VLAN was administratively set by the PF. This should be ok since the PF properly updates VLAN_TABLE when it assigns the PF vid. This ensures that requests to add or remove the PF vid work as expected, but a rogue VF could not use the multi-bit update as a loophole to attempt receiving traffic on other VLANs.

Reported-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


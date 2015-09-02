From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:06:06 +0000
Subject: [Intel-wired-lan] [rc2 01/15] fm10k: ignore invalid
	multicast	address entries
In-Reply-To: <1433374272-6684-2-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
 <1433374272-6684-2-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B542F@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, June 3, 2015 4:31 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
Subject: [Intel-wired-lan] [rc2 01/15] fm10k: ignore invalid multicast address entries

This change fixes an issue with adding an invalid multicast address using the iproute2 tool (ip maddr add <MADDR> dev <dev>). The iproute2 tool and the kernel do not validate or filter the multicast addresses when adding them to the multicast list. Thus, when synchronizing this list with an invalid entry, the action will be aborted with an error since the fm10k driver currently validates the list. Consequently, multicast entries beyond the invalid one will not be processed and communicated with the switch via the mailbox. This change makes it so that invalid addresses will simply be skipped and allows synchronizing the full list to proceed.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

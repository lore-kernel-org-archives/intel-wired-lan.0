From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 01:58:25 +0000
Subject: [Intel-wired-lan] [PATCH 5/6] fm10k: update fm10k_slot_warn to
 use	pcie_get_minimum link
In-Reply-To: <1434405656-10465-5-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
 <1434405656-10465-5-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B534B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, June 15, 2015 3:01 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 5/6] fm10k: update fm10k_slot_warn to use pcie_get_minimum link

This is useful in cases where we connect to a slot at Gen3, but the slot is behind a bus which only connected at Gen2. This generally only happens when a PCIe switch is in the sequence of devices, and can be very confusing when you see slow performance with no obvious cause.

I am aware this patch has a few lines that break 80 characters, but there does not seem to be a readable way to format them to less than 80 characters. Suggestions welcome.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 105 +++++++++++++++++++--------
 1 file changed, 76 insertions(+), 29 deletions(-)

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 01:55:44 +0000
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: disable service task
 during	suspend
In-Reply-To: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5308@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, June 15, 2015 3:01 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: disable service task during suspend

The service task reads some registers as part of its normal routine, even while the interface is down. Normally this is ok. However, during suspend we have disabled the PCI device. Due to this, registers will read in the same way as a surprise-remove event. Disable the service task while we suspend, and re-enable it after we resume. If we don't do this, the device could be UP when you suspend and come back from resume as closed (since fm10k closes the device when it gets a surprise remove).

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

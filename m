From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Feb 2016 20:23:53 +0000
Subject: [Intel-wired-lan] [PATCH 5/6] fm10k: free mbx irq before
 clearing	interrupt scheme
In-Reply-To: <1454611679-17424-5-git-send-email-jacob.e.keller@intel.com>
References: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
 <1454611679-17424-5-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2734A8F9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, February 4, 2016 10:48 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 5/6] fm10k: free mbx irq before clearing interrupt scheme

During fm10k_io_error_detected we were clearing the interrupt scheme before we freed the mbx IRQ. This causes a kernel panic because the mbx IRQ are assigned after MSI-X initialization. Clearing the interrupt scheme results in removing the MSI-X entry table. Fix this by freeing the mbx IRQ before we clear the interrupt scheme, as we do elsewhere in the driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

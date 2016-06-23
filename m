From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:27:33 +0000
Subject: [Intel-wired-lan] [PATCH v2 11/18] fm10k: implement
 reset_notify	handler for PCIe FLR events
In-Reply-To: <20160607230902.5457-12-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-12-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397F38@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 11/18] fm10k: implement reset_notify handler for PCIe FLR events

When a function level PCI reset is triggered using sysfs, it calls the driver's .reset_notify error handler. Implement a handler based on the now split fm10k_prepare_for_reset and fm10k_handle_reset functions, so that we fully reset the driver when the PCI function level reset occurs.
This also ensures the reset is handled in a clean way by first disabling all the driver bits first and then restoring them after the function reset. Previously the stack simply performed a blind function reset and our driver didn't take any part in the process.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


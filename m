From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:19:02 +0000
Subject: [Intel-wired-lan] [PATCH v2 02/18] fm10k: Reset mailbox
	global	interrupts
In-Reply-To: <20160607230902.5457-3-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-3-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397E7E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
Subject: [Intel-wired-lan] [PATCH v2 02/18] fm10k: Reset mailbox global interrupts

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

When a data path reset is initiated, write control to the PCIE_GMBX is yanked from the switch manager. The switch manager writes to this register to clear mailbox global interrupt bits as part of its mailbox interrupt handling routine. When the device recovers from the data path reset and these bits are not cleared, it will prevent future mailbox global interrupts from being triggered. Upon confirming that the device has exited from a data path reset, clear these bits to ensure the proper functioning of the mailbox global interrupt.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>




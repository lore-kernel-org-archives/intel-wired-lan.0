From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:26:41 +0000
Subject: [Intel-wired-lan] [PATCH v2 10/18] fm10k: use common reset
	flow	when handling io errors from PCI stack
In-Reply-To: <20160607230902.5457-11-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-11-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397F23@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 10/18] fm10k: use common reset flow when handling io errors from PCI stack

Now that we have extracted the necessary steps for a split suspend/resume flow, re-use these functions instead of using the current open coded flow. This ensures that we don't miss any steps. It also ensures that we have the correct driver states set.

Since we'll be handling all of the reset flow ourselves, we no longer need to request a reset in the io_slot_reset() function.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



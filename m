From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 24 Aug 2016 23:01:43 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: don't continue probe if
	PCI	device not in normal IO state
In-Reply-To: <20160623203103.30528-2-jacob.e.keller@intel.com>
References: <20160623203103.30528-1-jacob.e.keller@intel.com>
 <20160623203103.30528-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273B8EBD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, June 23, 2016 1:31 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2] fm10k: don't continue probe if PCI device not in normal IO state

In the event of an uncorrectable AER error occuring when the driver has not loaded, the recovery routines are not done. This is done because future loads of the driver may not be aware of the IO state and may not be able to recover at all. In this case, when we next load the driver it fails due to what appears to be a surprise remove event. Instead, add a check to ensure that the device is in the normal IO state before continuing to probe. This allows us to give a more descriptive message of what is wrong.

Without this change, the driver will attempt to probe up to our first call of .reset_hw() which will be unable to read registers and act as if a surprise remove event occurred.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:20:40 +0000
Subject: [Intel-wired-lan] [PATCH v2 04/18] fm10k: perform data path
 reset	even when switch is not ready
In-Reply-To: <20160607230902.5457-5-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-5-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397EA7@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 04/18] fm10k: perform data path reset even when switch is not ready

A while ago, an additional check for the switch being ready was added to reset_hw. A recent refactor accidentally made this check return an error code on failure which caused fm10k_probe to fail when the switch wasn't brought up first. The original reasoning for the check was to prevent additional data path reset when the fabric wasn't ready yet. However, there isn't a compelling reason to keep the check, as the data path reset will restore hardware to a known good state. Remove the check and perform the data path reset regardless of the switch manager state.

An alternative fix is to return FM10K_SUCCESS instead, and bypass the actual data path reset. This should be fine as we will perform a reset_hw once the switch is active. However, since data path reset will reset many parts of the hardware it seems better to just perform the reset regardless of switch state.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>




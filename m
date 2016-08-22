From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 22 Aug 2016 22:47:15 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/2] fm10k: don't clear the
	RXQCTL	register when enabling or disabling queues
In-Reply-To: <20160803220528.26222-1-jacob.e.keller@intel.com>
References: <20160803220528.26222-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273B82ED@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, August 3, 2016 3:05 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 1/2] fm10k: don't clear the RXQCTL register when enabling or disabling queues

Ensure that other bits in the RXQCTL register do not get cleared. This ensures that bits related to queue ownership are maintained.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


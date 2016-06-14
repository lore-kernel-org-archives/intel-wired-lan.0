From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Jun 2016 16:44:44 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: don't use BIT() macro where
 the	value isn't a bitmask
In-Reply-To: <1460665047-24907-1-git-send-email-jacob.e.keller@intel.com>
References: <1460665047-24907-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273954B7@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, April 14, 2016 1:17 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH] fm10k: don't use BIT() macro where the value isn't a bitmask

The FM10K_MAX_DATA_PER_TXD is really just using a bitshift as a power of
2 operation in an efficient manner. We shouldn't represent this as a BIT() because that obscures the intention of the operation.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



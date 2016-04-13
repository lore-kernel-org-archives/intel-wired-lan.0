From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:32:38 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/9] fm10k: drop 1588 support
In-Reply-To: <1459552659-22959-2-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
 <1459552659-22959-2-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27371422@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, April 1, 2016 4:18 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 1/9] fm10k: drop 1588 support

The 1588 support within fm10k does not work correctly with the current version of the switch management software, and likely never worked correctly to begin with. Remove support for PTP/1588. Update copyright year for all these files while we're touching them.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


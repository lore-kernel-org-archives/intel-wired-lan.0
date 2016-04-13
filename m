From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:24:49 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use DRV_SUMMARY to reduce
 code	duplication
In-Reply-To: <1457570168-30798-2-git-send-email-jacob.e.keller@intel.com>
References: <1457570168-30798-1-git-send-email-jacob.e.keller@intel.com>
 <1457570168-30798-2-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273713C9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, March 9, 2016 4:36 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use DRV_SUMMARY to reduce code duplication

Use DRV_SUMMARY, similar to DRV_VERSION so that we don't have to duplicate the driver summary in multiple places.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 28 Oct 2015 22:44:39 +0000
Subject: [Intel-wired-lan] [next-queue v5 12/17] fm10k:
	introduce	ITR_IS_ADAPTIVE macro
In-Reply-To: <1445018231-3196-12-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-12-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27221EFB@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, October 16, 2015 10:57 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue v5 12/17] fm10k: introduce ITR_IS_ADAPTIVE macro

Define a macro for identifying when the itr value is dynamic or adaptive. The concept was taken from i40e. This helps make clear what the check is, and reduces the line length to something more reasonable in a few places.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>



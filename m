From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 3 Nov 2015 20:51:34 +0000
Subject: [Intel-wired-lan] [next-queue v3 01/17] fm10k:
	conditionally	compile DCB and DebugFS support
In-Reply-To: <1444944297-9733-1-git-send-email-jacob.e.keller@intel.com>
References: <1444944297-9733-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27225E9D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, October 15, 2015 2:25 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue v3 01/17] fm10k: conditionally compile DCB and DebugFS support

Rather than wrapping fm10k_dcbnl.c and fm10k_debugfs.c support with  #ifdef blocks, just conditionally include the .o files in the Makefile.
 Also, since we're modifying it, update the copyright year on the  Makefile.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



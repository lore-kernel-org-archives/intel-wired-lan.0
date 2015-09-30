From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 30 Sep 2015 18:55:23 +0000
Subject: [Intel-wired-lan] [next-queue v2] fm10k: Correct MTU for
	jumbo	frames
In-Reply-To: <1440535751-12074-1-git-send-email-jacob.e.keller@intel.com>
References: <1440535751-12074-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271CEB55@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, August 25, 2015 1:49 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue v2] fm10k: Correct MTU for jumbo frames

Based on hardware testing, the host interface supports up to 15368 bytes as the maximum frame size. To determine the correct MTU, we subtract 8 for the internal switch tag, 14 for the L2 header, and 4 for the appended FCS header, resulting in 15342 bytes of payload for our maximum MTU on jumbo frames.

Signed-off-by: Matthew Vick <matthew.vick@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>





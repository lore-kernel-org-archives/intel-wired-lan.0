From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 9 Nov 2015 22:40:23 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v2] fm10k: cleanup
 namespace	pollution
In-Reply-To: <20151029001951.19165.58910.stgit@bwallan-cwp1.jf.intel.com>
References: <20151029001951.19165.58910.stgit@bwallan-cwp1.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27232C05@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bruce Allan
Sent: Wednesday, October 28, 2015 5:20 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next-queue PATCH v2] fm10k: cleanup namespace pollution

Make functions that should be static.  While we're at it, fix the function header comment for fm10k_tlv_attr_nest_stop(), and update the copyright header for fm10k_pf.h, fm10k_tlv.c and fm10k_tlv.h.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:38:02 +0000
Subject: [Intel-wired-lan] [PATCH v1 6/9] fm10k: use 8bit notation
 instead	of 10bit notation for diagram
In-Reply-To: <1459552659-22959-7-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
 <1459552659-22959-7-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27371497@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, April 1, 2016 4:18 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 6/9] fm10k: use 8bit notation instead of 10bit notation for diagram

The diagram represents bit layout of the multi-bit VLAN update message format. Typically these diagrams are drawn using some power of 2 as the base, to more easily grasp where fields split. Although the numbers above can make it somewhat easy to understand which bit you're looking at, it makes the break points not line up. Re-draw the numbers using base 8, and mark the bit values every 8 bits at the top. This should make it more easy to grasp the table quickly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


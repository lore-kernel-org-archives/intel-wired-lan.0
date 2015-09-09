From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 9 Sep 2015 19:43:53 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add flow control ethertype to
 the anti-spoofing filter
In-Reply-To: <20150820223120.30599.99286.stgit@localhost6.localdomain6>
References: <20150820223120.30599.99286.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271BC292@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Emil Tantilov
Sent: Thursday, August 20, 2015 3:31 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: add flow control ethertype to the anti-spoofing filter

This patch makes sure that flow control packets initiated by the VF are dropped and reported as spoofed.

Flow control packets can be used to limit the throughput or as DOS attack when generated from a VF. Flow control is not supported per VF hence any pause frames generated from a VF are considered malicious.

Also cleaned up indentation and some redundant comments.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   16 +++++++++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    4 ++++
 2 files changed, 15 insertions(+), 5 deletions(-)

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

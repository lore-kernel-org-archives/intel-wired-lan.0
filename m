From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 3 Nov 2016 01:02:31 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: ixgbe_atr() compute
 l4_proto	only if non-paged data has network/transport headers
In-Reply-To: <1477348599-30723-2-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1477348599-30723-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1477348599-30723-2-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E43A38@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jeff Kirsher
Sent: Monday, October 24, 2016 3:37 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: ixgbe_atr() compute l4_proto only if non-paged data has network/transport headers

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

For some Tx paths (e.g., tpacket_snd()), ixgbe_atr may be passed down an sk_buff that has the network and transport header in the paged data, so it needs to make sure these headers are available in the headlen bytes to calculate the l4_proto.

This patch expect that network and transport headers are already available in the non-paged header dat.  The assumption is that the caller has set this up if l4_proto based Tx steering is desired.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>





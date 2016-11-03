From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 3 Nov 2016 01:01:34 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: ixgbe_atr() should
	access	udp_hdr(skb) only for UDP packets
In-Reply-To: <1477348599-30723-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1477348599-30723-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E43A2A@ORSMSX103.amr.corp.intel.com>
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
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: ixgbe_atr() should access udp_hdr(skb) only for UDP packets

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

Commit 9f12df906cd8 ("ixgbe: Store VXLAN port number in network order") incorrectly checks for hdr.ipv4->protocol != IPPROTO_UDP in ixgbe_atr(). This check should be for "==" instead.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


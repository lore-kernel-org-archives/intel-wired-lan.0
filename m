From: David Miller <davem@davemloft.net>
Date: Sat, 17 Mar 2018 16:57:46 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH 0/5] Enable XDP for ixgbevf
In-Reply-To: <20180316223406.7295-1-anthony.l.nguyen@intel.com>
References: <20180316223406.7295-1-anthony.l.nguyen@intel.com>
Message-ID: <20180317.165746.11352895395829724.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 16 Mar 2018 15:34:01 -0700

> This patch series implements support for XDP on ixgbevf;
> it is mainly based on the ixgbe implementation and supports
> the following actions: XDP_PASS, XDP_DROP, and XDP_TX.

I'm extremely pleased to see these patches.

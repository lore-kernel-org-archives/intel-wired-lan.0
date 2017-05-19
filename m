From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 19 May 2017 22:16:44 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent driver configuration
 changes while XDP is loaded
In-Reply-To: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
References: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E5966BBD6@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>




-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of John Fastabend
Sent: Monday, May 1, 2017 10:07 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent driver configuration changes while XDP is loaded

XDP checks to ensure the MTU is valid and LRO is disabled when it is loaded. But user configuration after XDP is loaded could change these and cause a misconfiguration.

This patch adds checks to ensure config changes are valid.

Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---

With this patch applied, we are seeing issue where setting initial MTU >= 1515 fails with Error: Setting MTU > 1536 with XDP is not supported, but setting MTU to 1514  , we can now set MTU till 3050. If we set anything greater than 3050 it errors out with the following message: Setting MTU > 3072 with XDP is not supported.

Is there a way to see if XDP is enabled and is XDP is supposed to be enabled by default on ixgbe ? only info about XDP seen on platform is in dmesg as follows. 

[    3.267909] ixgbe 0000:04:00.0: Multiqueue Enabled: Rx Queue count = 12, Tx Queue count = 12 XDP Queue count = 0
[    3.724686] ixgbe 0000:04:00.1: Multiqueue Enabled: Rx Queue count = 12, Tx Queue count = 12 XDP Queue count = 0
[    4.186271] ixgbe 0000:06:00.0: Multiqueue Enabled: Rx Queue count = 12, Tx Queue count = 12 XDP Queue count = 0
[    4.644388] ixgbe 0000:06:00.1: Multiqueue Enabled: Rx Queue count = 12, Tx Queue count = 12 XDP Queue count = 0

When using latest iproute2 tool to disable xdp ( ip link set ethX xdp off) , there is no error reported by iproute2 and nothing is reported in dmesg but we were still unable to set MTU > = 3051.

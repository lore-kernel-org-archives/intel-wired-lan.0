From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 22 May 2015 23:33:55 +0000
Subject: [Intel-wired-lan] [net-next PATCH v4 1/2] ethtool: Add helper
 routines to pass vf to rx_flow_spec
In-Reply-To: <20150518161847.8927.65430.stgit@nitbit.x32>
References: <20150518161847.8927.65430.stgit@nitbit.x32>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2717054C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of John Fastabend
Sent: Monday, May 18, 2015 9:19 AM
To: alexander.h.duyck@redhat.com
Cc: intel-wired-lan at lists.osuosl.org
Subject: [Intel-wired-lan] [net-next PATCH v4 1/2] ethtool: Add helper routines to pass vf to rx_flow_spec

The ring_cookie is 64 bits wide which is much larger than can be used for actual queue index values. So provide some helper routines to pack a VF index into the cookie. This is useful to steer packets to a VF ring without having to know the queue layout of the device.

Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---
 include/uapi/linux/ethtool.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h index 2e49fc8..b5b4287 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h

Tested-by:  Krishneil Singh <Krishneil.k.singh@intel.com>




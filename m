From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed,  7 Nov 2018 21:40:17 -0800
Subject: [Intel-wired-lan] [net-next v1 1/2] docs-networking: fix typo in
 define
Message-ID: <20181108054018.32293-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The #define for NETIF_F_GSO_UDP_L4 was incorrect in the
documentation, fix it by making it match the actual code.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 Documentation/networking/netdev-features.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/netdev-features.txt b/Documentation/networking/netdev-features.txt
index c4a54c162547..58dd1c1e3c65 100644
--- a/Documentation/networking/netdev-features.txt
+++ b/Documentation/networking/netdev-features.txt
@@ -115,7 +115,7 @@ set, be it TCPv4 (when NETIF_F_TSO is enabled) or TCPv6 (NETIF_F_TSO6).
 
  * Transmit UDP segmentation offload
 
-NETIF_F_GSO_UDP_GSO_L4 accepts a single UDP header with a payload that exceeds
+NETIF_F_GSO_UDP_L4 accepts a single UDP header with a payload that exceeds
 gso_size. On segmentation, it segments the payload on gso_size boundaries and
 replicates the network and UDP headers (fixing up the last one if less than
 gso_size).
-- 
2.19.1


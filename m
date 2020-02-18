From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 18 Feb 2020 20:56:41 +0100
Subject: [Intel-wired-lan] [PATCH net-next v2 01/13] net: core: add helper
 tcp_v6_gso_csum_prep
In-Reply-To: <fffc8b6d-68ed-7501-18f1-94cf548821fb@gmail.com>
References: <fffc8b6d-68ed-7501-18f1-94cf548821fb@gmail.com>
Message-ID: <82ba1653-6a88-edf2-b22f-938b64e46655@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Several network drivers for chips that support TSO6 share the same code
for preparing the TCP header, so let's factor it out to a helper.
A difference is that some drivers reset the payload_len whilst others
don't do this. This value is overwritten by TSO anyway, therefore
the new helper resets it in general.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/net/ip6_checksum.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/ip6_checksum.h b/include/net/ip6_checksum.h
index 7bec95df4..27ec612cd 100644
--- a/include/net/ip6_checksum.h
+++ b/include/net/ip6_checksum.h
@@ -76,6 +76,15 @@ static inline void __tcp_v6_send_check(struct sk_buff *skb,
 	}
 }
 
+static inline void tcp_v6_gso_csum_prep(struct sk_buff *skb)
+{
+	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+	struct tcphdr *th = tcp_hdr(skb);
+
+	ipv6h->payload_len = 0;
+	th->check = ~tcp_v6_check(0, &ipv6h->saddr, &ipv6h->daddr, 0);
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 static inline void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb)
 {
-- 
2.25.1



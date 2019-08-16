From: Tom Herbert <tom@herbertland.com>
Date: Fri, 16 Aug 2019 14:53:40 -0700
Subject: [Intel-wired-lan] [PATCH v2 net-next 3/7] ipeh: Generic TLV parser
In-Reply-To: <1565992424-22379-1-git-send-email-tom@herbertland.com>
References: <1565992424-22379-1-git-send-email-tom@herbertland.com>
Message-ID: <1565992424-22379-4-git-send-email-tom@herbertland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tom Herbert <tom@quantonium.net>

Create a generic TLV parser. This will be used with various
extension headers that carry options including Destination,
Hop-by-Hop, Segment Routing TLVs, and other cases of simple
stateless parsing.

Signed-off-by: Tom Herbert <tom@quantonium.net>
Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/ipeh.h        |  25 ++++++++
 net/ipv6/exthdrs.c        | 159 +++++++++++-----------------------------------
 net/ipv6/exthdrs_common.c | 114 +++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 121 deletions(-)

diff --git a/include/net/ipeh.h b/include/net/ipeh.h
index 31e13f5..724d5b6 100644
--- a/include/net/ipeh.h
+++ b/include/net/ipeh.h
@@ -28,4 +28,29 @@ struct ipv6_txoptions *ipeh_renew_options(struct sock *sk,
 struct ipv6_txoptions *ipeh_fixup_options(struct ipv6_txoptions *opt_space,
 					  struct ipv6_txoptions *opt);
 
+/* Generic extension header TLV parser */
+
+enum ipeh_parse_errors {
+	IPEH_PARSE_ERR_PAD1,		/* Excessive PAD1 */
+	IPEH_PARSE_ERR_PADN,		/* Excessive PADN */
+	IPEH_PARSE_ERR_PADNZ,		/* Non-zero padding data */
+	IPEH_PARSE_ERR_EH_TOOBIG,	/* Length of EH exceeds limit */
+	IPEH_PARSE_ERR_OPT_TOOBIG,	/* Option size exceeds limit */
+	IPEH_PARSE_ERR_OPT_TOOMANY,	/* Option count exceeds limit */
+	IPEH_PARSE_ERR_OPT_UNK_DISALW,	/* Unknown option disallowed */
+	IPEH_PARSE_ERR_OPT_UNK,		/* Unknown option */
+};
+
+/* The generic TLV parser assumes that the type value of PAD1 is 0, and PADN
+ * is 1. This is true for Destination, Hop-by-Hop and current definition
+ * of Segment Routing TLVs.
+ */
+#define IPEH_TLV_PAD1	0
+#define IPEH_TLV_PADN	1
+
+bool ipeh_parse_tlv(const struct tlvtype_proc *procs, struct sk_buff *skb,
+		    int max_count, int off, int len,
+		    bool (*parse_error)(struct sk_buff *skb,
+					int off, enum ipeh_parse_errors error));
+
 #endif /* _NET_IPEH_H */
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index e12d3a5..939d27c 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -54,135 +54,50 @@
   Generic functions
  *********************/
 
-/* An unknown option is detected, decide what to do */
-
-static bool ip6_tlvopt_unknown(struct sk_buff *skb, int optoff,
-			       bool disallow_unknowns)
+/* Handle parse errors from ipeh generic TLV parser */
+static bool ipv6_parse_error(struct sk_buff *skb, int off,
+			     enum ipeh_parse_errors error)
 {
-	if (disallow_unknowns) {
-		/* If unknown TLVs are disallowed by configuration
-		 * then always silently drop packet. Note this also
-		 * means no ICMP parameter problem is sent which
-		 * could be a good property to mitigate a reflection DOS
-		 * attack.
-		 */
-
-		goto drop;
-	}
-
-	switch ((skb_network_header(skb)[optoff] & 0xC0) >> 6) {
-	case 0: /* ignore */
-		return true;
-
-	case 1: /* drop packet */
-		break;
-
-	case 3: /* Send ICMP if not a multicast address and drop packet */
-		/* Actually, it is redundant check. icmp_send
-		   will recheck in any case.
-		 */
-		if (ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr))
+	switch (error) {
+	case IPEH_PARSE_ERR_OPT_UNK_DISALW:
+		/* Disallow unknown skip */
+		if (((skb_network_header(skb)[off] & 0xC0) >> 6) == 0) {
+			/* Silent drop */
 			break;
+		}
 		/* fall through */
-	case 2: /* send ICMP PARM PROB regardless and drop packet */
-		icmpv6_param_prob(skb, ICMPV6_UNK_OPTION, optoff);
-		return false;
-	}
-
-drop:
-	kfree_skb(skb);
-	return false;
-}
+	case IPEH_PARSE_ERR_OPT_UNK:
+		switch ((skb_network_header(skb)[off] & 0xC0) >> 6) {
+		case 0: /* ignore */
+			return true;
 
-/* Parse tlv encoded option header (hop-by-hop or destination) */
-
-static bool ip6_parse_tlv(const struct tlvtype_proc *procs,
-			  struct sk_buff *skb,
-			  int max_count)
-{
-	int len = (skb_transport_header(skb)[1] + 1) << 3;
-	const unsigned char *nh = skb_network_header(skb);
-	int off = skb_network_header_len(skb);
-	const struct tlvtype_proc *curr;
-	bool disallow_unknowns = false;
-	int tlv_count = 0;
-	int padlen = 0;
-
-	if (unlikely(max_count < 0)) {
-		disallow_unknowns = true;
-		max_count = -max_count;
-	}
-
-	if (skb_transport_offset(skb) + len > skb_headlen(skb))
-		goto bad;
-
-	off += 2;
-	len -= 2;
-
-	while (len > 0) {
-		int optlen = nh[off + 1] + 2;
-		int i;
-
-		switch (nh[off]) {
-		case IPV6_TLV_PAD1:
-			optlen = 1;
-			padlen++;
-			if (padlen > 7)
-				goto bad;
+		case 1: /* drop packet */
 			break;
 
-		case IPV6_TLV_PADN:
-			/* RFC 2460 states that the purpose of PadN is
-			 * to align the containing header to multiples
-			 * of 8. 7 is therefore the highest valid value.
-			 * See also RFC 4942, Section 2.1.9.5.
-			 */
-			padlen += optlen;
-			if (padlen > 7)
-				goto bad;
-			/* RFC 4942 recommends receiving hosts to
-			 * actively check PadN payload to contain
-			 * only zeroes.
+		case 3: /* Send ICMP if not a multicast address and drop packet
+			 *
+			 * Actually, it is redundant check. icmp_send
+			 * will recheck in any case.
 			 */
-			for (i = 2; i < optlen; i++) {
-				if (nh[off + i] != 0)
-					goto bad;
-			}
-			break;
+			if (ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr))
+				break;
 
-		default: /* Other TLV code so scan list */
-			if (optlen > len)
-				goto bad;
-
-			tlv_count++;
-			if (tlv_count > max_count)
-				goto bad;
-
-			for (curr = procs; curr->type >= 0; curr++) {
-				if (curr->type == nh[off]) {
-					/* type specific length/alignment
-					   checks will be performed in the
-					   func(). */
-					if (curr->func(skb, off) == false)
-						return false;
-					break;
-				}
-			}
-			if (curr->type < 0 &&
-			    !ip6_tlvopt_unknown(skb, off, disallow_unknowns))
-				return false;
-
-			padlen = 0;
+			/* fall through */
+		case 2: /* send ICMP PARM PROB regardless and drop packet */
+			icmpv6_send(skb, ICMPV6_PARAMPROB,
+				    ICMPV6_UNK_OPTION, off);
 			break;
 		}
-		off += optlen;
-		len -= optlen;
+		break;
+	default:
+		break;
 	}
 
-	if (len == 0)
-		return true;
-bad:
-	kfree_skb(skb);
+	/* Will be dropping packet */
+
+	__IP6_INC_STATS(dev_net(skb->dev), __in6_dev_get(skb->dev),
+			IPSTATS_MIB_INHDRERRORS);
+
 	return false;
 }
 
@@ -216,8 +131,9 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	dstbuf = opt->dst1;
 #endif
 
-	if (ip6_parse_tlv(tlvprocdestopt_lst, skb,
-			  init_net.ipv6.sysctl.max_dst_opts_cnt)) {
+	if (ipeh_parse_tlv(tlvprocdestopt_lst, skb,
+			   init_net.ipv6.sysctl.max_dst_opts_cnt,
+			   2, extlen - 2, ipv6_parse_error)) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 #if IS_ENABLED(CONFIG_IPV6_MIP6)
@@ -639,8 +555,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 		goto fail_and_free;
 
 	opt->flags |= IP6SKB_HOPBYHOP;
-	if (ip6_parse_tlv(tlvprochopopt_lst, skb,
-			  init_net.ipv6.sysctl.max_hbh_opts_cnt)) {
+	if (ipeh_parse_tlv(tlvprochopopt_lst, skb,
+			   init_net.ipv6.sysctl.max_hbh_opts_cnt,
+			   2, extlen - 2, ipv6_parse_error)) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 		opt->nhoff = sizeof(struct ipv6hdr);
diff --git a/net/ipv6/exthdrs_common.c b/net/ipv6/exthdrs_common.c
index 2c68184..99a0911 100644
--- a/net/ipv6/exthdrs_common.c
+++ b/net/ipv6/exthdrs_common.c
@@ -142,3 +142,117 @@ struct ipv6_txoptions *ipeh_fixup_options(struct ipv6_txoptions *opt_space,
 	return opt;
 }
 EXPORT_SYMBOL_GPL(ipeh_fixup_options);
+
+/* Generic extension header TLV parser
+ *
+ * Arguments:
+ *   - skb_transport_header points to the extension header containing options
+ *   - off is offset from skb_transport_header where first TLV is
+ *   - len is length of TLV block
+ */
+bool ipeh_parse_tlv(const struct tlvtype_proc *procs, struct sk_buff *skb,
+		    int max_count, int off, int len,
+		    bool (*parse_error)(struct sk_buff *skb,
+					int off, enum ipeh_parse_errors error))
+{
+	const unsigned char *nh = skb_network_header(skb);
+	const struct tlvtype_proc *curr;
+	bool disallow_unknowns = false;
+	int tlv_count = 0;
+	int padlen = 0;
+
+	if (unlikely(max_count < 0)) {
+		disallow_unknowns = true;
+		max_count = -max_count;
+	}
+
+	if (skb_transport_offset(skb) + off + len > skb_headlen(skb)) {
+		if (!parse_error(skb, skb_transport_offset(skb),
+				 IPEH_PARSE_ERR_EH_TOOBIG))
+			goto bad;
+
+		len = skb_headlen(skb) - skb_transport_offset(skb) - off;
+	}
+
+	/* ops function based offset on network header */
+	off += skb_network_header_len(skb);
+
+	while (len > 0) {
+		int optlen = nh[off + 1] + 2;
+		int i;
+
+		switch (nh[off]) {
+		case IPEH_TLV_PAD1:
+			optlen = 1;
+			padlen++;
+			if (padlen > 7 &&
+			    !parse_error(skb, off, IPEH_PARSE_ERR_PAD1))
+				goto bad;
+
+			break;
+
+		case IPEH_TLV_PADN:
+			/* RFC 2460 states that the purpose of PadN is
+			 * to align the containing header to multiples
+			 * of 8. 7 is therefore the highest valid value.
+			 * See also RFC 4942, Section 2.1.9.5.
+			 */
+			padlen += optlen;
+			if (padlen > 7 &&
+			    !parse_error(skb, off, IPEH_PARSE_ERR_PADN))
+				goto bad;
+
+			/* RFC 4942 recommends receiving hosts to
+			 * actively check PadN payload to contain
+			 * only zeroes.
+			 */
+			for (i = 2; i < optlen; i++) {
+				if (nh[off + i] != 0 &&
+				    !parse_error(skb, off + i,
+						 IPEH_PARSE_ERR_PADNZ))
+					goto bad;
+			}
+			break;
+
+		default: /* Other TLV code so scan list */
+			if (optlen > len &&
+			    !parse_error(skb, off, IPEH_PARSE_ERR_OPT_TOOBIG))
+				goto bad;
+
+			tlv_count++;
+			if (tlv_count > max_count &&
+			    parse_error(skb, off, IPEH_PARSE_ERR_OPT_TOOMANY))
+				goto bad;
+
+			for (curr = procs; curr->type >= 0; curr++) {
+				if (curr->type == nh[off]) {
+					/* type specific length/alignment
+					 * checks will be performed in the
+					 * func().
+					 */
+					if (curr->func(skb, off) == false)
+						return false;
+					break;
+				}
+			}
+			if (curr->type < 0 &&
+			    !parse_error(skb, off,
+					 disallow_unknowns ?
+						IPEH_PARSE_ERR_OPT_UNK_DISALW :
+						IPEH_PARSE_ERR_OPT_UNK))
+				goto bad;
+
+			padlen = 0;
+			break;
+		}
+		off += optlen;
+		len -= optlen;
+	}
+
+	if (len == 0)
+		return true;
+bad:
+	kfree_skb(skb);
+	return false;
+}
+EXPORT_SYMBOL(ipeh_parse_tlv);
-- 
2.7.4


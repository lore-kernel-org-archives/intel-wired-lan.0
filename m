Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A0606A33A
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UwKuopnr;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=uKpStHaS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8F0A6081F;
	Mon,  9 Nov 2026 17:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7umaA0F67_MD; Mon,  9 Nov 2026 17:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F03DD60819
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244741;
	b=K0a84O/koHiCx+NAMgLZrSXcgmqGy9IXQC89nsznpO2YQ9LXMW1h0CjMukjTzrNLdvHl
	 ylVF4ZOAGVUIsNh/J+9b9WF6m4BxbCktIVfMs/JBdfamy3HArm6WhH6qEwVAOJDzzNgl6
	 G/9wNFjcOJLpBBK87kj7Ind22b0f5EqvMNdvRwblTHCyis+n14vmbq1cQ6JR0wmk0kfkZ
	 7zOVM/omeL9oRnTzHD2Pd4PzjDZvuwaGOIgq5lSW8Z+ige53a7jmMhskZQE4BGN/5GgOi
	 FFAiiaQSx/WdymzL7iyHfEB1EB3D+H2g9GpKrNQZ3wM5kyI3o3IAx4EgpEvuKuAMMOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=034iry7WHQ0bPsFgpNeABa63Awxx8ExkIQs+SzxKml4=;
	b=ZV9eUoNvFYMNqx9TaShCmnbKU8q9IZob0KNtJZR61HuE+oViX4jjHHtgvrc5JSPaoML7
	 BRQbgaeZYjF+ZJEmKg8AHIyHDJveXTRYWv1STBjubSKGCZrhDChOUpXIQz26VvRVinFIZ
	 s3wk+8KSB07qPFS011/Gvm9txf7celFoarAIOLYDLy5MzEhqRPVyQze1zYDgtmEIBjrb2
	 Wn0iCC8d6+cMxNY9vP5rPF/0jxIShsO05BgR/3IHLWAPtyzIvuNW6Y1bOBkljc5rkiY9Q
	 0s4Fif1EXm0UseMcD/3PptdooubCgMirgoj3And0+wAIDndN1pJOBF0NZ3s05Gm390Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244741;
	bh=034iry7WHQ0bPsFgpNeABa63Awxx8ExkIQs+SzxKml4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UwKuopnrfRQyVGNaFCT7iljWE79TOPuv5Zqg3eeFsNlDegi3F1tmvOMPwytJAVk1C
	 +F9R3+D8llI6eCX/ZUhPFDO/QqnrD93pKYGog2JxWqShrvUEN5llifWWDxn3omiJL6
	 78tNJgUXEQJradXA8R/cListYTrh6FN/FOw0z6SvX3HWI4zAOrA8xV7XxwSZdkdsEe
	 xS9Gvqbe49sqzyBGI3bVKaDtOX1F8OLDfV2oEkgR73AFKpxkDoTnqAJzEoWokOeYfr
	 r4FTEjb96ipEZ2XVdewlGW98jglZQdRCcQXFeIgdJMP0uoV3SFIpZAay7CGnLw6RMf
	 PAzg1AVaKoVPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F03DD60819;
	Mon,  9 Nov 2026 17:19:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 81515422
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66CB44009B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ug_SfxjD9b0 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 18:44:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E0E9A4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com;
 envelope-from=omar@blockcast.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=blockcast.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=blockcast.net header.i=@blockcast.net
 header.a=rsa-sha256 header.s=google header.b=uKpStHaS
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0E9A4005F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:51 +0000 (UTC)
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-19305bcb72cso1621234c88.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 07 Nov 2026 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockcast.net; s=google; t=1794077091; x=1794681891; darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=034iry7WHQ0bPsFgpNeABa63Awxx8ExkIQs+SzxKml4=;
 b=uKpStHaS6qiVN5KmrbKIOeLmYflYjtjhi8NNp1p9cNTd/1zOoMgvabKJXs5iq3cNYs
 Sg0HSwcQzdP2FHXyNscDC1hL/Sg1eepc7zOwb1qyE9QuLTKxDJDMq6oz9mflmJkaOoGL
 gISQ34BNyuIcEhG6rNjSu4eJ07ppw+GkwhF6iTM+0SHQ5hVBRPGkwUlYir/rDtSy5UHB
 KtoLZMosGldXSlt9kRAo6YXOxKkZTSvr1+JGqxz0AWkJtEcc61695PSy1eSojXf/uDrK
 Kv/h2aeunIi8LRosYPmtjHqecRyJh/1O2fQCNxHH2DjLOz0zUw9o3U/IdimTm9T7+szx
 VsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077091; x=1794681891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=034iry7WHQ0bPsFgpNeABa63Awxx8ExkIQs+SzxKml4=;
 b=LozjhYTKBNil4GCaifdj39HYQ3ZxHDfC4jVddmrnb6fbt+5xseitPDLTz+k3m9XrBD
 1gwOGoC2NF0W7pIVbN3ODn2AA3JPsz7XgIGozPMFptFuZLeZ+67PvemzfXgjc3dDJ03U
 88WQ4zmnSJZewNb3tj/K8U+4HSM+p9IwoQNP2c4/x66pdJdBkAhhzi6kAim4dh7GGol3
 r/uM6dMw9iJTxudypPbaSpB5JF6HESygz9YH3BQjVwQjk9sFN6tC+/f0JNfdwtM/y3MD
 0OHFepb/Oov4J3AFooVwZz0skyb9f/uN2c9mp9zi7DvzHq5Hk+uacLpo27J+7g50f9SY
 8dWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzmUdIbVIYZs0xs0tDcg7g9lHVob6qZzEklZVRjBUhxxe/hd0iHSCx6IZ1J+kJLzAypCsbSbQ/zGkeCvMiW+8=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8KlF/2qmI4qA3zrQfyhYwEJPk0BFeMccvEc6P7dWT90mSx7x8r
 YOIQLE8TQ+bmyvVZu51c+nujDrE9X+pZljikY2V5tIqdrLdq3Wgreo/6C5Y7xwWM4OXrjfFk7Cj
 1tmRIC0HPr8WF
X-Gm-Gg: AYBFou2sCeMEUnR27BKzHXiO7wUFtdQ6xuFySu5M09CetCOESug95j+cq9J9bIS0vP7
 0HvcxJz0JIuDR0gaXYqa3R60SDviotKQ7j4VOgfuCMxy41Iv9iB2POZr9fwQv9D9YiFojnMRUQ6
 lKY71VEGE/rczzZ8wLwz4beilQ9tTP6zXdikunZnCqjDamdp0lErNNYRUmClc0CX1aaCHZbR1mr
 ss6hxKPgYWfyLIuYC2aseNtkSFOP9V9c1szd76oWt3uUKZUYD3hgZNAZDIRwn7632cY7n20HWIp
 v6U8CRSgO4jAEJHzD/mjHgdd0LDZXtJmfWsYIRvigDdOzfQLBp4yrKUR2AH3Y7jkvs13Nj5tgCk
 7YUSijPvOatZOrq9h0aY/a92NbOyMmFzdh6QqLOSt6ubRIeAyokLcK8Pp3NfAi2k60RkzUHHLpK
 /a+JCEkBKpL2lRxYmO/B7ruq/HxK0o3zsc1N+kQP4riQXge7crFAspZoiqx8jp6XVbEBGd0vOat
 lLvUjDzJmGKAjVBJe0MbPyKccdKkczTV2mMOIzoaRr6u70UoBvfqV6eG4FWbhSXYyQlbMvsuIqd
 sv68u/iR38fyYvaVE3JCN+q695ZvV2MQkymITqwclsDVbaZHNZKYV6SpoIml0PzmU7RIbxM=
X-Received: by 2002:a05:7022:b04b:10b0:196:bf5f:8bb with SMTP id
 a92af1059eb24-1b25d34a675mr8380119c88.45.1794077090265; 
 Sat, 07 Nov 2026 10:44:50 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:44:49 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 brett.creeley@amd.com, sgoutham@marvell.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 Ido Schimmel <idosch@nvidia.com>, Satish Kharat <satishkh@cisco.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [RFC PATCH net-next 4/9] amt: offload TX handoff,
 ingress punt rule and counters
Date: Sat,  7 Nov 2026 18:44:32 +0000
Message-ID: <20261107184437.2783174-5-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107184437.2783174-1-omar@blockcast.net>
References: <20261107184437.2783174-1-omar@blockcast.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 17:18:54 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a TX binding, amt_dev_xmit hands each relay data packet of a group
the reconciler has published (hw_active, set with hw_gen after a
successful group_commit) to the provider before its software fan-out,
while the binding admits packets and desired state is in sync; every
other packet goes to software. Exactly one actor handles each packet
handed over: CONSUMED means the provider handled every copy (sent it, or
dropped it and counted it, apart from the copy and route failures
amt_offload_encap_xmit() counts itself) and owns the skb; FALLBACK
leaves the skb untouched for the software loop; BUSY runs one
synchronous software pass and counts it, never NETDEV_TX_BUSY since the
relay is IFF_NO_QUEUE. hw_gen is read once per packet. The reconciler
writes it after a successful group_commit, also when it then withholds
hw_active because a member left meanwhile, so a packet already past the
hw_active test can carry the new generation and one that read hw_gen
earlier any older committed one; the provider serves or declines it.

On the ingress path the provider replicates every packet of a group from
group_commit until group_disable or flush, and must never also punt one.
While the group's commit is published (hw_active, with the binding
admitting and desired state in sync), a punted copy that reaches the
relay is dropped and counted; at any other time (before the first
publication, after a park, during a reset or a teardown, after desync)
it goes to the software fan-out. The provider sees none of these
transitions as amt makes them, so the drop is only a safety net.
Removing a member on an ingress binding does not withdraw the group as
it does on TX: hardware replicates to the committed set until the
recommit regardless, and lifting the drop would send the remaining
members every punted packet a second time. For the same reason the
reconciler publishes a commit on an ingress binding even when a member
left while it was programmed. A relay binds on ingress only in required
mode: a packet the provider consumes on ingress never reaches the host,
so nothing on the host's forwarding path, mroute counters included, sees
it, and auto does not choose that. A provider offering no path the relay
may use leaves it unbound, counted. TX needs ops->xmit.

New offload/ counters: path_unsupported, busy_fallback, punt_dropped
(plus sw_remainder, resets, stale_completions and desync from the
reconciler). With no provider bound the data path does one more RCU
pointer read and test.

A simulated replication provider -- netdevsim is the reference one --
decides from its own tables which gateways get a copy of a relay data
packet, but has no business re-implementing AMT encapsulation: if its
copies differed on the wire from amt's own, a test could not tell a
provider bug from an encapsulation difference.

amt_offload_encap_xmit(binding, endpoint key, skb), exported, emits one
gateway's copy byte for byte as the software fan-out does: the copy, AMT
Multicast Data header and amt_udp_xmit() of amt_send_multicast_data(),
from the relay port to the gateway's port with AMT_TOS on an IPv4 outer
and the route's hop limit. Each failed copy or route lookup counts once
in tx_dropped; the software fan-out on this base counts neither. It
takes the endpoint key, not the provider's handle, which is opaque to
amt, and is for use from ops->xmit only.

With no provider registered nothing calls it.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c         | 206 +++++++++++++++++++++++++++++++++++---
 include/net/amt.h         |  13 ++-
 include/net/amt_offload.h |  38 ++++++-
 3 files changed, 237 insertions(+), 20 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 17337989a..377660e55 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -319,6 +319,8 @@ static void amt_ofl_member_del(struct amt_dev *amt,
 static void amt_ofl_tunnel_gone(struct amt_dev *amt,
 				struct amt_tunnel_list *tunnel);
 static void amt_ofl_state_free(struct amt_dev *amt);
+static bool amt_offload_tx(struct amt_dev *amt, struct sk_buff *skb,
+			   const union amt_addr *group, bool v6);
 
 static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 {
@@ -1510,6 +1512,11 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else if (amt->mode == AMT_MODE_RELAY) {
 		if (!data)
 			goto free;
+		/* A bound offload provider replicates it, or declines; see
+		 * amt_offload_tx() for the cutover rules.
+		 */
+		if (amt_offload_tx(amt, skb, &group, v6))
+			return NETDEV_TX_OK;
 		key.group_addr = group;
 		key.v6 = v6;
 		list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
@@ -4087,6 +4094,7 @@ struct amt_offload_bound {
 	struct amt_offload_binding	pub;
 	const struct amt_offload_ops	*ops;
 	struct amt_offload_caps		caps;
+	enum amt_offload_path		path;
 	/* Cleared first on teardown; ops->xmit is only called while set. */
 	bool				admitting;
 };
@@ -4209,6 +4217,10 @@ struct amt_offload_state {
 	struct list_head		parked;
 	struct list_head		ep_gc;
 	bool				desync;
+	/* The binding is on the ingress path: a member change must not
+	 * clear hw_active, which there gates the punt-drop. Set at bind.
+	 */
+	bool				ingress;
 	/* Reconciler. bind and teardown also take the mutex. */
 	struct mutex			mutex;
 	struct work_struct		work;
@@ -4286,9 +4298,9 @@ static u32 amt_offload_outer_family(const struct amt_dev *amt)
 }
 
 /* The data path's way in: a binding is usable only while admitting. The
- * caller holds rcu_read_lock(). The later TX handoff is its first caller.
+ * caller holds rcu_read_lock().
  */
-static __maybe_unused struct amt_offload_bound *
+static struct amt_offload_bound *
 amt_offload_tx_admit(struct amt_dev *amt)
 {
 	struct amt_offload_bound *b = rcu_dereference(amt->offload);
@@ -4402,13 +4414,15 @@ static void amt_ofl_kick(struct amt_offload_state *st)
 }
 
 /* Desired state could not record a change. Hardware would forward to a
- * stale member set, so the relay leaves offload for good: the data path
- * stops consulting the provider, and the next reconciler pass gives every
- * provider object back (group_disable, endpoint_del; the binding stays,
- * with no unbind). Desync does not schedule that pass: a pass already
- * queued or a later removal of a recorded member (by a leave, a timer or
- * a tunnel removal) does, and a teardown gives everything back itself
- * and unbinds. Caller holds st->lock.
+ * stale member set, so the relay leaves offload for good. On TX that
+ * takes effect at once: the data path stops handing packets to the
+ * provider. The next reconciler pass gives every provider object back
+ * (group_disable, endpoint_del; the binding stays, with no unbind).
+ * Desync does not schedule that pass: a pass already queued or a later
+ * removal of a recorded member (by a leave, a timer or a tunnel removal)
+ * does, and a teardown gives everything back itself and unbinds. On an
+ * ingress binding the provider replicates to its committed sets until
+ * then. Caller holds st->lock.
  */
 static void amt_ofl_desync(struct amt_offload_state *st)
 {
@@ -4562,12 +4576,16 @@ static void amt_ofl_member_unlink(struct amt_offload_state *st,
 	g->nr_members--;
 	g->gen++;
 	g->left++;
-	/* The committed member set still names this endpoint: stop handing
-	 * the group to hardware now, not when the reconciler recommits, so
-	 * no packet admitted after this is replicated to it. Software serves
-	 * the group meanwhile.
+	/* TX: the committed member set still names this endpoint. Stop
+	 * handing the group to hardware now, not when the reconciler
+	 * recommits, so no packet admitted after this is replicated to it;
+	 * software serves the group meanwhile. Ingress: hardware replicates
+	 * on its own until the recommit whatever the host does, and
+	 * hw_active there only drops the punted copies, so clearing it
+	 * would send the remaining members every packet twice.
 	 */
-	WRITE_ONCE(g->hw_active, false);
+	if (!READ_ONCE(st->ingress))
+		WRITE_ONCE(g->hw_active, false);
 	amt_ofl_grp_dirty(st, g);
 	ep->refs--;
 	amt_ofl_ep_unused(st, ep);
@@ -4966,7 +4984,10 @@ static unsigned int amt_ofl_grp_program(struct amt_offload_state *st,
 	 * committed, and amt_ofl_member_unlink() already withdrew the group.
 	 * A join meanwhile does not hold the publication back: the committed
 	 * set is a subset that names no departed endpoint. Either change
-	 * re-queued @g; the next pass commits it.
+	 * re-queued @g; the next pass commits it. On ingress, hardware is
+	 * already replicating to the committed set whatever the host does,
+	 * and hw_active only drops the punted copies, so withholding it there
+	 * protects no one and sends the remaining members every packet twice.
 	 */
 	spin_lock_bh(&st->lock);
 	for (i = 0; i < n; i++)
@@ -4978,7 +4999,7 @@ static unsigned int amt_ofl_grp_program(struct amt_offload_state *st,
 	swap(g->ceps, eps);	/* out: frees the old set */
 	g->nr_ceps = n;
 	WRITE_ONCE(g->hw_gen, gen);
-	if (g->left == left)
+	if (READ_ONCE(st->ingress) || g->left == left)
 		smp_store_release(&g->hw_active, true);
 	spin_unlock_bh(&st->lock);
 	goto out;
@@ -5238,6 +5259,135 @@ static void amt_ofl_state_free(struct amt_dev *amt)
 	amt->offload_st = NULL;
 }
 
+/* Cutover, per packet; exactly one actor handles each one.
+ *
+ *   relay data packet (inner IP; Ethernet pulled)
+ *    |
+ *    +-- bound, admitting, desired state in sync, and (family, group)
+ *    |   hw_active?  no --> software fan-out
+ *    |
+ *    +-- TX path: ops->xmit(grp, hw_gen)
+ *    |     CONSUMED --> the provider handled every copy and owns the skb
+ *    |     FALLBACK --> skb untouched --> software fan-out
+ *    |     BUSY     --> skb untouched --> software fan-out, counted
+ *    |                  (never NETDEV_TX_BUSY: the relay is IFF_NO_QUEUE)
+ *    |
+ *    +-- ingress path: a punted copy of an hw_active group reaching here
+ *          is dropped and counted; one that took the "no" branch is
+ *          forwarded in software. A provider cannot tell which (amt
+ *          publishes after group_commit returns, and withdraws before
+ *          the callback on a reset, park or teardown and with no
+ *          callback on desync), so it must never punt a packet it
+ *          replicates.
+ *
+ * hw_gen is read once per packet. The reconciler writes it after
+ * group_commit returns 0, before it publishes hw_active, and also when a
+ * member left meanwhile and it withholds hw_active. So a packet already
+ * past the hw_active test may carry that new generation, and one that
+ * read hw_gen earlier any older committed one; the provider serves or
+ * declines it.
+ *
+ * Returns true when the skb is gone (consumed, or a punted copy dropped);
+ * false sends it to the software fan-out untouched.
+ */
+static bool amt_offload_tx(struct amt_dev *amt, struct sk_buff *skb,
+			   const union amt_addr *group, bool v6)
+{
+	struct amt_offload_group_key key;
+	enum amt_offload_result res;
+	struct amt_offload_bound *b;
+	struct amt_ofl_grp *g;
+	bool gone = false;
+
+	rcu_read_lock();
+	b = amt_offload_tx_admit(amt);
+	if (!b || READ_ONCE(amt->offload_st->desync))
+		goto out;
+	amt_ofl_grp_key(&key, group, v6);
+	g = amt_ofl_grp_find(amt->offload_st, &key);
+	/* Pairs with the release in amt_ofl_grp_program(). */
+	if (!g || !smp_load_acquire(&g->hw_active))
+		goto out;
+
+	if (b->path == AMT_OFFLOAD_PATH_INGRESS) {
+		amt_offload_count(amt, AMT_OFFLOAD_CNT_PUNT_DROPPED);
+		consume_skb(skb);
+		gone = true;
+		goto out;
+	}
+
+	res = b->ops->xmit(&b->pub, g->hw, skb, READ_ONCE(g->hw_gen));
+	switch (res) {
+	case AMT_OFFLOAD_CONSUMED:
+		gone = true;
+		break;
+	case AMT_OFFLOAD_BUSY:
+		amt_offload_count(amt, AMT_OFFLOAD_CNT_BUSY_FALLBACK);
+		break;
+	case AMT_OFFLOAD_FALLBACK:
+		break;
+	default:
+		WARN_ONCE(1, "amt: offload xmit returned %d\n", res);
+		break;
+	}
+out:
+	rcu_read_unlock();
+	return gone;
+}
+
+/* One gateway's copy for a simulated provider, built and sent exactly
+ * as amt_send_multicast_data() builds and sends a software copy: the
+ * same copy, AMT Multicast Data header, UDP ports, TOS and hop limit,
+ * through amt_udp_xmit(). Called from ops->xmit, in softirq context
+ * under rcu_read_lock().
+ */
+int amt_offload_encap_xmit(struct amt_offload_binding *b,
+			   const struct amt_offload_endpoint_key *key,
+			   struct sk_buff *oskb)
+{
+	struct amt_dev *amt = netdev_priv(b->dev);
+	struct amt_header_mcast_data *amtmd;
+	bool v6 = ip_hdr(oskb)->version == 6;
+	union amt_addr daddr = {0,};
+	struct socket *sock;
+	struct sk_buff *skb;
+
+	sock = rcu_dereference_bh(amt->sock);
+	if (!sock)
+		return -ENETDOWN;
+	if (key->family != (amt_v6(amt) ? AF_INET6 : AF_INET))
+		return -EAFNOSUPPORT;
+
+	skb = skb_copy_expand(oskb, sizeof(*amtmd) + amt_ip_hlen(amt) +
+			      sizeof(struct udphdr), 0, GFP_ATOMIC);
+	if (!skb)
+		goto drop;
+
+	skb_reset_inner_headers(skb);
+	amtmd = skb_push(skb, sizeof(*amtmd));
+	amtmd->version = 0;
+	amtmd->reserved = 0;
+	amtmd->type = AMT_MSG_MULTICAST_DATA;
+	skb_set_inner_protocol(skb, htons(v6 ? ETH_P_IPV6 : ETH_P_IP));
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (key->family == AF_INET6)
+		daddr.ip6 = key->addr.ip6;
+	else
+#endif
+		daddr.ip4 = key->addr.ip4;
+	if (amt_udp_xmit(amt, sock->sk, skb, &daddr, amt->relay_port,
+			 key->port, 0))
+		goto free;
+	return 0;
+free:
+	kfree_skb(skb);
+drop:
+	DEV_STATS_INC(amt->dev, tx_dropped);
+	return -ENETUNREACH;
+}
+EXPORT_SYMBOL_GPL(amt_offload_encap_xmit);
+
 static void amt_offload_set_carrier(struct amt_dev *amt, bool on)
 {
 	if (amt->offload_mode != AMT_OFFLOAD_MODE_REQUIRED)
@@ -5285,9 +5435,27 @@ static int amt_offload_bind(struct amt_dev *amt,
 		kfree(b);
 		return -EOPNOTSUPP;
 	}
+	/* TX when offered. Ingress only for a required relay: a packet
+	 * consumed on ingress never reaches the host, so nothing on its
+	 * forwarding path sees it, and auto never chooses that.
+	 */
+	if ((b->caps.paths & BIT(AMT_OFFLOAD_PATH_TX)) && b->ops->xmit) {
+		b->path = AMT_OFFLOAD_PATH_TX;
+	} else if ((b->caps.paths & BIT(AMT_OFFLOAD_PATH_INGRESS)) &&
+		   amt->offload_mode == AMT_OFFLOAD_MODE_REQUIRED) {
+		b->path = AMT_OFFLOAD_PATH_INGRESS;
+	} else {
+		b->ops->unbind(&b->pub);
+		amt_offload_count(amt, AMT_OFFLOAD_CNT_PATH_UNSUPPORTED);
+		kfree(b);
+		return -EOPNOTSUPP;
+	}
 
 	b->admitting = true;
 	mutex_lock(&amt->offload_st->mutex);
+	/* Before any group can hold hw under this binding. */
+	WRITE_ONCE(amt->offload_st->ingress,
+		   b->path == AMT_OFFLOAD_PATH_INGRESS);
 	rcu_assign_pointer(amt->offload, b);
 	/* Replay desired state: every group is programmed afresh. */
 	amt_ofl_requeue_all(amt->offload_st);
@@ -5506,6 +5674,9 @@ AMT_OFFLOAD_CNT_ATTR(sw_remainder, AMT_OFFLOAD_CNT_SW_REMAINDER);
 AMT_OFFLOAD_CNT_ATTR(resets, AMT_OFFLOAD_CNT_RESET);
 AMT_OFFLOAD_CNT_ATTR(stale_completions, AMT_OFFLOAD_CNT_STALE);
 AMT_OFFLOAD_CNT_ATTR(desync, AMT_OFFLOAD_CNT_DESYNC);
+AMT_OFFLOAD_CNT_ATTR(path_unsupported, AMT_OFFLOAD_CNT_PATH_UNSUPPORTED);
+AMT_OFFLOAD_CNT_ATTR(busy_fallback, AMT_OFFLOAD_CNT_BUSY_FALLBACK);
+AMT_OFFLOAD_CNT_ATTR(punt_dropped, AMT_OFFLOAD_CNT_PUNT_DROPPED);
 
 static struct attribute *amt_offload_attrs[] = {
 	&dev_attr_offload_mode.attr,
@@ -5521,6 +5692,9 @@ static struct attribute *amt_offload_attrs[] = {
 	&dev_attr_offload_resets.attr,
 	&dev_attr_offload_stale_completions.attr,
 	&dev_attr_offload_desync.attr,
+	&dev_attr_offload_path_unsupported.attr,
+	&dev_attr_offload_busy_fallback.attr,
+	&dev_attr_offload_punt_dropped.attr,
 	NULL,
 };
 
diff --git a/include/net/amt.h b/include/net/amt.h
index 0c746e4be..0b57c8604 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -389,7 +389,9 @@ struct amt_offload_state;
 
 /* Per-relay offload counters, exported under offload/ in sysfs. */
 enum amt_offload_counter {
-	/* bind() succeeded and the caps covered the outer family */
+	/* bind() succeeded, and the caps covered the outer family and offered
+	 * a data path this relay may use
+	 */
 	AMT_OFFLOAD_CNT_BIND,
 	/* ... of which: bound when a provider registered on the stream_dev
 	 * this relay already uses
@@ -418,6 +420,15 @@ enum amt_offload_counter {
 	AMT_OFFLOAD_CNT_STALE,
 	/* desired state lost an update (allocation failure); software only */
 	AMT_OFFLOAD_CNT_DESYNC,
+	/* no data path this relay may use: the caps offered none, or TX
+	 * without ops->xmit (ingress counts only in required mode); it stayed
+	 * unbound
+	 */
+	AMT_OFFLOAD_CNT_PATH_UNSUPPORTED,
+	/* xmit returned BUSY: one synchronous software pass ran instead */
+	AMT_OFFLOAD_CNT_BUSY_FALLBACK,
+	/* ingress: a punted copy of a group the provider replicates, dropped */
+	AMT_OFFLOAD_CNT_PUNT_DROPPED,
 	AMT_OFFLOAD_CNT_MAX,
 };
 
diff --git a/include/net/amt_offload.h b/include/net/amt_offload.h
index b5c119851..99f78699f 100644
--- a/include/net/amt_offload.h
+++ b/include/net/amt_offload.h
@@ -42,8 +42,16 @@ struct sk_buff;
  *	group without a callback when a member leaves, until it publishes the
  *	recommit. Every other packet goes straight to software.
  * @AMT_OFFLOAD_PATH_INGRESS: the provider replicates on ingress and the
- *	host only sees punted packets. Semantics only until a real provider
- *	exists; no simulated provider implements it.
+ *	host only sees punted packets. From &amt_offload_ops.group_commit
+ *	until &amt_offload_ops.group_disable or &amt_offload_ops.flush the
+ *	provider replicates every packet of the group, and it must never also
+ *	punt one. amt drops, and counts, a punted copy of a group only while
+ *	the group's commit is published: from some time after group_commit
+ *	returns until amt withdraws it, which it does before any group_disable
+ *	or flush and, with no callback, once its desired state is lost. A
+ *	punted copy outside that window is forwarded in software as well.
+ *	Semantics only until a real provider exists; no simulated provider
+ *	implements it, and only a relay in required mode binds on it.
  */
 enum amt_offload_path {
 	AMT_OFFLOAD_PATH_TX,
@@ -203,7 +211,12 @@ struct amt_offload_stats {
  * @group_disable: stop forwarding @grp and free it. amt has already
  *	stopped submitting packets for @grp and waited out @xmit callers.
  * @xmit: TX path. Replicate @skb for @grp under @gen or decline; see
- *	&enum amt_offload_result. Softirq context, under rcu_read_lock().
+ *	&enum amt_offload_result. @skb is the relay data packet with its
+ *	data at the inner IP header. On %AMT_OFFLOAD_CONSUMED the provider
+ *	owns @skb and must have handled every copy under @gen alone: each one
+ *	handed to the stack, or dropped and counted (see
+ *	%AMT_OFFLOAD_CONSUMED). Otherwise it must not have sent any copy, nor
+ *	modified or freed @skb. Softirq context, under rcu_read_lock().
  * @flush: drop every endpoint and group (reset after a timeout). amt then
  *	replays from its own desired state under a new epoch, except when
  *	the op that overran was a @group_disable or @endpoint_del of amt
@@ -318,4 +331,23 @@ int amt_offload_register(struct net_device *lower,
  */
 void amt_offload_unregister(struct net_device *lower);
 
+/**
+ * amt_offload_encap_xmit - emit one gateway's copy of a relay data packet
+ * @b: the binding @skb was handed to the provider under.
+ * @key: the gateway endpoint, as amt passed it to endpoint_add.
+ * @skb: the packet given to &amt_offload_ops.xmit; not consumed.
+ *
+ * For simulated providers: encapsulates a copy of @skb as AMT Multicast
+ * Data to @key and transmits it on the relay's stream device, byte for
+ * byte as amt's own software fan-out would. Which endpoints get a copy
+ * is the provider's decision, made from its own tables. Call only from
+ * &amt_offload_ops.xmit.
+ *
+ * Return: 0 if the copy was handed to the stack, else a negative errno
+ * (counted in the relay's tx_dropped when the copy or route failed).
+ */
+int amt_offload_encap_xmit(struct amt_offload_binding *b,
+			   const struct amt_offload_endpoint_key *key,
+			   struct sk_buff *skb);
+
 #endif /* _NET_AMT_OFFLOAD_H_ */
-- 
2.43.0


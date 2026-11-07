Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126C606EE9F
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Tcdw4ZIr;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=D4KK9MdG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 227C960805;
	Mon,  9 Nov 2026 17:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qlg3GxH1l9BZ; Mon,  9 Nov 2026 17:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C16D960762
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244743;
	b=LKn7WynqOE5At8FqM+pbf1rt/W+mzNS11TwGbZ/GRFEJ2eVLEPj5TSY5kKhny0WslVLL
	 ztq5mVPAi4wSYHEmtWt6JhNk3piBiVDAD86NohrsA1+P1lb/byXTCSBYnA+WKQY7vhQ15
	 Oz/2WPrnhSzl1FzlaNDlBs2/Ja1VaY+ONfOm5zvA4fgV0v3wzpnZE+aa1ooLpmJOpMRhz
	 WfEgMT3WCDf0KyMVglN8rq+YPIX/ucLbFOhmtQ0Ov2Pol70THTF253wMxXs7EGwf9oFl2
	 zl0/ovDeotuMzj88FX6QAj7QJimnJ4TZ3LcbR7BRIfrWKzHLWqNQ5eSwudqbiioDeVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TSzJvJNUMT1IhqxFawPqLADp5ExgeasI1RJx9c8aMTc=;
	b=IbY3EYI59VWjcJY7MZOkUBMumbLCpYKOj9XExVuxhC4QFxT8dJSVJDZMbKAO9mi4z5PX
	 DTPe+1PymhVYVFeSSrbESngqqsa0GSsGq8sNKHSko0mlP3mAlwewD5YBJeedG/Bp+LNph
	 JNOdGQhYODtxg45H3O5hBH1kWIMQpK0rHb2PEXO/tZzWt//T01OUEhZA1dNSU/fDjhT1E
	 DLZYwd/GdvLKzsXh09R47GyVqjP+E3l4U++mRTg6/nlcPhnT/KtYzcSxmcm/N+STcxrOL
	 6A7OGuEj98sJDcqXbKGBWN3kM9C/QlzDpYjAVyn4+oW//bhqmS447DGa7vkzj8pc1lg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244743;
	bh=TSzJvJNUMT1IhqxFawPqLADp5ExgeasI1RJx9c8aMTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tcdw4ZIrdIMXkGqmRpc1XNdIwV1aIbok0s9mHVXtjF7BGZtovzbwXKI4wnpVVVUcI
	 fDZc5Pde9sev8q98Bg5EpHAv/QVWj7L7rZu9Hjk8XgrZ23daghGMmEJ7L4N8Us9yNQ
	 +yd7OGduTr1lEsKoCNbPh8LD1mN5z9vrIvXytzNELC2ydVImYhgTIEttx/r4o1AH3h
	 X55LI8kaIFNPprJyQ+LvaCGYH+1us/XIAs3/4ldoIaBAUiTVP/42v7v2NdVtliFuJ9
	 WcwjPDBGvRfbh3lxq+sB5Qqmi44K8w2xfqFxh536lK5xKi0MWWFHsSW8D3tkv2jhfR
	 /4+5XiHJlMvuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C16D960762;
	Mon,  9 Nov 2026 17:19:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D47F3422
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9FB881279
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q4FtO3nQ5qqO for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 18:44:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 13CE381271
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com;
 envelope-from=omar@blockcast.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=blockcast.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net
 header.a=rsa-sha256 header.s=google header.b=D4KK9MdG
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13CE381271
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:56 +0000 (UTC)
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-37000e7234bso3065052eec.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 07 Nov 2026 10:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockcast.net; s=google; t=1794077096; x=1794681896; darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TSzJvJNUMT1IhqxFawPqLADp5ExgeasI1RJx9c8aMTc=;
 b=D4KK9MdGJrNvrzI81yB4isaMJcTwpXf5lpziGoKiSc/KJRMQvj9qRH764zo+jmbe9/
 cXuDEi5EPE+K0la+TUNpkXCwTd1RpO7lGYHfPNihB6mc0A3UsVwSZFXVjxPRWCfFPsAc
 te+3GkBGzmTORyFh5VDROVpGYM3kGwD9sD7siPbG/8eddPhCaSj+OPc646O2kns1I9XP
 2KNegMuM8F7yi8gZartiUhV85Gpi4+mNDNzLEZogqaeVNo1qjemdaZAi1J5K1lWA1aBB
 aSTvtz4++Ko2SbKINdbi08pxjLWMUIPxG2gzPrI6rEYNQ1JV7Ot3L77Kl1vJF2m1E0rZ
 CDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077096; x=1794681896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TSzJvJNUMT1IhqxFawPqLADp5ExgeasI1RJx9c8aMTc=;
 b=HEJV/HeUrE1glyuzQmgz9O+mbKHKoNITq5HmrGXCp+3OmzmGY4j9gnw9yeVbhVV+Ze
 84O6NuoFb5+rXMzgW6lgskguw6FzA8PQPFMJw/ELSY9j2UeuywTUMtIHREuK+iJNkTJH
 wUgi3U+OMf/g9H6bNc4dPOfsQlY8t6CfaY4GaIapPizhXM/hXrN9utyNlEMWrYgBQJfA
 A3Sm4Ha6KxKZDgiuMph44I4nzjt482Lcck8oFNejabdSU9SU5GM1nX6LAFd2GWHh3CfP
 DJmFOLqAmUrdwKweyNjrGA7jVpynaEabeX54ee0/WBTnQ8QOnFXDGjZxYNx7NBqS2d/y
 kl5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEqVad35o6krMe7aURXLKAprCL4+m7gzecLFC4UPIhvc2tVHxmt51LPTpPVMYZnYT0yV0HpVfFIU6kLwmVGDXo=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/nIapTTL/M+87ssna1m+pY7Zh3FXk1wD9VOc26bcLZ9/eszNMQ
 3eDb0tktsDME5NEroG5WLGBZJnU/ihdSGiKLNaOTsYUGPZ38jwV7y0oH25MXXG+3er0=
X-Gm-Gg: AYBFou11d/kT/GcaYh27CKxz696d7cr819og14ZHBlfNGbclcu0aJAhW4OA/MzRRIGc
 JOCJEZNYnsjQ8DJlrBoaD/6P6NgKdL+MgqGzKOJB17Phma7lEecpCD0uKQvbUDmTk/OIe75t+/Z
 m396husIQlfB5qwCbD9c8mqQgSaQOFfFpFXNkNPpMZ6s2U7xAZEF8pHM6sYbIkPp3/e7T8oRjQZ
 vNEprcKA+Ndt7eTugDT/rp52Y4eb4glPt2bTF7qKpbjuu2B26nE3bar1uUKGXbnvMvIlgrEHyje
 xIbAd/gXqwO8SujcAdcclSDKQo/XQnmCD1JSxrfOZ573981GBoJURwAUsldsbHQ+omY9Fr7L6r3
 5ntC/s1upAe4hTof87PeUj8DnNBg5mRqWR5h1cKOIjKve/9qRKcUPnuTPTH/ThfU8r/00NB7pFm
 jT8wAiXY+lpHGbpXj7SGRYGx9hrf5o8mjHwB/SA3SK0PlfRwonaGo3Xf+MEtPUM+jGkawN2qrq1
 GEdb7+/5nrYv25skqLVLjquVPri2gS2dpDkORZkpODOPqj8iDKqsTG7wkGBhC+fR7GrJ674KnfG
 b7zU+2fRG07mT0MkU1QCOGjIki/r5HDzZ+kdsuQmlIpPwpk1BOs/3M7hvUF4lyBp8/uA6iA=
X-Received: by 2002:a05:7301:9a8d:b0:369:f291:49da with SMTP id
 5a478bee46e88-36f775f999bmr8745557eec.40.1794077094864; 
 Sat, 07 Nov 2026 10:44:54 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:44:54 -0800 (PST)
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
Subject: [RFC PATCH net-next 6/9] amt: KUnit cases for the offload contract
Date: Sat,  7 Nov 2026 18:44:34 +0000
Message-ID: <20261107184437.2783174-7-omar@blockcast.net>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A relay fixture (amt_test_relay_alloc(), amt_test_tunnel_add()) builds a
v4 relay without registering or opening the device, and links tunnels on
it as amt_request_handler() admits them, listed and counted under
amt->lock with gc_wq armed for one GMI, but without the admission
bounds, the siphash key or the Request/Query exchange. An in-file fake
provider logs every teardown callback in order.

Registry, lifecycle and mode: register-when-bound,
caps-family-unsupported (and bind failure), unregister-mid-fanout
(stream_dev unregistered with groups programmed: order BGGEEU, no
fan-out admitted at any step, binding published until unbind),
provider-unregister ordering with required-mode carrier loss and
rebind, IFLA_AMT_OFFLOAD_MODE validation, and required refusal counted.

Reconciler and cutover, twenty cases: the fake also keeps its own
endpoint and group tables and can refuse with -ENOSPC, fail a commit,
overrun op_timeout_ms or answer xmit with any result. The reconciler
work is disabled in these cases and ticks are driven by hand, so a
static stub on amt_ofl_op_overran() reaches every timed op: the fake
records whether each op stalled, and only such an op overruns, never one
the scheduler happened to delay past a short op_timeout_ms.

  - members follow gnodes: a second inner host only counts, the last
    gnode removes the member, unlink removes it at once
  - churn coalesces into one update and one commit at the last
    generation; a tick stops starting groups once its budget is spent
  - a refused group is served by software, not retried on its own
    member changes, and retried past the low watermark
  - an op overrunning op_timeout_ms flushes, bumps the epoch, ignores
    the late result and replays; with groups still queued, the tick
    ends at the reset
  - a teardown whose release ops overrun op_timeout_ms makes one of
    them, then flushes, with groups programmed or with only endpoints
    (the group parked); every endpoint is still collected afterwards.
    The reconciler's gone and endpoint-GC loops reset on an
    overrunning release op
  - under churn in one group that spends every tick's budget, the
    endpoint that left another group is still deleted within three
    ticks, and the churning endpoint, which the last commit names, is
    never deleted
  - admission lost inside an endpoint_add, a group_update or an
    endpoint_del (a teardown racing the tick): no further provider op,
    and the tick ends with the remaining groups queued
  - endpoint_add is idempotent and a shared endpoint is added once
  - a failed commit disables the group, keeps its endpoints, and a new
    binding retries it; a leave followed by a failed recommit parks the
    group and disables its provider object, after a grace period (a
    static stub on the reconciler's synchronize_net() logs it)
  - the publish gate: a leave landing inside group_commit withholds
    that commit's publication and software serves the group, and the
    departed member's endpoint stays programmed; a join landing there
    does not withhold it
  - a group emptied and rejoined within one tick: the fake refuses a
    second live group per key, and the rejoined group still commits,
    after a grace period for the old group's disable. If that disable
    overruns op_timeout_ms, the provider is flushed once and the
    rejoined group waits for the next tick
  - CONSUMED/FALLBACK/BUSY ownership, unbound and uncommitted groups
    stay in software, the generation rule, and a member removal
    withdrawing the group from hardware at once
  - the last member leaving while the reconciler allocates (static
    stubs on its allocator and its free keep a ledger of live arrays):
    the retry frees nothing twice
  - both reconciler tables are indexed with the device's hash_seed and
    sized from max_tunnels at attach
  - ingress: a punted copy of a committed group is dropped and counted,
    and still is after a member leaves, including one landing inside
    the group's first commit, whose departed endpoint stays
    programmed; only a required relay binds on ingress

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 2062 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2062 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 58e9da443..bafe21302 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -6201,6 +6201,7 @@ static struct notifier_block amt_notifier_block __read_mostly = {
 
 #if IS_ENABLED(CONFIG_AMT_KUNIT_TEST)
 #include <kunit/test.h>
+#include <linux/delay.h>
 
 /*
  * KUnit coverage for relay-mode upstream membership tracking. The cases
@@ -6513,10 +6514,2071 @@ static void amt_ex_transition_test(struct kunit *test)
 	free_netdev(test_dev);
 }
 
+#define AMT_TEST_GW	htonl(0xc6336401)	/* 198.51.100.1, one NAT */
+#define AMT_TEST_HOST	htonl(0x0a000002)	/* 10.0.0.2, inner host */
+#define AMT_TEST_GROUP	htonl(0xe801013c)	/* 232.1.1.60 */
+#define AMT_TEST_NONCE	htonl(0x5eed1234)
+#define AMT_TEST_MAC	0xa1b2c3d4e5f6ULL
+
+/* A v4 relay-mode amt_dev as amt_dev_init leaves it, minus the netdev
+ * registration. Nothing is sent: the device is never opened, and the
+ * upstream reconciler sees upstream_active == false.
+ */
+static struct amt_dev *amt_test_relay_alloc(struct kunit *test,
+					    const char *name)
+{
+	struct net_device *dev;
+	struct amt_dev *amt;
+
+	dev = alloc_netdev(sizeof(*amt), name, NET_NAME_UNKNOWN,
+			   amt_link_setup);
+	KUNIT_ASSERT_NOT_NULL(test, dev);
+	amt = netdev_priv(dev);
+	amt->dev = dev;
+	amt_upstream_init(amt);
+	spin_lock_init(&amt->lock);
+	INIT_LIST_HEAD(&amt->tunnel_list);
+	amt->mode = AMT_MODE_RELAY;
+	amt->hash_buckets = 8;
+	amt->max_groups = AMT_MAX_GROUP;
+	amt->max_tunnels = AMT_MAX_TUNNELS;
+	amt->max_tunnels_per_source = AMT_MAX_TUNNELS_PER_SOURCE;
+	amt->qrv = 2;
+	amt->qi = AMT_INIT_QUERY_INTERVAL;
+	amt->qri = 10;
+	KUNIT_ASSERT_EQ(test, rhltable_init(&amt->groups_rhl,
+					    &amt_gnode_params), 0);
+	return amt;
+}
+
+static void amt_test_relay_free(struct amt_dev *amt)
+{
+	cancel_delayed_work_sync(&amt->upstream_work);
+	__amt_source_gc_work();
+	rhltable_destroy(&amt->groups_rhl);
+	free_netdev(amt->dev);
+}
+
+/* A tunnel linked on @amt as amt_request_handler() admits one, holding
+ * the nonce and MAC an Update must echo. The admission bounds, the
+ * siphash key and the Request/Query exchange are skipped.
+ */
+static struct amt_tunnel_list *
+amt_test_tunnel_add(struct kunit *test, struct amt_dev *amt, __be32 addr,
+		    __be16 port, __be32 nonce, u64 mac)
+{
+	struct amt_tunnel_list *tunnel;
+
+	tunnel = kzalloc_obj(*tunnel, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
+	tunnel->amt = amt;
+	spin_lock_init(&tunnel->lock);
+	INIT_LIST_HEAD(&tunnel->groups);
+	tunnel->addr.ip4 = addr;
+	tunnel->source_port = port;
+	tunnel->nonce = nonce;
+	tunnel->mac = mac;
+	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
+
+	spin_lock_bh(&amt->lock);
+	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
+	amt->nr_tunnels++;
+	mod_delayed_work(amt_wq, &tunnel->gc_wq,
+			 msecs_to_jiffies(amt_gmi(amt)));
+	spin_unlock_bh(&amt->lock);
+	return tunnel;
+}
+
+/* Offload contract: an in-file fake provider. It logs every
+ * teardown-side callback in order (B bind, G group_disable, E
+ * endpoint_del, U unbind), so registration, binding and the documented
+ * teardown order are asserted without a real provider, and keeps its
+ * own endpoint and group tables so the reconciler's programming can be
+ * checked against what the provider ended up holding.
+ */
+#define AMT_FAKE_LOG_MAX	32
+#define AMT_FAKE_SLOTS		16
+
+struct amt_fake_obj {
+	bool				used;
+	struct amt_offload_endpoint_key	key;	/* endpoints */
+	struct amt_offload_group_key	gkey;	/* groups */
+	u64				gen;	/* groups: staged */
+	u64				committed;
+	u32				nr;
+};
+
+static struct {
+	char			log[AMT_FAKE_LOG_MAX];
+	int			n;
+	u32			families;
+	u32			paths;
+	u32			op_timeout_ms;
+	int			bind_err;
+	/* Relay whose admission state the teardown callbacks sample. */
+	struct amt_dev		*amt;
+	bool			admitted_in_teardown;
+	bool			unpublished_in_teardown;
+	struct amt_fake_obj	eps[AMT_FAKE_SLOTS];
+	struct amt_fake_obj	grps[AMT_FAKE_SLOTS];
+	/* endpoint_add refuses with -ENOSPC once this many are held */
+	int			ep_cap;
+	int			commit_err;
+	/* run once from inside the next group_commit, then cleared */
+	void			(*commit_hook)(void);
+	/* the next endpoint_add overruns op_timeout_ms, then succeeds */
+	bool			add_stall;
+	/* every group_disable and endpoint_del overruns op_timeout_ms */
+	bool			release_stall;
+	/* whether the op that returned last overran, read by the overrun
+	 * stub; every op amt times sets it on entry, or it inherits the
+	 * previous op's verdict
+	 */
+	bool			stalled;
+	/* clear b->admitting from inside the next op named here ('A'
+	 * endpoint_add, 'U' group_update, 'E' endpoint_del), as a teardown
+	 * racing the reconciler would; then cleared
+	 */
+	char			drop_admit;
+	/* group_disable calls on a NULL handle; the contract allows none */
+	int			null_disables;
+	int			ep_adds;
+	/* first uses refused: the key's earlier group was still live */
+	int			dup_grps;
+	int			updates;
+	int			commits;
+	int			flushes;
+	enum amt_offload_result	xmit_res;
+	int			xmits;
+	u64			xmit_gen;
+} amt_fake;
+
+static void amt_fake_reset(u32 families)
+{
+	memset(&amt_fake, 0, sizeof(amt_fake));
+	amt_fake.families = families;
+	amt_fake.paths = BIT(AMT_OFFLOAD_PATH_TX);
+}
+
+static int amt_fake_live(const struct amt_fake_obj *objs)
+{
+	int i, n = 0;
+
+	for (i = 0; i < AMT_FAKE_SLOTS; i++)
+		n += objs[i].used;
+	return n;
+}
+
+static struct amt_fake_obj *amt_fake_slot(struct amt_fake_obj *objs)
+{
+	int i;
+
+	for (i = 0; i < AMT_FAKE_SLOTS; i++) {
+		if (!objs[i].used) {
+			memset(&objs[i], 0, sizeof(objs[i]));
+			objs[i].used = true;
+			return &objs[i];
+		}
+	}
+	return NULL;
+}
+
+/* What a fan-out racing the teardown would see. */
+static void amt_fake_log(char c)
+{
+	if (amt_fake.n < AMT_FAKE_LOG_MAX - 1)
+		amt_fake.log[amt_fake.n++] = c;
+	if (!amt_fake.amt || c == 'B')
+		return;
+	rcu_read_lock();
+	if (amt_offload_tx_admit(amt_fake.amt))
+		amt_fake.admitted_in_teardown = true;
+	if (!rcu_access_pointer(amt_fake.amt->offload))
+		amt_fake.unpublished_in_teardown = true;
+	rcu_read_unlock();
+}
+
+static void amt_fake_drop_admit(struct amt_offload_binding *b, char op)
+{
+	if (amt_fake.drop_admit != op)
+		return;
+	amt_fake.drop_admit = 0;
+	WRITE_ONCE(container_of(b, struct amt_offload_bound, pub)->admitting,
+		   false);
+}
+
+static int amt_fake_bind(struct amt_offload_binding *b,
+			 struct amt_offload_caps *caps)
+{
+	amt_fake_log('B');
+	if (amt_fake.bind_err)
+		return amt_fake.bind_err;
+	caps->families = amt_fake.families;
+	caps->paths = amt_fake.paths;
+	caps->op_timeout_ms = amt_fake.op_timeout_ms;
+	return 0;
+}
+
+static void amt_fake_unbind(struct amt_offload_binding *b)
+{
+	amt_fake_log('U');
+}
+
+/* Idempotent on an identical key, as the contract requires. */
+static int amt_fake_endpoint_add(struct amt_offload_binding *b,
+				 const struct amt_offload_endpoint_key *key,
+				 struct amt_offload_endpoint **ep)
+{
+	struct amt_fake_obj *o;
+	int i;
+
+	amt_fake_drop_admit(b, 'A');
+	amt_fake.stalled = amt_fake.add_stall;
+	amt_fake.add_stall = false;
+	for (i = 0; i < AMT_FAKE_SLOTS; i++) {
+		o = &amt_fake.eps[i];
+		if (o->used && !memcmp(&o->key, key, sizeof(*key))) {
+			*ep = (struct amt_offload_endpoint *)o;
+			return 0;
+		}
+	}
+	if (amt_fake.ep_cap && amt_fake_live(amt_fake.eps) >= amt_fake.ep_cap)
+		return -ENOSPC;
+	o = amt_fake_slot(amt_fake.eps);
+	if (!o)
+		return -ENOSPC;
+	o->key = *key;
+	amt_fake.ep_adds++;
+	*ep = (struct amt_offload_endpoint *)o;
+	return 0;
+}
+
+static void amt_fake_endpoint_del(struct amt_offload_binding *b,
+				  struct amt_offload_endpoint *ep)
+{
+	amt_fake.stalled = amt_fake.release_stall;
+	amt_fake_drop_admit(b, 'E');
+	((struct amt_fake_obj *)ep)->used = false;
+	amt_fake_log('E');
+}
+
+static int amt_fake_group_update(struct amt_offload_binding *b,
+				 const struct amt_offload_group_key *key,
+				 struct amt_offload_endpoint *const *members,
+				 unsigned int nr_members, u64 gen,
+				 struct amt_offload_group **grp)
+{
+	struct amt_fake_obj *o = (struct amt_fake_obj *)*grp;
+	int i;
+
+	amt_fake.stalled = false;
+	amt_fake_drop_admit(b, 'U');
+	if (!o) {
+		/* One group per key, as amt promises: refuse a second. */
+		for (i = 0; i < AMT_FAKE_SLOTS; i++) {
+			o = &amt_fake.grps[i];
+			if (o->used && !memcmp(&o->gkey, key, sizeof(*key))) {
+				amt_fake.dup_grps++;
+				return -EEXIST;
+			}
+		}
+		o = amt_fake_slot(amt_fake.grps);
+		if (!o)
+			return -ENOSPC;
+		o->gkey = *key;
+		*grp = (struct amt_offload_group *)o;
+	}
+	o->gen = gen;
+	o->nr = nr_members;
+	amt_fake.updates++;
+	return 0;
+}
+
+static int amt_fake_group_commit(struct amt_offload_binding *b,
+				 struct amt_offload_group *grp, u64 gen)
+{
+	void (*hook)(void) = amt_fake.commit_hook;
+
+	amt_fake.stalled = false;
+	if (hook) {
+		amt_fake.commit_hook = NULL;
+		hook();
+	}
+	if (amt_fake.commit_err)
+		return amt_fake.commit_err;
+	((struct amt_fake_obj *)grp)->committed = gen;
+	amt_fake.commits++;
+	return 0;
+}
+
+static void amt_fake_group_disable(struct amt_offload_binding *b,
+				   struct amt_offload_group *grp)
+{
+	amt_fake.stalled = grp && amt_fake.release_stall;
+	if (!grp) {
+		amt_fake.null_disables++;
+		return;
+	}
+	((struct amt_fake_obj *)grp)->used = false;
+	amt_fake_log('G');
+}
+
+static void amt_fake_flush(struct amt_offload_binding *b)
+{
+	int i;
+
+	for (i = 0; i < AMT_FAKE_SLOTS; i++) {
+		amt_fake.eps[i].used = false;
+		amt_fake.grps[i].used = false;
+	}
+	amt_fake.flushes++;
+}
+
+static enum amt_offload_result
+amt_fake_xmit(struct amt_offload_binding *b, struct amt_offload_group *grp,
+	      struct sk_buff *skb, u64 gen)
+{
+	amt_fake.xmits++;
+	amt_fake.xmit_gen = gen;
+	if (amt_fake.xmit_res == AMT_OFFLOAD_CONSUMED)
+		consume_skb(skb);
+	return amt_fake.xmit_res;
+}
+
+static const struct amt_offload_ops amt_fake_ops = {
+	.bind		= amt_fake_bind,
+	.unbind		= amt_fake_unbind,
+	.endpoint_add	= amt_fake_endpoint_add,
+	.endpoint_del	= amt_fake_endpoint_del,
+	.group_update	= amt_fake_group_update,
+	.group_commit	= amt_fake_group_commit,
+	.group_disable	= amt_fake_group_disable,
+	.flush		= amt_fake_flush,
+	.xmit		= amt_fake_xmit,
+};
+
+static struct net_device *amt_test_lower_alloc(struct kunit *test)
+{
+	struct net_device *lower;
+
+	lower = alloc_netdev(0, "amtlow%d", NET_NAME_UNKNOWN, ether_setup);
+	KUNIT_ASSERT_NOT_NULL(test, lower);
+	return lower;
+}
+
+/* A relay on @lower as amt_newlink leaves it, minus the netlink half.
+ * Caller holds RTNL.
+ */
+static struct amt_dev *amt_test_offload_relay(struct kunit *test,
+					      const char *name,
+					      struct net_device *lower,
+					      u32 mode)
+{
+	struct amt_dev *amt = amt_test_relay_alloc(test, name);
+
+	amt->stream_dev = lower;
+	amt->offload_mode = mode;
+	return amt;
+}
+
+static void amt_test_offload_free(struct amt_dev *amt)
+{
+	rtnl_lock();
+	amt_offload_detach(amt);
+	rtnl_unlock();
+	amt_ofl_state_free(amt);
+	amt_test_relay_free(amt);
+}
+
+/* A tunnel the offload hooks can name: endpoint identity only. */
+static struct amt_tunnel_list *amt_test_ofl_tunnel(struct kunit *test,
+						   __be32 addr, __be16 port)
+{
+	struct amt_tunnel_list *t = kunit_kzalloc(test, sizeof(*t),
+						  GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, t);
+	t->addr.ip4 = addr;
+	t->source_port = port;
+	return t;
+}
+
+static union amt_addr amt_test_ofl_group(int i)
+{
+	union amt_addr g = {};
+
+	g.ip4 = htonl(ntohl(AMT_TEST_GROUP) + i);
+	return g;
+}
+
+/* Run reconciler ticks until it reports no work left; returns the count. */
+static int amt_test_ofl_drain(struct amt_dev *amt)
+{
+	int ticks = 0;
+
+	while (ticks < 1000 && amt_ofl_reconcile(amt))
+		ticks++;
+	return ticks + 1;
+}
+
+static int amt_test_offload_cnt(struct amt_dev *amt,
+				enum amt_offload_counter cnt)
+{
+	return atomic_read(&amt->offload_cnt[cnt]);
+}
+
+/* Two groups and two endpoints the teardown must give back, programmed
+ * through desired state and the reconciler. RTNL held.
+ */
+static void amt_test_offload_seed(struct kunit *test, struct amt_dev *amt)
+{
+	union amt_addr grp;
+	int i;
+
+	KUNIT_ASSERT_NOT_NULL(test, rtnl_dereference(amt->offload));
+	for (i = 0; i < 2; i++) {
+		grp = amt_test_ofl_group(i);
+		amt_ofl_member_add(amt, amt_test_ofl_tunnel(test, AMT_TEST_GW,
+							   htons(4000 + i)),
+				   &grp, false);
+	}
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.grps), 2);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.eps), 2);
+}
+
+static bool amt_test_offload_admits(struct amt_dev *amt)
+{
+	bool ok;
+
+	rcu_read_lock();
+	ok = !!amt_offload_tx_admit(amt);
+	rcu_read_unlock();
+	return ok;
+}
+
+static void amt_offload_register_when_bound_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_dev *amt, *sw;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4 | AMT_OFFLOAD_FAMILY_V6);
+	amt = amt_test_offload_relay(test, "amtob%d", lower,
+				     AMT_OFFLOAD_MODE_AUTO);
+	sw = amt_test_offload_relay(test, "amtos%d", lower,
+				    AMT_OFFLOAD_MODE_SOFTWARE);
+
+	rtnl_lock();
+	/* No provider yet: auto attaches in software. */
+	KUNIT_EXPECT_EQ(test, amt_offload_attach(amt, NULL), 0);
+	KUNIT_EXPECT_EQ(test, amt_offload_attach(sw, NULL), 0);
+	KUNIT_EXPECT_NULL(test, rtnl_dereference(amt->offload));
+
+	/* Registering on a stream_dev in use binds the auto relay at once. */
+	KUNIT_EXPECT_EQ(test, amt_offload_register(lower, &amt_fake_ops), 0);
+	KUNIT_EXPECT_NOT_NULL(test, rtnl_dereference(amt->offload));
+	KUNIT_EXPECT_NULL(test, rtnl_dereference(sw->offload));
+	KUNIT_EXPECT_TRUE(test, amt_test_offload_admits(amt));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt, AMT_OFFLOAD_CNT_BIND), 1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_BIND_ON_REGISTER), 1);
+	KUNIT_EXPECT_EQ(test, amt->offload_epoch, 1);
+	KUNIT_EXPECT_EQ(test, amt_offload_register(lower, &amt_fake_ops),
+			-EEXIST);
+
+	amt_offload_unregister(lower);
+	KUNIT_EXPECT_NULL(test, rtnl_dereference(amt->offload));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_TEARDOWN_PROVIDER), 1);
+	KUNIT_EXPECT_EQ(test, amt->offload_epoch, 2);
+	amt_offload_unregister(lower);	/* no provider: a no-op */
+	rtnl_unlock();
+
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "BU");
+	amt_test_offload_free(sw);
+	amt_test_offload_free(amt);
+	free_netdev(lower);
+}
+
+static void amt_offload_family_unsupported_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_dev *amt, *amt2;
+
+	/* A v6-only provider and a v4 relay. */
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V6);
+	amt = amt_test_offload_relay(test, "amtof%d", lower,
+				     AMT_OFFLOAD_MODE_AUTO);
+	amt2 = amt_test_offload_relay(test, "amtoe%d", lower,
+				      AMT_OFFLOAD_MODE_AUTO);
+
+	rtnl_lock();
+	KUNIT_ASSERT_EQ(test, amt_offload_register(lower, &amt_fake_ops), 0);
+	KUNIT_EXPECT_EQ(test, amt_offload_attach(amt, NULL), 0);
+	KUNIT_EXPECT_NULL(test, rtnl_dereference(amt->offload));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_FAMILY_UNSUPPORTED), 1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt, AMT_OFFLOAD_CNT_BIND), 0);
+
+	/* A bind() error is a different count and never reaches unbind(). */
+	amt_fake.bind_err = -EIO;
+	KUNIT_EXPECT_EQ(test, amt_offload_attach(amt2, NULL), 0);
+	KUNIT_EXPECT_NULL(test, rtnl_dereference(amt2->offload));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt2,
+			AMT_OFFLOAD_CNT_BIND_FAILED), 1);
+	amt_offload_unregister(lower);
+	rtnl_unlock();
+
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "BUB");
+	amt_test_offload_free(amt2);
+	amt_test_offload_free(amt);
+	free_netdev(lower);
+}
+
+/* The stream_dev is unregistered with groups programmed. A fan-out
+ * racing the teardown must not be admitted at any step, while the
+ * binding stays published until after unbind().
+ */
+static void amt_offload_unregister_mid_fanout_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_dev *amt;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt = amt_test_offload_relay(test, "amtom%d", lower,
+				     AMT_OFFLOAD_MODE_AUTO);
+
+	rtnl_lock();
+	KUNIT_ASSERT_EQ(test, amt_offload_register(lower, &amt_fake_ops), 0);
+	KUNIT_ASSERT_EQ(test, amt_offload_attach(amt, NULL), 0);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_BIND_ON_REGISTER), 0);
+	KUNIT_EXPECT_TRUE(test, amt_test_offload_admits(amt));
+	amt_test_offload_seed(test, amt);
+	amt_fake.amt = amt;
+
+	amt_offload_lower_gone(lower);
+	KUNIT_EXPECT_NULL(test, rtnl_dereference(amt->offload));
+	KUNIT_EXPECT_NULL(test, amt_offload_provider_find(lower));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_TEARDOWN_LOWER), 1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_TEARDOWN_PROVIDER), 0);
+	rtnl_unlock();
+
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "BGGEEU");
+	KUNIT_EXPECT_FALSE(test, amt_fake.admitted_in_teardown);
+	KUNIT_EXPECT_FALSE(test, amt_fake.unpublished_in_teardown);
+	KUNIT_EXPECT_FALSE(test, amt_test_offload_admits(amt));
+	amt_test_offload_free(amt);
+	free_netdev(lower);
+}
+
+/* Same order when the provider leaves first. A required relay drops
+ * carrier, counts it, and comes back when a provider registers again.
+ */
+static void amt_offload_provider_unregister_order_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_dev *amt;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt = amt_test_offload_relay(test, "amtop%d", lower,
+				     AMT_OFFLOAD_MODE_REQUIRED);
+
+	rtnl_lock();
+	KUNIT_ASSERT_EQ(test, amt_offload_register(lower, &amt_fake_ops), 0);
+	KUNIT_ASSERT_EQ(test, amt_offload_attach(amt, NULL), 0);
+	amt_test_offload_seed(test, amt);
+	amt_fake.amt = amt;
+
+	amt_offload_unregister(lower);
+	KUNIT_EXPECT_NULL(test, rtnl_dereference(amt->offload));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_TEARDOWN_PROVIDER), 1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_REQUIRED_UNBOUND), 1);
+	KUNIT_EXPECT_FALSE(test, netif_carrier_ok(amt->dev));
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "BGGEEU");
+	KUNIT_EXPECT_FALSE(test, amt_fake.admitted_in_teardown);
+
+	amt_fake.amt = NULL;
+	KUNIT_EXPECT_EQ(test, amt_offload_register(lower, &amt_fake_ops), 0);
+	KUNIT_EXPECT_NOT_NULL(test, rtnl_dereference(amt->offload));
+	KUNIT_EXPECT_TRUE(test, netif_carrier_ok(amt->dev));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_BIND_ON_REGISTER), 1);
+	amt_offload_unregister(lower);
+	rtnl_unlock();
+
+	amt_test_offload_free(amt);
+	free_netdev(lower);
+}
+
+struct amt_test_u32_attr {
+	struct nlattr	nla;
+	u32		val;
+};
+
+static struct nlattr *amt_test_u32(struct amt_test_u32_attr *a, int type,
+				   u32 val)
+{
+	a->nla.nla_len = nla_attr_size(sizeof(u32));
+	a->nla.nla_type = type;
+	a->val = val;
+	return &a->nla;
+}
+
+static int amt_test_validate_offload(u32 mode, u32 offload,
+				     struct netlink_ext_ack *extack)
+{
+	struct amt_test_u32_attr link, amode, local, off;
+	struct nlattr *data[IFLA_AMT_MAX + 1] = {};
+
+	data[IFLA_AMT_LINK] = amt_test_u32(&link, IFLA_AMT_LINK, 1);
+	data[IFLA_AMT_MODE] = amt_test_u32(&amode, IFLA_AMT_MODE, mode);
+	data[IFLA_AMT_LOCAL_IP] = amt_test_u32(&local, IFLA_AMT_LOCAL_IP,
+					       (__force u32)AMT_TEST_GW);
+	data[IFLA_AMT_OFFLOAD_MODE] = amt_test_u32(&off, IFLA_AMT_OFFLOAD_MODE,
+						   offload);
+	memset(extack, 0, sizeof(*extack));
+	return amt_validate(NULL, data, extack);
+}
+
+static void amt_offload_mode_validate_test(struct kunit *test)
+{
+	struct netlink_ext_ack extack;
+
+	KUNIT_EXPECT_EQ(test, amt_test_validate_offload(AMT_MODE_RELAY,
+			AMT_OFFLOAD_MODE_SOFTWARE, &extack), 0);
+	KUNIT_EXPECT_EQ(test, amt_test_validate_offload(AMT_MODE_RELAY,
+			AMT_OFFLOAD_MODE_AUTO, &extack), 0);
+	KUNIT_EXPECT_EQ(test, amt_test_validate_offload(AMT_MODE_RELAY,
+			AMT_OFFLOAD_MODE_REQUIRED, &extack), 0);
+
+	KUNIT_EXPECT_EQ(test, amt_test_validate_offload(AMT_MODE_RELAY,
+			AMT_OFFLOAD_MODE_MAX + 1, &extack), -EINVAL);
+	KUNIT_ASSERT_NOT_NULL(test, extack._msg);
+	KUNIT_EXPECT_STREQ(test, extack._msg, "Offload mode is not valid");
+
+	KUNIT_EXPECT_EQ(test, amt_test_validate_offload(AMT_MODE_GATEWAY,
+			AMT_OFFLOAD_MODE_AUTO, &extack), -EINVAL);
+	KUNIT_ASSERT_NOT_NULL(test, extack._msg);
+	KUNIT_EXPECT_STREQ(test, extack._msg,
+			   "Offload is only valid in relay mode");
+}
+
+static void amt_offload_required_refused_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct netlink_ext_ack extack = {};
+	struct amt_dev *amt;
+	int before;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V6);
+	amt = amt_test_offload_relay(test, "amtor%d", lower,
+				     AMT_OFFLOAD_MODE_REQUIRED);
+	before = atomic_read(&amt_offload_required_refused);
+
+	rtnl_lock();
+	/* No provider at all. */
+	KUNIT_EXPECT_EQ(test, amt_offload_attach(amt, &extack), -ENODEV);
+	KUNIT_EXPECT_NOT_NULL(test, extack._msg);
+	KUNIT_EXPECT_TRUE(test, list_empty(&amt->offload_node));
+	KUNIT_EXPECT_EQ(test, atomic_read(&amt_offload_required_refused),
+			before + 1);
+
+	/* A provider that cannot carry this relay's outer family. */
+	KUNIT_ASSERT_EQ(test, amt_offload_register(lower, &amt_fake_ops), 0);
+	memset(&extack, 0, sizeof(extack));
+	KUNIT_EXPECT_EQ(test, amt_offload_attach(amt, &extack), -ENODEV);
+	KUNIT_EXPECT_NOT_NULL(test, extack._msg);
+	KUNIT_EXPECT_EQ(test, atomic_read(&amt_offload_required_refused),
+			before + 2);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_FAMILY_UNSUPPORTED), 1);
+
+	/* auto with the same provider is not a refusal. */
+	amt->offload_mode = AMT_OFFLOAD_MODE_AUTO;
+	KUNIT_EXPECT_EQ(test, amt_offload_attach(amt, &extack), 0);
+	KUNIT_EXPECT_EQ(test, atomic_read(&amt_offload_required_refused),
+			before + 2);
+	amt_offload_unregister(lower);
+	rtnl_unlock();
+
+	amt_test_offload_free(amt);
+	free_netdev(lower);
+}
+
+/* Offload contract: desired state, reconciler and cutover, driven
+ * by hand -- the reconciler work is disabled and amt_ofl_reconcile()
+ * called directly, so every tick is the test's.
+ */
+static struct amt_dev *amt_test_ofl_attach(struct kunit *test,
+					   const char *name,
+					   struct net_device *lower, u32 mode)
+{
+	struct amt_dev *amt = amt_test_offload_relay(test, name, lower, mode);
+
+	rtnl_lock();
+	KUNIT_EXPECT_EQ(test, amt_offload_attach(amt, NULL), 0);
+	rtnl_unlock();
+	KUNIT_ASSERT_NOT_NULL(test, amt->offload_st);
+	disable_work_sync(&amt->offload_st->work);
+	return amt;
+}
+
+/* Whether a provider op overran op_timeout_ms is the fake's call, not the
+ * clock's: on a loaded machine a 10 ms timeout against ktime_get() also
+ * fires on ops that never stalled. The reconciler runs on the test thread
+ * here (its work is disabled), so the stub reaches every timed op.
+ */
+static bool amt_test_ofl_op_overran(struct amt_offload_bound *b, ktime_t t0)
+{
+	return b->caps.op_timeout_ms && amt_fake.stalled;
+}
+
+static void amt_test_ofl_register(struct kunit *test, struct net_device *lower)
+{
+	int err;
+
+	kunit_activate_static_stub(test, amt_ofl_op_overran,
+				   amt_test_ofl_op_overran);
+	rtnl_lock();
+	err = amt_offload_register(lower, &amt_fake_ops);
+	rtnl_unlock();
+	KUNIT_ASSERT_EQ(test, err, 0);
+}
+
+static void amt_test_ofl_done(struct amt_dev *amt, struct net_device *lower)
+{
+	rtnl_lock();
+	amt_offload_unregister(lower);
+	rtnl_unlock();
+	amt_test_offload_free(amt);
+	free_netdev(lower);
+}
+
+static void amt_test_ofl_join(struct amt_dev *amt, struct amt_tunnel_list *t,
+			      int i, bool join)
+{
+	union amt_addr g = amt_test_ofl_group(i);
+
+	if (join)
+		amt_ofl_member_add(amt, t, &g, false);
+	else
+		amt_ofl_member_del(amt, t, &g, false);
+}
+
+static struct amt_ofl_grp *amt_test_ofl_grp(struct amt_dev *amt, int i)
+{
+	union amt_addr a = amt_test_ofl_group(i);
+	struct amt_offload_group_key key;
+	struct amt_ofl_grp *g;
+
+	amt_ofl_grp_key(&key, &a, false);
+	spin_lock_bh(&amt->offload_st->lock);
+	g = amt_ofl_grp_find(amt->offload_st, &key);
+	spin_unlock_bh(&amt->offload_st->lock);
+	return g;
+}
+
+static bool amt_test_ofl_tx(struct amt_dev *amt, struct sk_buff *skb, int i)
+{
+	union amt_addr g = amt_test_ofl_group(i);
+
+	return amt_offload_tx(amt, skb, &g, false);
+}
+
+static bool amt_test_ofl_no_eps(struct amt_dev *amt)
+{
+	u32 i;
+
+	for (i = 0; i < 1U << amt->offload_st->ep_bits; i++)
+		if (!hlist_empty(&amt->offload_st->eps[i]))
+			return false;
+	return true;
+}
+
+/* Members follow gnodes: the first gnode of a group on a tunnel adds
+ * the member, a second (another inner host) only counts, the last one
+ * removes it; unlink removes it at once and the gnodes deleted after it
+ * find nothing.
+ */
+static void amt_offload_member_gnode_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	union amt_addr grp = amt_test_ofl_group(0), h1 = {}, h2 = {};
+	struct amt_group_node *g1, *g2;
+	struct amt_tunnel_list *tunnel;
+	struct amt_ofl_grp *og;
+	struct amt_dev *amt;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt = amt_test_ofl_attach(test, "amton%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	tunnel = amt_test_tunnel_add(test, amt, AMT_TEST_GW, htons(4000),
+				     AMT_TEST_NONCE, AMT_TEST_MAC);
+	h1.ip4 = AMT_TEST_HOST;
+	h2.ip4 = htonl(ntohl(AMT_TEST_HOST) + 1);
+
+	spin_lock_bh(&tunnel->lock);
+	g1 = amt_add_group(amt, tunnel, &grp, &h1, false);
+	g2 = amt_add_group(amt, tunnel, &grp, &h2, false);
+	spin_unlock_bh(&tunnel->lock);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(g1));
+	KUNIT_ASSERT_FALSE(test, IS_ERR(g2));
+	og = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, og);
+	KUNIT_EXPECT_EQ(test, og->nr_members, 1);
+	KUNIT_EXPECT_EQ(test, og->gen, 1);
+	KUNIT_EXPECT_EQ(test, og->state, AMT_OFL_DIRTY);
+
+	spin_lock_bh(&tunnel->lock);
+	amt_del_group(amt, g1);
+	spin_unlock_bh(&tunnel->lock);
+	KUNIT_EXPECT_EQ(test, og->nr_members, 1);
+	KUNIT_EXPECT_EQ(test, og->gen, 1);
+	spin_lock_bh(&tunnel->lock);
+	amt_del_group(amt, g2);
+	spin_unlock_bh(&tunnel->lock);
+	KUNIT_EXPECT_EQ(test, og->nr_members, 0);
+	KUNIT_EXPECT_EQ(test, og->gen, 2);
+
+	spin_lock_bh(&tunnel->lock);
+	g1 = amt_add_group(amt, tunnel, &grp, &h1, false);
+	spin_unlock_bh(&tunnel->lock);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(g1));
+	KUNIT_EXPECT_EQ(test, og->nr_members, 1);
+	/* Unlink alone, as amt_dev_stop() does before it cancels the
+	 * tunnel's gc work: g1 is still in amt->groups_rhl and on
+	 * tunnel->groups, yet the member is gone.
+	 */
+	spin_lock_bh(&amt->lock);
+	amt_tunnel_unlink(amt, tunnel);
+	spin_unlock_bh(&amt->lock);
+	KUNIT_EXPECT_EQ(test, og->nr_members, 0);
+	KUNIT_EXPECT_EQ(test, og->gen, 4);
+	cancel_delayed_work_sync(&tunnel->gc_wq);
+	amt_clear_groups(tunnel);
+	kfree_rcu(tunnel, rcu);
+	KUNIT_EXPECT_EQ(test, og->gen, 4);	/* g1's delete found nothing */
+
+	/* Unbound: the reconciler only frees the emptied records. */
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_NULL(test, amt_test_ofl_grp(amt, 0));
+	KUNIT_EXPECT_TRUE(test, amt_test_ofl_no_eps(amt));
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 0);
+	amt_test_offload_free(amt);
+	free_netdev(lower);
+}
+
+/* Churn between ticks coalesces into one update and one commit at the
+ * last generation; a tick starts no group once its budget is spent.
+ */
+static void amt_offload_budget_coalesce_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *t[4], *u[3];
+	struct amt_ofl_grp *og;
+	struct amt_dev *amt;
+	int i, round;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtoc%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 4; i++)
+		t[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000 + i));
+	for (round = 0; round < 25; round++) {
+		for (i = 0; i < 4; i++) {
+			amt_test_ofl_join(amt, t[i], 0, true);
+			if (round < 24)
+				amt_test_ofl_join(amt, t[i], 0, false);
+		}
+	}
+	og = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, og);
+	KUNIT_EXPECT_EQ(test, og->nr_members, 4);
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 1);
+	KUNIT_EXPECT_EQ(test, amt_fake.commits, 1);
+	KUNIT_EXPECT_EQ(test, amt_fake.ep_adds, 4);
+	KUNIT_ASSERT_TRUE(test, og->hw_active);
+	KUNIT_EXPECT_EQ(test, og->hw_gen, og->gen);
+	KUNIT_EXPECT_EQ(test, ((struct amt_fake_obj *)og->hw)->committed,
+			og->gen);
+	KUNIT_EXPECT_EQ(test, ((struct amt_fake_obj *)og->hw)->nr, 4);
+
+	/* Three groups at three ops each (endpoint_add, update, commit):
+	 * a budget of 3 programs one group per tick.
+	 */
+	amt->offload_st->budget = 3;
+	for (i = 0; i < 3; i++) {
+		u[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(5000 + i));
+		amt_test_ofl_join(amt, u[i], i + 1, true);
+	}
+	KUNIT_EXPECT_TRUE(test, amt_ofl_reconcile(amt));
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 2);
+	KUNIT_EXPECT_TRUE(test, amt_ofl_reconcile(amt));
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 3);
+	KUNIT_EXPECT_FALSE(test, amt_ofl_reconcile(amt));
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 4);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.grps), 4);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* A group the provider refuses goes to software (the remainder) and is
+ * not retried on its own member changes; it is retried once the
+ * provider holds an eighth fewer objects than when it refused.
+ */
+static void amt_offload_enospc_hysteresis_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_ofl_grp *a, *b;
+	struct amt_tunnel_list *t[3];
+	struct amt_dev *amt;
+	int i, updates;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.ep_cap = 2;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtos%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 3; i++)
+		t[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000 + i));
+	amt_test_ofl_join(amt, t[0], 0, true);
+	amt_test_ofl_join(amt, t[1], 0, true);
+	amt_test_ofl_drain(amt);
+	a = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, a);
+	KUNIT_EXPECT_TRUE(test, a->hw_active);
+	KUNIT_EXPECT_EQ(test, amt->offload_st->hw_objs, 3);
+
+	amt_test_ofl_join(amt, t[2], 1, true);
+	amt_test_ofl_drain(amt);
+	b = amt_test_ofl_grp(amt, 1);
+	KUNIT_ASSERT_NOT_NULL(test, b);
+	KUNIT_EXPECT_FALSE(test, b->hw_active);
+	KUNIT_EXPECT_EQ(test, b->state, AMT_OFL_PARKED);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_SW_REMAINDER), 1);
+	KUNIT_EXPECT_TRUE(test, a->hw_active);
+
+	/* Parked: a member change does not retry it. */
+	updates = amt_fake.updates;
+	amt_test_ofl_join(amt, t[1], 1, true);
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_EQ(test, b->state, AMT_OFL_PARKED);
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, updates);
+
+	/* t[0] leaves A: A is recommitted without it and its endpoint is
+	 * deleted, which crosses the low watermark and retries B.
+	 */
+	amt_test_ofl_join(amt, t[0], 0, false);
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_TRUE(test, a->hw_active);
+	KUNIT_EXPECT_EQ(test, ((struct amt_fake_obj *)a->hw)->nr, 1);
+	KUNIT_ASSERT_TRUE(test, b->hw_active);
+	KUNIT_EXPECT_EQ(test, ((struct amt_fake_obj *)b->hw)->nr, 2);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.eps), 2);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_SW_REMAINDER), 1);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* An op that overruns op_timeout_ms resets the provider: flush, a new
+ * epoch, the late result ignored, and a replay from desired state.
+ */
+static void amt_offload_timeout_reset_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *t;
+	struct amt_ofl_grp *og;
+	struct amt_dev *amt;
+	u64 epoch;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.op_timeout_ms = 10;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtot%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	epoch = amt->offload_epoch;
+	t = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000));
+	amt_test_ofl_join(amt, t, 0, true);
+	amt_fake.add_stall = true;
+	amt_test_ofl_drain(amt);
+
+	KUNIT_EXPECT_EQ(test, amt_fake.flushes, 1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt, AMT_OFFLOAD_CNT_RESET),
+			1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt, AMT_OFFLOAD_CNT_STALE),
+			1);
+	KUNIT_EXPECT_EQ(test, amt->offload_epoch, epoch + 1);
+	/* The late handle died with the flush; the replay added it again. */
+	KUNIT_EXPECT_EQ(test, amt_fake.ep_adds, 2);
+	og = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, og);
+	KUNIT_EXPECT_TRUE(test, og->hw_active);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.eps), 1);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.grps), 1);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* A reset late in a tick must not reach a group emptied earlier in it:
+ * the flush already took its handle, so amt neither disables it again nor
+ * counts it out of hw_objs a second time.
+ */
+static void amt_offload_reset_after_empty_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *t1, *t2;
+	struct amt_dev *amt;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.op_timeout_ms = 10;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtoe%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	t1 = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000));
+	t2 = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4001));
+	amt_test_ofl_join(amt, t1, 0, true);
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.grps), 1);
+
+	/* One tick: group 0 empties, then group 1's endpoint_add overruns. */
+	amt_test_ofl_join(amt, t1, 0, false);
+	amt_test_ofl_join(amt, t2, 1, true);
+	amt_fake.add_stall = true;
+	amt_test_ofl_drain(amt);
+
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt, AMT_OFFLOAD_CNT_RESET),
+			1);
+	KUNIT_EXPECT_EQ(test, amt_fake.null_disables, 0);
+	KUNIT_EXPECT_NULL(test, amt_test_ofl_grp(amt, 0));
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.eps), 1);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.grps), 1);
+	KUNIT_EXPECT_EQ(test, amt->offload_st->hw_objs, 2U);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* Teardown's release ops are timed: a provider that stalls
+ * in group_disable/endpoint_del costs one op under RTNL, then a flush,
+ * not one stall per object. Untimed, the log reads "BGGEEU".
+ */
+static void amt_offload_teardown_release_stall_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *t[2];
+	struct amt_dev *amt;
+	int i;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.op_timeout_ms = 10;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtor%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 2; i++) {
+		t[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000 + i));
+		amt_test_ofl_join(amt, t[i], i, true);
+	}
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.grps), 2);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.eps), 2);
+
+	amt_fake.release_stall = true;
+	rtnl_lock();
+	amt_offload_unregister(lower);
+	rtnl_unlock();
+	amt_fake.release_stall = false;
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "BGU");
+	KUNIT_EXPECT_EQ(test, amt_fake.flushes, 1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt, AMT_OFFLOAD_CNT_RESET),
+			1);
+	KUNIT_EXPECT_EQ(test, amt->offload_st->hw_objs, 0U);
+	/* The group the overrun never reached is unpublished too. */
+	for (i = 0; i < 2; i++)
+		KUNIT_EXPECT_FALSE(test,
+				   READ_ONCE(amt_test_ofl_grp(amt, i)->hw_active));
+	/* Both groups were uncommitted, the disabled one and the forgotten
+	 * one, so once their members leave both endpoints are collected.
+	 */
+	for (i = 0; i < 2; i++)
+		amt_test_ofl_join(amt, t[i], i, false);
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_TRUE(test, amt_test_ofl_no_eps(amt));
+	amt_test_offload_free(amt);
+	free_netdev(lower);
+}
+
+/* Teardown with only endpoints programmed (the group parked): the first
+ * endpoint_del to overrun ends it. Untimed, the log reads "BGEEU".
+ */
+static void amt_offload_teardown_ep_stall_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_dev *amt;
+	int i;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.op_timeout_ms = 10;
+	amt_fake.commit_err = -EIO;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtot%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 2; i++)
+		amt_test_ofl_join(amt, amt_test_ofl_tunnel(test, AMT_TEST_GW,
+							   htons(4000 + i)),
+				  0, true);
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_EQ(test, amt_test_ofl_grp(amt, 0)->state, AMT_OFL_PARKED);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.grps), 0);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.eps), 2);
+
+	amt_fake.release_stall = true;
+	rtnl_lock();
+	amt_offload_unregister(lower);
+	rtnl_unlock();
+	amt_fake.release_stall = false;
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "BGEU");
+	KUNIT_EXPECT_EQ(test, amt_fake.flushes, 1);
+	KUNIT_EXPECT_EQ(test, amt->offload_st->hw_objs, 0U);
+	amt_test_offload_free(amt);
+	free_netdev(lower);
+}
+
+/* The gone and GC loops time their release ops too: one
+ * stall, then a flush, not one per object. Each part needs its own relay,
+ * because a gone-loop reset forgets every handle and the GC loop then has
+ * nothing to delete.
+ */
+static struct amt_dev *amt_test_ofl_stall_setup(struct kunit *test,
+						struct net_device *lower,
+						struct amt_tunnel_list **t)
+{
+	struct amt_dev *amt;
+	int i;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.op_timeout_ms = 10;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtos%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 2; i++) {
+		t[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000 + i));
+		amt_test_ofl_join(amt, t[i], i, true);
+	}
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.grps), 2);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.eps), 2);
+	return amt;
+}
+
+static void amt_offload_reconcile_release_stall_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *t[3];
+	struct amt_dev *amt;
+	int i;
+
+	/* (a) Two groups empty in one tick: the first group_disable
+	 * overruns and resets. Untimed, the GC loop resets one op later
+	 * and the log reads "BGGE".
+	 */
+	amt = amt_test_ofl_stall_setup(test, lower, t);
+	for (i = 0; i < 2; i++)
+		amt_test_ofl_join(amt, t[i], i, false);
+	amt_fake.release_stall = true;
+	amt_ofl_reconcile(amt);
+	amt_fake.release_stall = false;
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "BG");
+	KUNIT_EXPECT_EQ(test, amt_fake.flushes, 1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt, AMT_OFFLOAD_CNT_RESET),
+			1);
+	KUNIT_EXPECT_EQ(test, amt_fake.null_disables, 0);
+	/* The reset uncommitted the group it forgot: both endpoints go. */
+	KUNIT_EXPECT_TRUE(test, amt_test_ofl_no_eps(amt));
+	amt_test_ofl_done(amt, lower);
+
+	/* (b) One endpoint leaves a group, nothing empties: its
+	 * endpoint_del overruns and resets. hw_objs is counted down before
+	 * the op, so the reset's zeroing is final.
+	 */
+	lower = amt_test_lower_alloc(test);
+	amt = amt_test_ofl_stall_setup(test, lower, t);
+	t[2] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4002));
+	amt_test_ofl_join(amt, t[2], 0, true);
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.eps), 3);
+	amt_test_ofl_join(amt, t[2], 0, false);
+	amt_fake.release_stall = true;
+	amt_ofl_reconcile(amt);
+	amt_fake.release_stall = false;
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "BE");
+	KUNIT_EXPECT_EQ(test, amt_fake.flushes, 1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt, AMT_OFFLOAD_CNT_RESET),
+			1);
+	KUNIT_EXPECT_EQ(test, amt->offload_st->hw_objs, 0U);
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_EQ(test, amt->offload_st->hw_objs,
+			(unsigned int)(amt_fake_live(amt_fake.eps) +
+				       amt_fake_live(amt_fake.grps)));
+	amt_test_ofl_done(amt, lower);
+}
+
+/* One group re-dirtied from inside every group_commit: the churn the
+ * hook drives spends each tick's budget on that group.
+ */
+static struct {
+	struct amt_dev			*amt;
+	struct amt_tunnel_list		*t;
+	bool				in;
+	bool				on;
+} amt_test_churn;
+
+static void amt_test_churn_hook(void)
+{
+	if (!amt_test_churn.on)
+		return;
+	amt_test_churn.in = !amt_test_churn.in;
+	amt_test_ofl_join(amt_test_churn.amt, amt_test_churn.t, 0,
+			  amt_test_churn.in);
+	amt_fake.commit_hook = amt_test_churn_hook;
+}
+
+static bool amt_test_fake_ep_held(const struct amt_offload_endpoint_key *key)
+{
+	int i;
+
+	for (i = 0; i < AMT_FAKE_SLOTS; i++)
+		if (amt_fake.eps[i].used &&
+		    !memcmp(&amt_fake.eps[i].key, key, sizeof(*key)))
+			return true;
+	return false;
+}
+
+/* Endpoint GC does not wait for st->dirty to empty: under
+ * sustained churn in one group, a departed endpoint that no committed
+ * group names is deleted within a bounded number of ticks. Gated on an
+ * empty st->dirty it never is.
+ */
+static void amt_offload_gc_churn_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *stay, *churn, *gone;
+	struct amt_offload_endpoint_key key, ckey;
+	struct amt_dev *amt;
+	int tick;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtog%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	stay = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000));
+	churn = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4001));
+	gone = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4002));
+	amt_test_ofl_join(amt, stay, 0, true);
+	amt_test_ofl_join(amt, churn, 0, true);
+	amt_test_ofl_join(amt, gone, 1, true);
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.eps), 3);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.grps), 2);
+	amt_ofl_ep_key(&key, amt, gone);
+	KUNIT_ASSERT_TRUE(test, amt_test_fake_ep_held(&key));
+	amt_ofl_ep_key(&ckey, amt, churn);
+
+	amt->offload_st->budget = 6;
+	memset(&amt_test_churn, 0, sizeof(amt_test_churn));
+	amt_test_churn.amt = amt;
+	amt_test_churn.t = churn;
+	amt_test_churn.on = true;
+	amt_test_ofl_join(amt, churn, 0, false);
+	amt_test_ofl_join(amt, gone, 1, false);
+	amt_fake.commit_hook = amt_test_churn_hook;
+	/* GC no longer waits for st->dirty, so nothing but the commit
+	 * accounting keeps it off an endpoint the last commit still names.
+	 */
+	for (tick = 0; tick < 3; tick++) {
+		KUNIT_EXPECT_TRUE(test, amt_ofl_reconcile(amt));
+		KUNIT_EXPECT_TRUE(test, amt_test_fake_ep_held(&ckey));
+	}
+	KUNIT_EXPECT_FALSE(test, amt_test_fake_ep_held(&key));
+
+	amt_test_churn.on = false;
+	amt_fake.commit_hook = NULL;
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.grps), 1);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* endpoint_add is idempotent on an identical key, and amt adds an
+ * endpoint shared by several groups once.
+ */
+static void amt_offload_endpoint_idempotent_test(struct kunit *test)
+{
+	struct amt_offload_endpoint_key key = {};
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_offload_endpoint *h1 = NULL, *h2 = NULL;
+	struct amt_tunnel_list *t;
+	struct amt_dev *amt;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	key.family = AF_INET;
+	key.addr.ip4 = AMT_TEST_GW;
+	key.port = htons(4000);
+	KUNIT_EXPECT_EQ(test, amt_fake_endpoint_add(NULL, &key, &h1), 0);
+	KUNIT_EXPECT_EQ(test, amt_fake_endpoint_add(NULL, &key, &h2), 0);
+	KUNIT_EXPECT_PTR_EQ(test, h1, h2);
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtoi%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	t = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000));
+	amt_test_ofl_join(amt, t, 0, true);
+	amt_test_ofl_join(amt, t, 1, true);
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_EQ(test, amt_fake.ep_adds, 1);
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 2);
+	/* Leaving and rejoining one group keeps the endpoint programmed. */
+	amt_test_ofl_join(amt, t, 1, false);
+	amt_test_ofl_join(amt, t, 1, true);
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_EQ(test, amt_fake.ep_adds, 1);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.eps), 1);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* A failed group_commit disables the group and serves it in software;
+ * the endpoints it added stay programmed. A new binding retries it.
+ */
+static void amt_test_ofl_sync_net(void)
+{
+	amt_fake_log('S');
+	synchronize_net();
+}
+
+static void amt_offload_commit_fail_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *t[2];
+	struct amt_ofl_grp *og;
+	struct amt_dev *amt;
+	int i;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.commit_err = -EIO;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtoe%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 2; i++) {
+		t[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000 + i));
+		amt_test_ofl_join(amt, t[i], 0, true);
+	}
+	amt_test_ofl_drain(amt);
+	og = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, og);
+	KUNIT_EXPECT_FALSE(test, og->hw_active);
+	KUNIT_EXPECT_NULL(test, og->hw);
+	KUNIT_EXPECT_EQ(test, og->state, AMT_OFL_PARKED);
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "BG");
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.eps), 2);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.grps), 0);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_SW_REMAINDER), 1);
+
+	amt_fake.commit_err = 0;
+	rtnl_lock();
+	amt_offload_unregister(lower);
+	KUNIT_EXPECT_EQ(test, amt_offload_register(lower, &amt_fake_ops), 0);
+	rtnl_unlock();
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_TRUE(test, og->hw_active);
+	KUNIT_EXPECT_EQ(test, ((struct amt_fake_obj *)og->hw)->nr, 2);
+
+	/* A leave withdraws the committed group, then its recommit fails:
+	 * park still disables the provider object it holds, and waits out
+	 * ops->xmit first although hw_active already reads false. 'S' is
+	 * that wait: park, endpoint GC of the departed endpoint, which
+	 * unparks, then the second failed commit parks again. Without the
+	 * wait the log reads "GEG".
+	 */
+	amt_test_ofl_join(amt, t[1], 0, false);
+	KUNIT_EXPECT_FALSE(test, og->hw_active);
+	amt_fake.commit_err = -EIO;
+	memset(amt_fake.log, 0, sizeof(amt_fake.log));
+	amt_fake.n = 0;
+	kunit_activate_static_stub(test, amt_ofl_sync_net,
+				   amt_test_ofl_sync_net);
+	amt_test_ofl_drain(amt);
+	kunit_deactivate_static_stub(test, amt_ofl_sync_net);
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "SGESG");
+	KUNIT_EXPECT_NULL(test, og->hw);
+	KUNIT_EXPECT_EQ(test, og->state, AMT_OFL_PARKED);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.grps), 0);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* The publish gate: a member removed while the
+ * reconciler programs the group is still in what it commits, so that
+ * commit is not published and software serves the group; a member added
+ * meanwhile does not hold the publication back. A budget of one ends the
+ * tick right after the program the hook lands in.
+ */
+static struct {
+	struct amt_dev			*amt;
+	struct amt_tunnel_list		*tunnel;
+	int				grp;
+	bool				join;
+} amt_test_ofl_hook;
+
+static void amt_test_ofl_commit_hook(void)
+{
+	amt_test_ofl_join(amt_test_ofl_hook.amt, amt_test_ofl_hook.tunnel,
+			  amt_test_ofl_hook.grp, amt_test_ofl_hook.join);
+}
+
+static void amt_offload_publish_gate_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_offload_endpoint_key key;
+	struct amt_tunnel_list *t[3];
+	struct amt_offload_state *st;
+	struct amt_ofl_grp *og;
+	struct sk_buff *skb;
+	struct amt_dev *amt;
+	u32 budget;
+	int i;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.xmit_res = AMT_OFFLOAD_FALLBACK;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtop%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	st = amt->offload_st;
+	budget = st->budget;
+	for (i = 0; i < 3; i++)
+		t[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000 + i));
+	amt_test_ofl_hook.amt = amt;
+
+	/* A join inside the first commit: publish the committed subset. */
+	amt_test_ofl_join(amt, t[0], 0, true);
+	amt_test_ofl_hook.tunnel = t[1];
+	amt_test_ofl_hook.join = true;
+	amt_fake.commit_hook = amt_test_ofl_commit_hook;
+	st->budget = 1;
+	amt_ofl_reconcile(amt);
+	og = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, og);
+	KUNIT_EXPECT_NULL(test, amt_fake.commit_hook);
+	KUNIT_EXPECT_TRUE(test, og->hw_active);
+	KUNIT_EXPECT_EQ(test, og->state, AMT_OFL_DIRTY);
+	KUNIT_ASSERT_NOT_NULL(test, og->hw);
+	KUNIT_EXPECT_EQ(test, ((struct amt_fake_obj *)og->hw)->nr, 1);
+	st->budget = budget;
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_TRUE(test, og->hw_active);
+	KUNIT_EXPECT_EQ(test, ((struct amt_fake_obj *)og->hw)->nr, 2);
+
+	/* A leave inside a recommit: withhold it, software serves G. */
+	amt_test_ofl_join(amt, t[2], 0, true);
+	KUNIT_EXPECT_TRUE(test, og->hw_active);	/* joins do not withdraw */
+	amt_test_ofl_hook.tunnel = t[0];
+	amt_test_ofl_hook.join = false;
+	amt_fake.commit_hook = amt_test_ofl_commit_hook;
+	st->budget = 1;
+	amt_ofl_reconcile(amt);
+	KUNIT_EXPECT_NULL(test, amt_fake.commit_hook);
+	KUNIT_EXPECT_FALSE(test, og->hw_active);
+	/* The provider still replicates to t[0]: its endpoint stays. */
+	amt_ofl_ep_key(&key, amt, t[0]);
+	KUNIT_EXPECT_TRUE(test, amt_test_fake_ep_held(&key));
+	KUNIT_EXPECT_EQ(test, og->state, AMT_OFL_DIRTY);
+	skb = alloc_skb(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	i = amt_fake.xmits;
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 0));
+	KUNIT_EXPECT_EQ(test, amt_fake.xmits, i);
+	st->budget = budget;
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_TRUE(test, og->hw_active);
+	KUNIT_EXPECT_EQ(test, ((struct amt_fake_obj *)og->hw)->nr, 2);
+	kfree_skb(skb);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* Same-key rejoin: K empties and goes on the tick's gone list with its
+ * provider group still live; a join inside the next group's commit hashes
+ * a new K, which the same tick programs. That first use must wait for the
+ * old group's disable: the fake refuses a second live group per key, and
+ * without the flush the new K parks in software.
+ */
+static void amt_offload_rejoin_gone_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *t[2];
+	struct amt_ofl_grp *og;
+	struct amt_dev *amt;
+	int i;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtor%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 2; i++)
+		t[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000 + i));
+	amt_test_ofl_join(amt, t[0], 0, true);
+	amt_test_ofl_drain(amt);
+	og = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, og);
+	KUNIT_ASSERT_TRUE(test, og->hw_active);
+
+	/* K empties first, then G dirties; G's commit rejoins K. */
+	amt_test_ofl_join(amt, t[0], 0, false);
+	amt_test_ofl_join(amt, t[1], 1, true);
+	amt_test_ofl_hook.amt = amt;
+	amt_test_ofl_hook.tunnel = t[0];
+	amt_test_ofl_hook.grp = 0;
+	amt_test_ofl_hook.join = true;
+	amt_fake.commit_hook = amt_test_ofl_commit_hook;
+	/* 'S' is the mid-pass flush's wait for ops->xmit on the old K before
+	 * its disable; without it the log reads "G".
+	 */
+	memset(amt_fake.log, 0, sizeof(amt_fake.log));
+	amt_fake.n = 0;
+	kunit_activate_static_stub(test, amt_ofl_sync_net,
+				   amt_test_ofl_sync_net);
+	amt_ofl_reconcile(amt);
+	kunit_deactivate_static_stub(test, amt_ofl_sync_net);
+	KUNIT_EXPECT_STREQ(test, amt_fake.log, "SG");
+	KUNIT_EXPECT_NULL(test, amt_fake.commit_hook);
+	KUNIT_EXPECT_EQ(test, amt_fake.dup_grps, 0);
+	og = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, og);
+	KUNIT_EXPECT_TRUE(test, og->hw_active);
+	KUNIT_EXPECT_EQ(test, og->state, AMT_OFL_IDLE);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.grps), 2);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_SW_REMAINDER), 0);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* The mid-pass flush above is timed like any release op: a stalled
+ * group_disable of the old K resets the provider once, and the pass ends
+ * there rather than program the new K against a provider it just
+ * flushed. The next ticks replay it.
+ */
+static void amt_offload_rejoin_gone_stall_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *t[2];
+	struct amt_ofl_grp *og;
+	struct amt_dev *amt;
+	int i, updates;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.op_timeout_ms = 10;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtos%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 2; i++)
+		t[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000 + i));
+	amt_test_ofl_join(amt, t[0], 0, true);
+	amt_test_ofl_drain(amt);
+
+	amt_test_ofl_join(amt, t[0], 0, false);
+	amt_test_ofl_join(amt, t[1], 1, true);
+	amt_test_ofl_hook.amt = amt;
+	amt_test_ofl_hook.tunnel = t[0];
+	amt_test_ofl_hook.grp = 0;
+	amt_test_ofl_hook.join = true;
+	amt_fake.commit_hook = amt_test_ofl_commit_hook;
+	amt_fake.release_stall = true;
+	updates = amt_fake.updates;
+	amt_ofl_reconcile(amt);
+	amt_fake.release_stall = false;
+	KUNIT_EXPECT_NULL(test, amt_fake.commit_hook);
+	KUNIT_EXPECT_EQ(test, amt_fake.flushes, 1);
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt, AMT_OFFLOAD_CNT_RESET),
+			1);
+	/* G's update only: the new K was not programmed. */
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, updates + 1);
+	og = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, og);
+	KUNIT_EXPECT_NULL(test, og->hw);
+	KUNIT_EXPECT_FALSE(test, og->hw_active);
+
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_TRUE(test, og->hw_active);
+	KUNIT_EXPECT_EQ(test, amt_fake.dup_grps, 0);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* Exactly one actor per packet: CONSUMED gives the skb away, FALLBACK
+ * and BUSY return it untouched (BUSY counted); an uncommitted group and
+ * an unbound relay never reach the provider. A packet submitted after a
+ * commit carries the new generation.
+ */
+static void amt_offload_tx_ownership_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_tunnel_list *t[2];
+	struct amt_ofl_grp *og;
+	struct sk_buff *skb;
+	struct amt_dev *amt;
+	u64 gen;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt = amt_test_ofl_attach(test, "amtox%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	t[0] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000));
+	t[1] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4001));
+	amt_test_ofl_join(amt, t[0], 0, true);
+	amt_test_ofl_drain(amt);
+	skb = alloc_skb(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+
+	/* No provider: software, as with offload=software. */
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 0));
+
+	rtnl_lock();
+	KUNIT_EXPECT_EQ(test, amt_offload_register(lower, &amt_fake_ops), 0);
+	rtnl_unlock();
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 0));
+	KUNIT_EXPECT_EQ(test, amt_fake.xmits, 0);	/* not committed yet */
+	amt_test_ofl_drain(amt);
+	og = amt_test_ofl_grp(amt, 0);
+	KUNIT_ASSERT_NOT_NULL(test, og);
+	KUNIT_ASSERT_TRUE(test, og->hw_active);
+
+	amt_fake.xmit_res = AMT_OFFLOAD_FALLBACK;
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 0));
+	amt_fake.xmit_res = AMT_OFFLOAD_BUSY;
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 0));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_BUSY_FALLBACK), 1);
+	KUNIT_EXPECT_EQ(test, refcount_read(&skb->users), 1);
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 1));	/* no group */
+	KUNIT_EXPECT_EQ(test, amt_fake.xmits, 2);
+	KUNIT_EXPECT_EQ(test, amt_fake.xmit_gen, og->hw_gen);
+
+	/* Generation rule. */
+	gen = og->hw_gen;
+	amt_test_ofl_join(amt, t[1], 0, true);
+	amt_fake.xmit_res = AMT_OFFLOAD_FALLBACK;
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 0));
+	KUNIT_EXPECT_EQ(test, amt_fake.xmit_gen, gen);
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_GT(test, og->hw_gen, gen);
+	amt_fake.xmit_res = AMT_OFFLOAD_CONSUMED;
+	KUNIT_EXPECT_TRUE(test, amt_test_ofl_tx(amt, skb, 0));	/* freed */
+	KUNIT_EXPECT_EQ(test, amt_fake.xmit_gen, og->hw_gen);
+	KUNIT_EXPECT_EQ(test, amt_fake.xmits, 4);
+
+	/* Removing a member withdraws the group from hardware at once, not
+	 * at the next commit: the committed set still names the departed
+	 * endpoint.
+	 */
+	amt_test_ofl_join(amt, t[1], 0, false);
+	KUNIT_EXPECT_FALSE(test, og->hw_active);
+	skb = alloc_skb(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 0));
+	KUNIT_EXPECT_EQ(test, amt_fake.xmits, 4);
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_TRUE(test, og->hw_active);
+	KUNIT_EXPECT_EQ(test, ((struct amt_fake_obj *)og->hw)->nr, 1);
+	kfree_skb(skb);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* Admission: a teardown waiting on st->mutex holds RTNL, so once admission
+ * stops a programming pass makes no further endpoint_add, group_update,
+ * group_commit or endpoint_del, and ends the tick. A pass releasing
+ * everything after desync does not check admission and finishes that
+ * release. The fake clears b->admitting from inside one op. The four
+ * blocks below fail with any one of these five admission checks reverted
+ * (before endpoint_add, group_update and group_commit, at the top of the
+ * pass loop, in the endpoint GC); the pass loop's epoch check is
+ * amt_offload_reset_ends_pass_test's.
+ */
+static void amt_offload_admit_guard_test(struct kunit *test)
+{
+	struct amt_tunnel_list *t[3];
+	struct net_device *lower;
+	struct amt_dev *amt;
+	int i;
+
+	/* A two-endpoint group, admission lost in the first endpoint_add:
+	 * no second endpoint_add.
+	 */
+	lower = amt_test_lower_alloc(test);
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtga%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 2; i++)
+		amt_test_ofl_join(amt, amt_test_ofl_tunnel(test, AMT_TEST_GW,
+							   htons(4000 + i)),
+				  0, true);
+	amt_fake.drop_admit = 'A';
+	amt_ofl_reconcile(amt);
+	KUNIT_EXPECT_EQ(test, amt_fake.ep_adds, 1);
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 0);
+	amt_test_ofl_done(amt, lower);
+
+	/* Three one-endpoint groups, lost in the first endpoint_add: no
+	 * group_update, and the pass ends with the other two still queued.
+	 */
+	lower = amt_test_lower_alloc(test);
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtgb%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 3; i++)
+		amt_test_ofl_join(amt, amt_test_ofl_tunnel(test, AMT_TEST_GW,
+							   htons(4000 + i)),
+				  i, true);
+	amt_fake.drop_admit = 'A';
+	KUNIT_EXPECT_TRUE(test, amt_ofl_reconcile(amt));
+	KUNIT_EXPECT_EQ(test, amt_fake.ep_adds, 1);
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 0);
+	KUNIT_EXPECT_EQ(test, amt_fake.commits, 0);
+	for (i = 1; i < 3; i++) {
+		struct amt_ofl_grp *g = amt_test_ofl_grp(amt, i);
+
+		KUNIT_ASSERT_NOT_NULL(test, g);
+		KUNIT_EXPECT_EQ(test, g->state, AMT_OFL_DIRTY);
+	}
+	amt_test_ofl_done(amt, lower);
+
+	/* Lost in group_update: no group_commit. */
+	lower = amt_test_lower_alloc(test);
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtgc%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	amt_test_ofl_join(amt, amt_test_ofl_tunnel(test, AMT_TEST_GW,
+						   htons(4000)), 0, true);
+	amt_fake.drop_admit = 'U';
+	amt_ofl_reconcile(amt);
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 1);
+	KUNIT_EXPECT_EQ(test, amt_fake.commits, 0);
+	amt_test_ofl_done(amt, lower);
+
+	/* Two unused endpoints, lost in the first endpoint_del: the
+	 * endpoint GC deletes no second one.
+	 */
+	lower = amt_test_lower_alloc(test);
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtgd%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 2; i++) {
+		t[i] = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000 + i));
+		amt_test_ofl_join(amt, t[i], i, true);
+	}
+	amt_test_ofl_drain(amt);
+	KUNIT_ASSERT_EQ(test, amt_fake_live(amt_fake.eps), 2);
+	for (i = 0; i < 2; i++)
+		amt_test_ofl_join(amt, t[i], i, false);
+	amt_fake.drop_admit = 'E';
+	amt_ofl_reconcile(amt);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.eps), 1);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* A reset (an op overran op_timeout_ms) replays every group, so
+ * the pass ends at it instead of spending the rest of the budget against
+ * a provider that may be wedged.
+ */
+static void amt_offload_reset_ends_pass_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_dev *amt;
+	int i;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.op_timeout_ms = 10;
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtor%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	for (i = 0; i < 3; i++)
+		amt_test_ofl_join(amt, amt_test_ofl_tunnel(test, AMT_TEST_GW,
+							   htons(4000 + i)),
+				  i, true);
+	amt_fake.add_stall = true;
+	KUNIT_EXPECT_TRUE(test, amt_ofl_reconcile(amt));
+	KUNIT_EXPECT_EQ(test, amt_fake.flushes, 1);
+	KUNIT_EXPECT_EQ(test, amt_fake.ep_adds, 1);
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 0);
+
+	/* The next tick replays all three. */
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.grps), 3);
+	KUNIT_EXPECT_EQ(test, amt_fake_live(amt_fake.eps), 3);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* Hash seed: the offload tables are indexed with the device's hash_seed and
+ * sized from max_tunnels (x max_groups) at attach, so a gateway can
+ * neither precompute one chain nor fill a fixed-size table.
+ */
+static void amt_offload_hash_seed_test(struct kunit *test)
+{
+	struct amt_offload_endpoint_key ek;
+	struct amt_offload_group_key gk;
+	bool gmoved = false, emoved = false;
+	struct amt_offload_state *st;
+	struct hlist_head *g0, *e0;
+	struct net_device *lower;
+	struct amt_dev *amt;
+	u32 seed;
+
+	memset(&ek, 0, sizeof(ek));
+	ek.family = AF_INET;
+	ek.addr.ip4 = AMT_TEST_GW;
+	ek.port = htons(4000);
+	memset(&gk, 0, sizeof(gk));
+	gk.family = AF_INET;
+	gk.group.ip4 = AMT_TEST_GROUP;
+
+	/* Default caps: 128 tunnels x 32 groups. */
+	lower = amt_test_lower_alloc(test);
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtoh%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	st = amt->offload_st;
+	KUNIT_EXPECT_EQ(test, st->ep_bits, 7);
+	KUNIT_EXPECT_EQ(test, st->grp_bits, 12);
+	amt->hash_seed = 0;
+	g0 = amt_ofl_grp_bucket(st, &gk);
+	e0 = amt_ofl_ep_bucket(st, &ek);
+	for (seed = 1; seed < 64 && !(gmoved && emoved); seed++) {
+		amt->hash_seed = seed;
+		gmoved |= amt_ofl_grp_bucket(st, &gk) != g0;
+		emoved |= amt_ofl_ep_bucket(st, &ek) != e0;
+	}
+	KUNIT_EXPECT_TRUE_MSG(test, gmoved, "group bucket ignores hash_seed");
+	KUNIT_EXPECT_TRUE_MSG(test, emoved, "endpoint bucket ignores hash_seed");
+	amt_test_ofl_done(amt, lower);
+
+	/* max_tunnels set before attach sizes both tables. */
+	lower = amt_test_lower_alloc(test);
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_offload_relay(test, "amtoi%d", lower,
+				     AMT_OFFLOAD_MODE_AUTO);
+	amt->max_tunnels = 10000;
+	rtnl_lock();
+	KUNIT_EXPECT_EQ(test, amt_offload_attach(amt, NULL), 0);
+	rtnl_unlock();
+	KUNIT_ASSERT_NOT_NULL(test, amt->offload_st);
+	disable_work_sync(&amt->offload_st->work);
+	KUNIT_EXPECT_EQ(test, amt->offload_st->ep_bits, 14);
+	KUNIT_EXPECT_EQ(test, amt->offload_st->grp_bits, 16);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* The last member leaves while the reconciler allocates its arrays: the
+ * retry finds no member and must not free the arrays a second time. The
+ * allocation and free stubs keep a ledger of live arrays, so a repeated
+ * free fails the case in every configuration, not only under KASAN.
+ */
+static struct {
+	struct kunit			*test;
+	struct amt_dev			*amt;
+	struct amt_tunnel_list		*tunnel;
+	int				calls;
+	void				*live[4];
+	int				nr_live;
+} amt_test_ofl_race;
+
+static void *amt_test_ofl_alloc_leave(u32 n, size_t size)
+{
+	void *p;
+
+	if (!amt_test_ofl_race.calls++)
+		amt_test_ofl_join(amt_test_ofl_race.amt,
+				  amt_test_ofl_race.tunnel, 0, false);
+	p = kvmalloc_array(n, size, GFP_KERNEL);
+	if (!p)
+		return NULL;
+	if (amt_test_ofl_race.nr_live == ARRAY_SIZE(amt_test_ofl_race.live)) {
+		/* A later free of p would read as a double free. */
+		KUNIT_FAIL(amt_test_ofl_race.test, "live-array ledger full");
+		return p;
+	}
+	amt_test_ofl_race.live[amt_test_ofl_race.nr_live++] = p;
+	return p;
+}
+
+static void amt_test_ofl_free_once(void *p)
+{
+	int i;
+
+	if (!p)
+		return;
+	for (i = 0; i < amt_test_ofl_race.nr_live; i++) {
+		if (amt_test_ofl_race.live[i] == p) {
+			amt_test_ofl_race.live[i] =
+				amt_test_ofl_race.live[--amt_test_ofl_race.nr_live];
+			kvfree(p);
+			return;
+		}
+	}
+	/* Not live: a second free. Leak it rather than corrupt the heap. */
+	KUNIT_FAIL(amt_test_ofl_race.test, "array %p freed twice", p);
+}
+
+static void amt_offload_alloc_race_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_dev *amt;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_test_ofl_register(test, lower);
+	amt = amt_test_ofl_attach(test, "amtoa%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	memset(&amt_test_ofl_race, 0, sizeof(amt_test_ofl_race));
+	amt_test_ofl_race.test = test;
+	amt_test_ofl_race.amt = amt;
+	amt_test_ofl_race.tunnel = amt_test_ofl_tunnel(test, AMT_TEST_GW,
+						       htons(4000));
+	amt_test_ofl_join(amt, amt_test_ofl_race.tunnel, 0, true);
+
+	kunit_activate_static_stub(test, amt_ofl_alloc_array,
+				   amt_test_ofl_alloc_leave);
+	kunit_activate_static_stub(test, amt_ofl_free_array,
+				   amt_test_ofl_free_once);
+	amt_test_ofl_drain(amt);
+	kunit_deactivate_static_stub(test, amt_ofl_free_array);
+	kunit_deactivate_static_stub(test, amt_ofl_alloc_array);
+
+	/* One allocation round, then the retry read no member. */
+	KUNIT_EXPECT_EQ(test, amt_test_ofl_race.calls, 2);
+	KUNIT_EXPECT_EQ(test, amt_test_ofl_race.nr_live, 0);
+	KUNIT_EXPECT_NULL(test, amt_test_ofl_grp(amt, 0));
+	KUNIT_EXPECT_TRUE(test, amt_test_ofl_no_eps(amt));
+	KUNIT_EXPECT_EQ(test, amt_fake.updates, 0);
+	amt_test_ofl_done(amt, lower);
+}
+
+/* Ingress: the host drops a punted copy of a committed group and sends
+ * everything else to software. Only a required relay binds on ingress.
+ * A leave does not lift the drop: hardware keeps replicating to the
+ * committed set until the recommit, so software would send the remaining
+ * members every packet a second time.
+ */
+static void amt_offload_ingress_punt_test(struct kunit *test)
+{
+	struct net_device *lower = amt_test_lower_alloc(test);
+	struct amt_offload_endpoint_key key;
+	struct amt_tunnel_list *t, *t2;
+	struct amt_dev *amt, *aut;
+	struct sk_buff *skb;
+	u32 budget;
+
+	amt_fake_reset(AMT_OFFLOAD_FAMILY_V4);
+	amt_fake.paths = BIT(AMT_OFFLOAD_PATH_INGRESS);
+	amt_test_ofl_register(test, lower);
+	aut = amt_test_ofl_attach(test, "amtoa%d", lower,
+				  AMT_OFFLOAD_MODE_AUTO);
+	KUNIT_EXPECT_NULL(test, rcu_access_pointer(aut->offload));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(aut,
+			AMT_OFFLOAD_CNT_PATH_UNSUPPORTED), 1);
+
+	amt = amt_test_ofl_attach(test, "amtog%d", lower,
+				  AMT_OFFLOAD_MODE_REQUIRED);
+	KUNIT_ASSERT_NOT_NULL(test, rcu_access_pointer(amt->offload));
+	t = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4000));
+	t2 = amt_test_ofl_tunnel(test, AMT_TEST_GW, htons(4001));
+	amt_test_ofl_join(amt, t, 0, true);
+	amt_test_ofl_join(amt, t2, 0, true);
+	amt_test_ofl_join(amt, t, 2, true);
+	amt_test_ofl_drain(amt);
+	amt_test_ofl_join(amt, t, 3, true);	/* not committed */
+
+	skb = alloc_skb(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 1));
+	KUNIT_EXPECT_FALSE(test, amt_test_ofl_tx(amt, skb, 3));
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_PUNT_DROPPED), 0);
+	KUNIT_EXPECT_TRUE(test, amt_test_ofl_tx(amt, skb, 0));	/* dropped */
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_PUNT_DROPPED), 1);
+
+	amt_test_ofl_join(amt, t2, 0, false);
+	skb = alloc_skb(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	KUNIT_EXPECT_TRUE(test, amt_test_ofl_tx(amt, skb, 0));	/* dropped */
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_PUNT_DROPPED), 2);
+
+	/* A leave inside a group's first commit: hardware replicates to the
+	 * committed set anyway, so the pass still publishes it and the
+	 * punted copy is dropped. Withholding it would send the remaining
+	 * member every packet twice until the next pass.
+	 */
+	amt_test_ofl_drain(amt);
+	amt_test_ofl_join(amt, t, 4, true);
+	amt_test_ofl_join(amt, t2, 4, true);
+	amt_test_ofl_hook.amt = amt;
+	amt_test_ofl_hook.tunnel = t2;
+	amt_test_ofl_hook.grp = 4;
+	amt_test_ofl_hook.join = false;
+	amt_fake.commit_hook = amt_test_ofl_commit_hook;
+	budget = amt->offload_st->budget;
+	amt->offload_st->budget = 1;
+	amt_ofl_reconcile(amt);
+	amt->offload_st->budget = budget;
+	amt_test_ofl_hook.grp = 0;
+	KUNIT_EXPECT_NULL(test, amt_fake.commit_hook);
+	amt_ofl_ep_key(&key, amt, t2);
+	KUNIT_EXPECT_TRUE(test, amt_test_fake_ep_held(&key));
+	skb = alloc_skb(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	KUNIT_EXPECT_TRUE(test, amt_test_ofl_tx(amt, skb, 4));	/* dropped */
+	KUNIT_EXPECT_EQ(test, amt_test_offload_cnt(amt,
+			AMT_OFFLOAD_CNT_PUNT_DROPPED), 3);
+	amt_test_ofl_drain(amt);
+	KUNIT_EXPECT_EQ(test, amt_fake.xmits, 0);
+	amt_test_offload_free(aut);
+	amt_test_ofl_done(amt, lower);
+}
+
 static struct kunit_case amt_test_cases[] = {
 	KUNIT_CASE(amt_lifecycle_test),
 	KUNIT_CASE(amt_upstream_refresh_idempotent_test),
 	KUNIT_CASE(amt_ex_transition_test),
+	KUNIT_CASE(amt_offload_register_when_bound_test),
+	KUNIT_CASE(amt_offload_family_unsupported_test),
+	KUNIT_CASE(amt_offload_unregister_mid_fanout_test),
+	KUNIT_CASE(amt_offload_provider_unregister_order_test),
+	KUNIT_CASE(amt_offload_mode_validate_test),
+	KUNIT_CASE(amt_offload_required_refused_test),
+	KUNIT_CASE(amt_offload_member_gnode_test),
+	KUNIT_CASE(amt_offload_budget_coalesce_test),
+	KUNIT_CASE(amt_offload_enospc_hysteresis_test),
+	KUNIT_CASE(amt_offload_timeout_reset_test),
+	KUNIT_CASE(amt_offload_reset_after_empty_test),
+	KUNIT_CASE(amt_offload_teardown_release_stall_test),
+	KUNIT_CASE(amt_offload_teardown_ep_stall_test),
+	KUNIT_CASE(amt_offload_reconcile_release_stall_test),
+	KUNIT_CASE(amt_offload_gc_churn_test),
+	KUNIT_CASE(amt_offload_endpoint_idempotent_test),
+	KUNIT_CASE(amt_offload_commit_fail_test),
+	KUNIT_CASE(amt_offload_publish_gate_test),
+	KUNIT_CASE(amt_offload_rejoin_gone_test),
+	KUNIT_CASE(amt_offload_rejoin_gone_stall_test),
+	KUNIT_CASE(amt_offload_tx_ownership_test),
+	KUNIT_CASE(amt_offload_alloc_race_test),
+	KUNIT_CASE(amt_offload_admit_guard_test),
+	KUNIT_CASE(amt_offload_reset_ends_pass_test),
+	KUNIT_CASE(amt_offload_hash_seed_test),
+	KUNIT_CASE(amt_offload_ingress_punt_test),
 	{}
 };
 
-- 
2.43.0


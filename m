Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9903F103E199
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 15:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7092740BD5;
	Wed, 18 Mar 2026 15:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 204uKNHaFpyA; Wed, 18 Mar 2026 15:03:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A436B40BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773846212;
	bh=LwI56IvSstpXQXaX8+DYC8cYl7ak5TMhpM2nnpgQBwA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=buk3kHm1finYnPmz8FZZvhsReyN39HuKhyIZH1KWHxmdQsDplW/J5uGnALltzjNoa
	 5NigjwL+WAQ8ZgfdC1OSkHV3KS+sDihIUbuuRyyrvhWfxrT0Wj+4GZW79CevY+kxze
	 wRYueM80GoV0hTUcgRW+HlxDucbPN1xdC+DFacG7s3q932RaYdXslY3qOgYUEuml+Y
	 wU2tNxat9T96BzmQKh3K01k80OzJ8qEhgv4X/U8has97/tDvcSsforHBypqxdYS+Xo
	 c6SN+mzFJoftWcdDwGEW1BjWlffWHE6SVR5Sv8CR9pBlDVuY2q+Azmj4rmr8hees76
	 6O6FT1LivlwoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A436B40BCC;
	Wed, 18 Mar 2026 15:03:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46BCB1AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CC9860AA1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xH4GNjsvTWDT for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 15:03:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.50;
 helo=mail-dl1-f50.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 282C060A94
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 282C060A94
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 282C060A94
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:30 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-127380532eeso192901c88.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 08:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773846209; x=1774451009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LwI56IvSstpXQXaX8+DYC8cYl7ak5TMhpM2nnpgQBwA=;
 b=rRn/12og0MlzC0vFlcoxu6JL5ckNH3+YzGLDNOXPRDuK4nQHEsvZQ3wShoelc39qmu
 vyIOp817YLsLOmmu0NObuNC/DVchZb3i/qjxYXvL6xfPvJ7dkdnu6iv482Ntvdt4Ygi0
 Fx6UOXySo8TqodcPQg+xKULbbdf+3mYMdnpMKupSbL5SE51CaTJhrP4+thTlxlVnYwVb
 D5FcMFJOntR03FiDU87ypMbjcUFd0CFNG1AYpuCple/foXM20LaSr3id2DSZpVL5WuXW
 mtf3xPxem5ay1eDVg27baJUUFuUDLO4oqUg37sSY08SI7EjG5hSUxaC4HNuHQohjLXt8
 4zjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD389jJ2NX6cLgl+TdK6e8HNcABzCcGajEjkQFBvkCqnAqwGF48Jz/bJBQvOKkVgEbKeqcXw/eUmMgZnA4JXc=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxvTVqEkcaLd1MDSoP/YcwttCfvCpcgc2/2W8HZpkN1A/j9sQ40
 fgZPq0g7sHHoCjq853fJ+AV9coec5EvFgBmK68QGqowe+atx5nM333s=
X-Gm-Gg: ATEYQzzNymIppwXEAZ+6v6FQA4v1M6J6YiM+8da70XxPVz4uiXHzz6ZVd16q5KsUeaq
 L7Uae7K6i/P2l4QIGVxFs44CbP5YDtx2AH7uqdWkNrZ7HnN9hunN/NqbIxAvJnOsBOE1LkXOS8N
 einZ7pRM8zeQ/chnu9kdvy1BWM+7skx/kTZDItMzThXpJyk197bcArtuvSgVgGlY7+biCWyJH86
 j+l7z4ETH38XkrUEWOUaVmJGGyZtq5SFwcbXuEbujinNs+EKZajP8I4kBFxk4yRfisiY2OGl1XR
 uL7MVuulKNXYmzHLPe9nPnQvML9zFFNUHZWFPySWfYY6qOV1YhLDOApwPRHj0/pLPE0eP0LdGl+
 OQMqiBYrY8PdQf0QCwCt/PiQ2hOY6/gqzO6/fTQ+K/qGwf5U8qekvOG4MZ496vr3VsRUj/7urBO
 1jSRZM2fMQFHPDN07dUEFV3wossOKAkNjBv7xHyp2wjgfYELGS3Ax62pt86rO+roM0j8sVK9j2B
 hLXosLRYO0iOjvPQA==
X-Received: by 2002:a05:7022:43aa:b0:11b:c1ab:bdd4 with SMTP id
 a92af1059eb24-129a70eab62mr1700585c88.38.1773846208379; 
 Wed, 18 Mar 2026 08:03:28 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-129a7256263sm3541023c88.4.2026.03.18.08.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:03:27 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com, johannes@sipsolutions.net,
 sd@queasysnail.net, jianbol@nvidia.com, dtatulea@nvidia.com,
 sdf@fomichev.me, mohsin.bashr@gmail.com, jacob.e.keller@intel.com,
 willemb@google.com, skhawaja@google.com, bestswngs@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
Date: Wed, 18 Mar 2026 08:03:05 -0700
Message-ID: <20260318150305.123900-14-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v2 13/13] selftests: net: add
 team_bridge_macvlan rx_mode test
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add a test that exercises the ndo_change_rx_flags path through a
macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
under addr_list_lock which flips promiscuity on the lower device.
With the new work queue approach, this must not deadlock.

Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/config       |  1 +
 tools/testing/selftests/net/rtnetlink.sh | 44 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 2a390cae41bf..94d722770420 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -101,6 +101,7 @@ CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_TEAM=y
 CONFIG_NET_VRF=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_OVS=y
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 5a5ff88321d5..c499953d4885 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -23,6 +23,7 @@ ALL_TESTS="
 	kci_test_encap
 	kci_test_macsec
 	kci_test_macsec_vlan
+	kci_test_team_bridge_macvlan
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -636,6 +637,49 @@ kci_test_macsec_vlan()
 	end_test "PASS: macsec_vlan"
 }
 
+# Test ndo_change_rx_flags call from dev_uc_add under addr_list_lock spinlock.
+# When we are flipping the promisc, make sure it runs on the work queue.
+#
+# https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
+# With (more conventional) macvlan instead of macsec.
+# macvlan -> bridge -> team -> dummy
+kci_test_team_bridge_macvlan()
+{
+	local vlan="test_macv1"
+	local bridge="test_br1"
+	local team="test_team1"
+	local dummy="test_dummy1"
+	local ret=0
+
+	run_cmd ip link add $team type team
+	if [ $ret -ne 0 ]; then
+		end_test "SKIP: team_bridge_macvlan: can't add team interface"
+		return $ksft_skip
+	fi
+
+	run_cmd ip link add $dummy type dummy
+	run_cmd ip link set $dummy master $team
+	run_cmd ip link set $team up
+	run_cmd ip link add $bridge type bridge vlan_filtering 1
+	run_cmd ip link set $bridge up
+	run_cmd ip link set $team master $bridge
+	run_cmd ip link add link $bridge name $vlan \
+		address 00:aa:bb:cc:dd:ee type macvlan mode bridge
+	run_cmd ip link set $vlan up
+
+	run_cmd ip link del $vlan
+	run_cmd ip link del $bridge
+	run_cmd ip link del $team
+	run_cmd ip link del $dummy
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: team_bridge_macvlan"
+		return 1
+	fi
+
+	end_test "PASS: team_bridge_macvlan"
+}
+
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
-- 
2.53.0


Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC65D1093168
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 01:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81B8541BBF;
	Fri, 20 Mar 2026 01:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tnixp7FIsvIL; Fri, 20 Mar 2026 01:25:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD76D41BBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773969922;
	bh=LwI56IvSstpXQXaX8+DYC8cYl7ak5TMhpM2nnpgQBwA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S0nFTW9Z1GG+4RRWxLaWFsO6f+Ixng2tlzRO1j7IQ+fJCoqxVxJvGVFU5EqgKzGBb
	 zOOh9gXgT83/oHvsNvhUkzTfAsRgc5dehSF1Syv5DvpLHeny6Rdm+PJQdRDv3TU9rw
	 Ypkq5W7oH2LBM5HuR4Jqhv5SSyV6AfaCWppSEk/15AYP1u5WdXvAmNTHU/fCZjGRMv
	 zJGgSujLtx75+nNqOpN2jStS0+fE+3bG/MTLRwu5j9jb0/u0ULOWRzd6g8Pei4N+G9
	 aBTl7VwPWmoVhS8KIQV2LARAA5jZ8mxsLBuOt8Y3VdrDIiljl/BEcG347cnAvFvZNu
	 rMLoL/eF0pfEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD76D41BBC;
	Fri, 20 Mar 2026 01:25:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2638F265
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1823041BBC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VecT4PnbSzKV for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 01:25:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.171;
 helo=mail-dy1-f171.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1F83341BAE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F83341BAE
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F83341BAE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:20 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2c0ea57fea7so1407683eec.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 18:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969919; x=1774574719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LwI56IvSstpXQXaX8+DYC8cYl7ak5TMhpM2nnpgQBwA=;
 b=hGxFeTkrhU3CYPAilBFTXT1KtM1lIDUGQNS8HRuDHUQg++xgIzof0c7cQyRmq4arJI
 jodYXdp32fQOSh1IVtnVNbXoIgKh+fiTR0yPB7xyStEZ8DoOWnLTy0pYVuDd6ed2pp8c
 9/O7nK9MnGl5ELiMpm+4CGVvCtZ9l52kUaAErmZvNsTaQ9iFGBI0Ey0eoS0RQm9cU/jP
 T7znOXmW/iSUWTErkzvifCug6igFE5gxgQjhnR2x8eEU5hsQ6ku49nx90+wc4wv4OZdr
 sMKQJp1b0dv181TP1d7zz4BeL6zDLhy3Gbz+2snkizyTbJnLDncxbMO4N/UBOndzQYYj
 aNzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX51NXvbSnjoCPW5ZCcb3DpYFt/5pAxVhBofj6vOuDvbftmerUpHq9BcBZcor5WeWP6smirtBrfNCPPhpk7ok4=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxL6QXIoU1tlO9yZZlDmvzU56DRyYjKFXjnKDGNgEw5MyQVNa66
 qHeDhGdUVg+CKKwRKwOZb/yT/QAnmQvp60tdwVO3mTlQFRK3Ps7GKKk=
X-Gm-Gg: ATEYQzzEXljAoymQK07zCQ0+KCPDpQwfPOl+nl9PN0Ges3yDtj34DvCjTGD4I5ku8MI
 P0DzKEqXUxW2Mf49g7gAwGdRnD3Te/RW/es546tPYAz7GAXg/m//6mHXET2gVBjMzXaYzU8MBTQ
 hLfe4kNgiCKwQb/vfssHmGvLeAhg/HUode9+mXKII3xzqhkNc5nfsRyXQB4BUEINmRhH0UpbdUI
 BFoleBfJMTK+v+bAW6WIF/YMWx6QFTfXE5CsOztIoNarW/SQoIT0B4659SklCPoW3t2qrbeNJjt
 vPlGSOUZxTkuGq590pfvq0+8/LbQBJYnpRQWiMlOXFjdFYPdqBRv9divSBC4f1zWR8ckQ9/v6Je
 rSz+1KpRA70t+w6teZ20bK5Neo+xELGkOomQSvdtrezIZA/MYIj6no7Oxh5jT3f9HgSvqcXbBan
 e/dyRq1RfbivN5yXa2OBXQ+3kUCDANuhT3u9zVNWA6fdoQEHV5kWlBkGDw7U3s/2pkcnDGQ1N3I
 IGDexP9MYrFjksyZg==
X-Received: by 2002:a05:7301:4198:b0:2c0:c415:cfd0 with SMTP id
 5a478bee46e88-2c109666ba0mr851744eec.15.1773969919058; 
 Thu, 19 Mar 2026 18:25:19 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29d28csm1378065eec.19.2026.03.19.18.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:25:18 -0700 (PDT)
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
 aleksandr.loktionov@intel.com, kees@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Date: Thu, 19 Mar 2026 18:25:01 -0700
Message-ID: <20260320012501.2033548-14-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v3 13/13] selftests: net: add
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


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425C606D80E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LXNOiq7Q;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=aO3NdL2h
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44C8F40774;
	Mon,  9 Nov 2026 14:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aO5_2n0UeEKu; Mon,  9 Nov 2026 14:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A410740781
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794235444;
	b=bh1Lw/mqf7RWGBREg28CYZY5cjwgckUst/GphB5tJ5JH2s1A0Fn03kDNUWdcNPSlvug/
	 kWWpKpIsAXEd2dpF9Dj4dXYti1hCafbTzXD4jTvXBPG3/U4EcTyAXufYInO2zCUvDHd3K
	 tu5kMNXdj4E3liyoB3P/kQNxSMVZadXniweiywHfNPmg54XzBsWLRndVw54suXocfFIDV
	 eM0dQEEprHqR7ksNIVRe6bj2Esjcb2ANUyG5JcznZ3OwBD/s4zbJzVjoroJveBxu0P37c
	 gFqBXLgcW98WC8jNfp4+NiCrAuRlgxaLxwdvdRwAM/Hf5bcJSY00cCtZ1Y0GXWQ6TAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794235444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Debian-User:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jW1Nt5uF3ROn1NR5XwafSjooEaI358J11WgWbqvS25A=;
	b=T6cUPgP3FhaeNFLWgG4gb67U6+gTFZ0VeEG7tAPWp+6i9i2kU6rMkfebp43s5ErMpIaq
	 7Uhcj6QVKblHwGNYDlgfh+hl4p49Ewjl6TRpYJkEtu1lCobUxF7lSQsghi5BYyR/+MWGH
	 bDTbhQIJEursjS6Le6V4hDFv58lL9ApU8f+PHLlWh+GizpkYYJaSVoZDFthbCuQGA3ThN
	 kGCgJ14iaY2gOn29HOXz2REB0+RxMyYmTOgrfygckNeduBeqN74eo/1FPjGonDU/Wl8/G
	 6Re6mhK+LVS8m8gQWY9E3STAw4VrIuAr0JKbeqMcZUb7Mg3RuYQNUR+5JtXOX+6oZlg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794235444;
	bh=jW1Nt5uF3ROn1NR5XwafSjooEaI358J11WgWbqvS25A=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LXNOiq7QuBgww+7/zD3OXerZWX7PXD0M/s8HOuEm+nNdFxqnn2F1+MPyv1DOa9EWM
	 cRPJBbQeuV3m82folo/gpcI/OuXdawbYqLjk7Ael2glRkhBhAigu+hzQSjSbdVO0nc
	 DcGF9K2s/vTSuhx8I0TrS2CzJApA1jGeaWFdwgBvm6P5yCf2FqEiNtxbm4ei57osJz
	 Hs8SFxIMOASn6XDijEh+Mw3INVg3WoVczJEs8cRRbvH34jbR8VmiTVtNrsA2I5LRrU
	 zgEd30s6K1yuQmW0fLQ89nSuiheuoacG/xcI6Qzzu7yywDw7ktn/sRJriL68rFvHhe
	 kOwvTI1QdnbHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A410740781;
	Mon,  9 Nov 2026 14:44:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 66573111
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 14:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C48E607B3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 14:44:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJXNz0NA-6w8 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 14:44:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B90A60741
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256
 header.s=smtpauto.stravinsky header.b=aO3NdL2h
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B90A60741
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
 Reply-To:Content-ID:Content-Description:In-Reply-To:References;
 bh=jW1Nt5uF3ROn1NR5XwafSjooEaI358J11WgWbqvS25A=; b=aO3NdL2hCYsgw2TrTJPTlfmL+o
 DXpl/VHMC9L+Vt3y/pzFXXyZnQ+A9O+dzWjhl51PHRGO/zCMmO+ytndiiZIZStaOKVY3i137FCjkZ
 /oHG9UdyvJXSYpsf2Y/Mu39M+De6p2emscJvg+D5OLVmyoLZK7bdIWJHDJ7i3C69z0woscJFOHR0l
 1tqMex+7VX+kmJ32LpB299OrT0OzWa5cAfUkzNQiDXMo94/MbypmB2rpw8YAHwvD+vmNx02Imdfdw
 n4G2N0xSIjAZb9oRw9BUYfs7lAQLZe027uNCb30uODuyq8nZrGAzNC4KzI73tyKzE7h90tdkdWTA2
 0uLZUywQ==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <leitao@debian.org>) id 1xQQb6-00Bh4L-17;
 Mon, 09 Nov 2026 14:43:48 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Nov 2026 06:43:27 -0800
Subject: [PATCH net] idpf: reset mb_wait_count once the mailbox is up
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-idpf-mb-wait-count-v1-1-c6584754df78@debian.org>
X-B4-Tracking: v=1; b=H4sIAA7c8WoC/x3MTQ5AMBBA4avIrE1iGgRXEYuWKbNQ0tZPIu6us
 fwW7z0Q2AsH6LIHPJ8SZHMJlGcwLtrNjDIlgypUTVS0ibvF1eClJeK4HS4iNSVbU5KpVAUp3D1
 buf9pD44jDO/7AUP3FL1pAAAA
X-Change-ID: 20261109-idpf-mb-wait-count-184efb41b525
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, Alan Brady <alan.brady@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: Phani Burra <phani.r.burra@intel.com>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=leitao@debian.org;
 h=from:subject:message-id; bh=IUwnzebJt01HkE/iBmJlwXOxBT1vqXQ85djowTpnL6I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8dwgyTgueYnU9IIX9CLhMhQ0sEZMxd0lo20vV
 CuQ+qYDvDCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavHcIAAKCRA1o5Of/Hh3
 bf+hD/9/Eo1FESVGmVPGH3ztKPwV2xqeW+rVwoN5NfJFa4Ux78O0ymajfttjO1iksZE+VOLXzhg
 uBjp6FulhPwDmra0llVlSHhmR4q+kqqX0q3Ymk1YBN1d6tdKwwc4puCVCc1oT5dOD5NZXKBW5lE
 nzdR41o+b1w/F1TY7izmr5kQpfAHXuVmmxcZFCYEb7phgcXVcTvuppXJjevOZ6BQ+/x++B02NLs
 x64BC44X80zra6sL0yp2YmszO0Snoz88TzNxDPYPDveuUcuCV1x2eolkosmJu8DDSz/2g1XG5u+
 HuTLCmCg8Bi4yswnmJH/CtOs7V88Ua5ZQ77xEvp/zl3szlmtNwvRYLmDAQWgtCkFVFSvkvkQdOA
 HVNAysVrcHMgziMOJP4pM/tBX4/GeSTkA7RH/806abi+cnZcOcWv6MhmhPHcOcQRunX8hRejTPV
 XQ9qEQUUPjAg6Jo9ARrVYxPrV1mIMmz+SadI5eiqQm9mji3AfKnnFacvhEHePYJ65fRMyS0vCvg
 gIAKldDqgANu+Se6Tx5EO5u9yIfOWTIkPukMqGWYcVZ/2tYmbRuK/oWZJR3FYDFthHQ97+bJAXz
 hvykhDvMH1FYScHGBwOU2Ko+YJ1sABlpd+Zov0nzcX+Y0FjPu8q655RWmL9Rvyp2SHECA0ERqGf
 kdZ+y3Z0COqImDQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

idpf_vc_core_init() retries a failed virtchnl version and capabilities
handshake up to IDPF_MB_MAX_ERR times before it gives up on the device.
Each failure increments adapter->mb_wait_count, but nothing ever clears
it, so the limit is shared by every initialization in the lifetime of
the adapter, including the one done by each reset.

A device that fails the first handshake after a reset, and then
recovers on the retry, leaves one count behind per reset. Once 20 have
accumulated, the next failure is final, and the device stays down until
the driver is reloaded. This is seen in Meta's fleet on hosts with
recurring Tx timeouts:

  [ 2176.496801] idpf 0016:01:00.0 eth1: Detected Tx timeout: Count 21, Queue 11
  [ 2176.508763] idpf 0016:01:00.0: Device HW Reset initiated
  [ 2237.412541] idpf 0016:01:00.0: Transaction timed-out (op:1 cookie:9800 vc_op:1 salt:98 timeout:60000ms)
  [ 2237.412578] idpf 0016:01:00.0: Failed to establish mailbox communications with hardware

Clear mb_wait_count once the handshake succeeds, so the limit applies
to consecutive failures only.

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 928de868fa624e..7c11c877acd0ba 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3118,6 +3118,9 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		msleep(task_delay);
 	}
 
+	/* The mailbox is up, give the next reset a fresh retry budget */
+	adapter->mb_wait_count = 0;
+
 	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_LAN_MEMORY_REGIONS)) {
 		err = idpf_cfg_lan_memory_regions(adapter);
 		if (err) {

---
base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
change-id: 20261109-idpf-mb-wait-count-184efb41b525

Best regards,
--  
Breno Leitao <leitao@debian.org>


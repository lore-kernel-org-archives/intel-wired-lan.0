Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB946606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bwbSVLRR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LoK/Too7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B01AC60600;
	Mon,  2 Nov 2026 03:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNYW3EvVRaRi; Mon,  2 Nov 2026 03:27:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB7D360627
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793590074;
	b=M5Aj4F87FM3g/QTGSDemDL9nGNTXQLmoSa730xsM2K6A+qlITeTsoSD2UR5U2CJzcGfQ
	 Js7srLCWHIeBmoTLZNmmE0qHdC0ZrL0r3AoVVIu/qUTTZFaRFORX6vK8TCIL3mqrO9J9P
	 UzM+HjSGDsL+Dk9btDdq6mHz4IRtcEhIjIjinw3I1IeqniMq0d51qs+T49jjZNrQn5ORj
	 kG1U9N3336JKT5+ybX5QZeiT0PjXC6cot5AolNUPlE1DhFcCTYBTRLw9R72heDvbEUpZg
	 liqR1RTmIQD2jNJxbCcayWOcQr8R0AOnWD9ebJryVJklmK5phq2G7x5AQat0OWGhKcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793590074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8Llr+o6Ts4ECL1b5wY6waQNbg14/hj40EOsrJUW7ozE=;
	b=r2gNlykq/JqfqmxC1b0oD7NKzofoRyZqe9RO5xsn1bNIJk1O0dkkn4notUaaErTl+UMv
	 H8C11BIgO93b11LL7LeAEyIY1T8Q8uyErG25w5jpiDQXUxK8S5cZcwcxmftedt/FVDAGD
	 E6lVlbJh/kczdCKrT7IwelQi9S9RnH5toMizNiN1UPhbaWwmyNBrG/5C5p1EMhObh1oJK
	 Fi4lih4vMvQpV+WR0ayUXjZxM6E33JUUfTW1nxdTwUuXU6svFqI0uvVCfB9P64ZgXQxKN
	 C+63T/nCN/eCxd/pzh6FzE1KHnZlApBqUjIRm9GXtDu/D5TazHXXKTYQZp4RBUvFOvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793590074;
	bh=8Llr+o6Ts4ECL1b5wY6waQNbg14/hj40EOsrJUW7ozE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bwbSVLRR30AUHhhMCWWalx0cLc3B0B11OyGLmdpnqHl+PyDCvRCxH/M3b1b7zgLKI
	 Qpa1lcWDI9FjfLwA2KhMiObI18gscvnzkWlyeoHnLAhvXKgzrG22XYZ7g6wNR87sDT
	 R9gQxvzdm6rzGvTxqfobWBA5Ts32ZhsP28SOjPQJjnQXwKmHeIvrzFFmmNF0oxfKbT
	 0l9L4ER1lqpW6EL0PmCTTp6HiHk13sKC80bRSUWXkHm2Vw+sAS1Na25H8oUzDVPhAe
	 aFc+qC5MMsUoLX8N1FwzILwhIL/Lr2fe/1WlSVGjosysFwBQZKGGo/wEIJmDuTtn2w
	 muJ1J4fHnbHrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB7D360627;
	Mon,  2 Nov 2026 03:27:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D19C362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 03:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42D8580D87
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 03:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzS5WVA3R9ke for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 03:27:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E3C880D85
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793590072;
 b=nSQc4x5uVlk2oguOWUROhqWuZWRGJTcSLbxGtNANt5E3uBTD/uxNBzv1Gv0wpPERFSl2
 13aV705bOUdQiBnj9Pz5A4gJChvTCG5RRfWVbiuqZKgAO84lZBBYZkqgcHMlmvwwqDtM2
 51zv15B2pYzcw1qeHfwQwvlWHznu2ZQKMg/3VLExxRnLGtlUt6TCQnCp3aneAv6/M2R38
 zjqTovLeOl34K+TPsKb9WFYO9yVejSNrr9L00WhkqZ26/UtASkRtDoTap58SjJcChm98m
 b+KwmorK5MznX7PrIBWJScRAjdSfeXDtXGSr5lxArDTiBhEwO5w2f8Go1gCtrEN9XDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793590072;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=8Llr+o6Ts4ECL1b5wY6waQNbg14/hj40EOsrJUW7ozE=;
 b=mlZDnzQWiOITOzziq8Rv1SNiGybxvrX9Hqu5/Q0HugzUzEg9JRbaaba7xWkvvbgmBEQ+
 YWr8mIdGyZDF1uqvhVy4tMXcDzSZYbbn2zmY8G37y9++cn86/P4o4DaVIdZvBZwqw6+C8
 qZMCjOMZKpuYe2G3k+/ygyDc+BoLGeZTgW/4TJ6Kv7O8tM38xR0IqZIeESSE+C6/2JOPq
 vk5Da+I6KmwuvFnxUgSSfTMckD+VZrKK131xSR5UNRAqdK2mQQF4Hg/H5lc1fPUXXLUoJ
 oFjHQK0TfgveYOznYtmCQt2wAsBpg/Ik6tPakFaZf8dzX2Z7rkYwBF2u0jXimjXtoWg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="LoK/Too7"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=LoK/Too7
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E3C880D85
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 03:27:51 +0000 (UTC)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-91c79f306e9so30407966d6.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 01 Nov 2026 19:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793590070; x=1794194870; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8Llr+o6Ts4ECL1b5wY6waQNbg14/hj40EOsrJUW7ozE=;
 b=LoK/Too7ydY3Fb+v3WacbhZRY9bI7aVDg/BvCN9XYBZGCCAAFFwijxhqZ/SH8wCReM
 k24oc9BVnGBXJyhgH7q27u7KZMY7Qa8cnVfmUyt3xeM5fah7BMGlnfXm55Xpwox291bg
 2ua3gZkMrWEN5LKZdl2XAS6uXbmBjtEN02Bz3wcogZSnr/v65OEyyUmsDTmQGcyNkiN7
 3jN1gutTFbD+0+ixm/Me/mGIx2qoErRLovjbM503F4F4NUsyybSwwM6AWivHGnOTleuu
 Cy7Y9V19ahtoo06Yo4fG92KqX1r0Zo92mXw+iL6Y3GnTJopyLfTh+y4P8nGPmqgiVKmy
 nlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793590070; x=1794194870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Llr+o6Ts4ECL1b5wY6waQNbg14/hj40EOsrJUW7ozE=;
 b=LE6F/3s5Fg89fAPBWgbPmzij06AmvF5wMOskbgVnD35N0Qj0XKh3nfUPkQ0HaeQTMX
 /0qqYpks2jmBEH2Kx0u5A683IpIVaKeqP/rDZ065eACKedx5Ot1zLe6+PjFRBedgI7t4
 tgiPrmDdMQXyTDxSBofCeEM/02atOt/s1kWg06e4MehSD7vlHfNaoJP36H4dy0YpFlZw
 GQG23BAT1z+zX8DKKYX7zf4PiCkzWvv3QeGIeI3E4hR4J7BhDR/EZqWtMA0R1paF/p9r
 n+rDMEl+THCg/t1yOs8CxaKZH1t+2IJ08OYS2YvaB13XMN9DDGN1isJpKMQbjtGa64wa
 E4Qw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKY5Lc8IdlLwMYKq3tbO4tzRj0VvDhNPxmuMYxrmkvZDuw4qr8+rG6RA5m2lvTUjgdQyhzDwWjtlhZ2Av23xY=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+jTM28OhzLNobZR+u0ySFPD7kGtqGjSHX555Uil5B1278Cg4l6
 S5lztN9biOi7NY2gX+blz2rtTVyRwrkMc5ytaV9JbBT6FdlhQA2Jyf7d
X-Gm-Gg: AYBFou3VevYBnRHufvGWMS6X5w40xXF2C6WLF5sAeHx1ClnJry5xqSmIddHrkmewXr7
 UQvjlu+UWQqqX1cJXMkgPt4g88XuEh5ctHI4jf2qNeQvT83P6wXKeQCWrpTKQ5MKsnlk0TzKNmD
 y3q1M9Mf8fmlhCSRB5+UaZ5pHJT6yDo/mzEyXU74etp4y2SPpatm1wHL9yP5kKCC3gXcNrJjHAT
 Y3i81zlkzXRn2ntAWGm+zQY8NpVofnM+QzSbcj6MpX2dBRdPVZCWX/bmXn6fwm1R30pCiFad33O
 YeuTvJAQYjNfzrz++pHWOUD+awu4kM/wRN9mdA2jXzBmZLv8QTVCoJ26+LiyV9kGR2z1RWotmkF
 UX0aJe/7EuAZ1o8t82vUwf2umqfRwqKInDKomX3djjbiOi+Br/WAh5vQDK0O909YX/zGtXsGfN7
 b3hMED65hbUKyb53oBt/Xb9MSUMpLSi0oaqQVTzxmroxl+aH/03FG9Iw5ljmPfezeZwkKmVExam
 JCSIDS2KV6jOf4/vIwPx2T9opZAIr+YIu/d8yWSC39DiH7B21xRz/jUwNFP/Mx8i81T6zv5FPvx
 aM+LNhB/xNoQ26eVFFMtFD1FLf0cvOE8FhyMb85Agx2K75EtPGBh
X-Received: by 2002:a05:6214:4518:b0:914:45c3:7920 with SMTP id
 6a1803df08f44-91ca4b1cb1amr156083956d6.31.1793590070385; 
 Sun, 01 Nov 2026 19:27:50 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca804eee2sm80737396d6.27.2026.11.01.19.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 19:27:49 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH iwl-net v2] iavf: reset the VF instead of freeing rings when
 queue disable fails
Date: Sun,  1 Nov 2026 22:27:43 -0500
Message-ID: <20261102032744.304907-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

iavf_close() leaves the Tx/Rx rings in place because the hardware can
still DMA into them, and iavf_virtchnl_completion() frees them once the
PF has answered VIRTCHNL_OP_DISABLE_QUEUES. It does so whatever the PF
answered: for a non-zero v_retval the error is only logged and the
DISABLE_QUEUES case runs anyway.

The PF can fail the request while queues are still running. ice and
i40e give up before the Rx queues when a Tx queue cannot be stopped,
and ice also fails when an Rx queue does not stop in time. The rings
and Rx buffers are then freed while the queues still point at them, and
received packets and descriptor write-backs land in freed memory.

Keep the rings when the PF reports an error and request a VF reset
instead. The reset makes the PF stop all queues of the VF, and
iavf_reset_step() frees the rings once it has completed. Until then
iavf_close() may warn that the resources are not yet released, and
iavf_open() returns -EBUSY.

During removal no reset is scheduled, and iavf_remove() would wait for
the state to leave __IAVF_DOWN_PENDING forever. As it resets the VF
itself before it frees the rings, complete the transition to
__IAVF_DOWN in that case. If the reset never completes,
iavf_disable_vf() now frees the kept rings as it does for a running VF,
instead of leaving them with page pools that point to the q_vectors it
frees.

Fixes: e284fc88dfb6 ("i40evf: delay releasing rings")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
v2:
- Let iavf_remove() go on when the failure arrives during removal, where
  no reset can be scheduled (sashiko).
- Free the kept rings in iavf_disable_vf() when the reset never
  completes (sashiko).
- Rebased on v7.4-rc1.

v1: https://lore.kernel.org/r/20261022192753.69765-2-oss.patchbox@gmail.com

This was found by code inspection as part of ongoing, not yet
published research. It has not been reproduced, as that needs a PF
that fails VIRTCHNL_OP_DISABLE_QUEUES.
Compile-tested only (x86_64 defconfig with IAVF, I40E and ICE, W=1).

 drivers/net/ethernet/intel/iavf/iavf_main.c    |  7 +++++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c    | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2f8a80a11336..70ee5ae14a64 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3064,9 +3064,12 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 		iavf_napi_disable_all(adapter);
 		iavf_irq_disable(adapter);
 		iavf_free_traffic_irqs(adapter);
-		iavf_free_all_tx_resources(adapter);
-		iavf_free_all_rx_resources(adapter);
 	}
+	/* Also release rings that iavf_close() left in place because the
+	 * PF failed to disable the queues.
+	 */
+	iavf_free_all_tx_resources(adapter);
+	iavf_free_all_rx_resources(adapter);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index e6b7e8f82c7c..28818319a6df 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2718,8 +2718,22 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
-		iavf_free_all_tx_resources(adapter);
-		iavf_free_all_rx_resources(adapter);
+		/* If the PF could not stop the queues, the hardware may still
+		 * access the rings and Rx buffers. Keep them and request a VF
+		 * reset; the reset path releases them after the PF has reset
+		 * the VF. During removal no reset is scheduled, but
+		 * iavf_remove() resets the VF itself before it releases the
+		 * rings, so let it stop waiting for the queues to go down.
+		 */
+		if (v_retval) {
+			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+			if (!test_bit(__IAVF_IN_REMOVE_TASK,
+				      &adapter->crit_section))
+				break;
+		} else {
+			iavf_free_all_tx_resources(adapter);
+			iavf_free_all_rx_resources(adapter);
+		}
 		if (adapter->state == __IAVF_DOWN_PENDING) {
 			iavf_change_state(adapter, __IAVF_DOWN);
 			wake_up(&adapter->down_waitqueue);
-- 
2.43.0


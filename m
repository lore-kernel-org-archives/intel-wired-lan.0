Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C9606A32D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=B8MoZ6H5;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZSoLApj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93ADD408E6;
	Wed, 11 Nov 2026 09:30:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nuGR24q6zYtH; Wed, 11 Nov 2026 09:30:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C5186408B5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794389454;
	b=cWOscL0AkZu25b2kOywFr/jKd7zJMJzIa9SHJIVnTzv0Ro6W6qmK/0l+u+Y+cabt+svZ
	 SDiHRQs55BG2A4/N30D/q+iHtmXGJpSrzzueVfCaKFv5+YWTK5dPOJywzCdOvJJ8KwI2K
	 TSpzsKt34pVTGHdySXhpcFE8YNeH+FBUvPqG6ctF3LyAWvVBy1Ly1RzxaSHjjJooo2R4Y
	 01v4In9BpN1vX+aH9pHabBKwNRySvDY1cQn/+utHdv8lZJfKA1j+I26lJ3zMUicjQcrND
	 oUpyF62uc3WmFkaPfyVmrwvzv5Yh3GsTywASWkeNH71WUg74KqREn6c0BJEyxqW+/5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794389454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
	b=DU7rbSYfxfcOfxM4PcpeWuQqvMKvKu67VIuyUf6mqG8H8VBTIWd2e5jYucyrNmmf4zRY
	 Nd7oL4g5lCpu7lfrUZBoLsgPnuUsHhDTzcwE45dUB6gUKP0ti1mZ/7rt1zCbV86S7Pnmg
	 gTOHassR+XoAo/ZxCIvY0h0pOfxK8rjMtV6H3g4GdvWXF7LN/Lx6JBC3c2as8vY1ahMPY
	 Xvw4F6AdMulEpyNIC6k4Q1/ZxpkMtGc/tLvz8qtZMGu/O+PC/dcI0kSlWr4aMMHWXAvZI
	 AR8MhD1bF+eoEPPPuSKHeIeu9dqzfv/DaIlF/8dH40WqkROkOuN7bNeN0hQU7FLzRyA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794389454;
	bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B8MoZ6H5+DBB297iBXO8l2MpG+pbAdu9xSQ6rEr0VxjjFeY546IH7MJQE7dDbGFOo
	 3S21TIC8d+2adJkXrAdJLCvZN4dXlq8MVGkudz0sHFt+OrHf8bc9PWbjgHc2Sd8NwV
	 M0yg1OML52912Va5yXkZz1BmZ0NUuIQJjSuLjZK5Cj7REK3fIOSRW0nwAHxnOTChSk
	 +T4VHjVtmjVrCtAQSl2TSOt0Di8C+cDVH71kv/gpliwgz6dOqJ55PzhCnR5bqHZFef
	 19vHlLW72s/WrSDDNkygIluqh6+d1VPGL9gN9B5mLR8FNRPCcSeWgnvlp4UMbUBG/S
	 g25CQZX15C73Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5186408B5;
	Wed, 11 Nov 2026 09:30:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 94B2917CC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 861566071E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nmPOzNFeLy4H for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 09:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D127606ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=danividanivi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=QZSoLApj
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D127606ED
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:30:52 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1948106f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794389450; x=1794994250; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
 b=QZSoLApj6R9HgLjLhRIVmWV/YB3jBx+p3kMFvmnrWqL/A7WojBnwDaHGxH8IF4P7I+
 Q8kOi4U5rMLDhfvyhg5+3M1EYyXxjR4GxGZKKUCvX7S0S6BhzsbM/sNCkdev5xgMwIwd
 RIsnojtb3QXcM36soRs9g7xYbHpF70u7UUDWI7HftJqDQPs3n8dLq+XVBi1nY4U8fHq5
 P/QjHIvBOMgl6iSaTxgNnc05o2qs3oUquwggo1BEgaxq/EMRq2uYwfHhY9+MpLon8no8
 ATr0JgGgbqHphsm/PHp4BTDUJHefC2EUx+bvCF6hbLRp7H4HQK/jtv4AaUynH02LLYBE
 K7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389450; x=1794994250;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
 b=aPBfgJtV+Fgd6AxKnDOR0wcXt/ew7WslwT0UNFxGrkILN1fGqq1CguRED4gclPvp3h
 1Yv9AgMt7DM5nZYcfFNjRjXmlpRrJNeNiN+FL9RLzNSHn8EjHwoZOIuvZUGs/4uvenjI
 4TwACKGCLeNWW73AvibGxmPPUGfYav/V7CavqJkI3OEzhD0e8cRtuXgdpdpRsEqMh++N
 vNe2EfGkFFKcWrslgcxpON9rCMR+IQ2fSmjbwKrUL1PMM0Asan+gJhTy5AmnXyCyFTCY
 bm1t1byPdbCfCAkF5yooyXAV/dVF6OhOfFtEwZ9MtHeOXZbpiFgvkpNQORoU3wGh6V7w
 XN1g==
X-Gm-Message-State: APuU4Z8tytTsj3tnI9QHSFnNwDjz5C7qFygR0fckgP4+aVoe1dFLJqOu
 rMDitgy4WlJqaPPcfQPrqrTnSz01fb0SGFRK+DPjEKIXjaT3NhPA7fu1/qlakMCvLgQ=
X-Gm-Gg: AYBFou3Uh781zcwGBKrfOz84U6czXYybEFVSt37PFlId3TlnIykhkwCApOw7qqckps9
 zb4Qg2V/MMABLyY5N62w0qJ0zM29qNU1FIsdA2EK+S0SaFK43KVyuhG/3+WJ/bvd5jk6sM258Fp
 VlmelEgwYc9T+1VOxrUt0VMmQ2u+9rJMg+yuzwPeFJSvaeA6Q0imeBQ6gWfTYwcM9LshRDECL9L
 8GZTp7el0XPykQvJ+dci7z3IwztwGmU26D3dM+4fgRcYwaRJBdZzhA6TI0n5L5KPCmV1CeoIUPc
 KrylhHwByhBSGHfekNlPXjt9X5d7D33Blubh+zrFjTYjpVoK8Jkw6EHs89z/tyhadmN3a4ROj4Y
 ABpMCK4uZYqLIihl65zqYUpeCJJFMyijLLg7rcbL3CnvzBXfPv+O5/ngOOtB0ddho+2WugeDkbD
 zRe/vhF2fP9evVAaBi6BMmXvkvRFWMLLmvXltBLjwar/WTpYNOz0NhWVwTG+Z5htupAQShgWBWP
 DzFBuZyliuRwXh0utFht1b95ymgnP11TAoCddpXhT1HLm874L7bVnK3a8qJO/ZfhawOcya9qLX4
 J++NZsgYb0NLahbEgtxTV/eL4BE7cHszAkVYwUfKRL8Ccw+EPfmaiT4i/pcB/jbTVi2SRMk4i3G
 D53q7CK/ym5p6nn0H4zNCRqc/xMQBTJjgOaU17QFnyiKWshaq8Mh+/uGr2maigB1aET+FTew7aH
 e8YCdpD61hWCg=
X-Received: by 2002:a05:6000:25ee:b0:48e:932:aefa with SMTP id
 ffacd0b85a97d-499c630fe5cmr2820902f8f.26.1794389449756; 
 Wed, 11 Nov 2026 01:30:49 -0800 (PST)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498362eb14asm9175839f8f.34.2026.11.11.01.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:30:49 -0800 (PST)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 dima.ruinskiy@intel.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH iwl-net v2 0/2] igc: fix L1.2 disable on resume,
 add I226-LMvP to I226 helper
Date: Wed, 11 Nov 2026 10:30:33 +0100
Message-ID: <20261111093035.513635-1-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series replaces "igc: Disable PCIe L1.2 substate on I225-LMvP and
I226-LMvP devices" [1], split up as suggested by Dima Ruinskiy.

Patch 1 removes pci_disable_link_state() from __igc_resume(). That
function is also the runtime resume callback and can be reached with
pci_bus_sem already held for read (pcie_do_recovery() runtime-resumes
the affected devices from within pci_walk_bus()), so taking the lock
again risks a deadlock. The L1.2 disable done in probe persists in the
link's aspm_disable mask, so the call is not needed on resume.

Patch 2 adds the missing IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226().
Besides the L1.2 disable, this also moves I226-LMvP onto the I226 TSN
code paths; Dima confirmed that this is correct for 0x5503 [2]. Patch 1
comes first so that I226-LMvP never picks up the problematic
resume-path call.

The I225-LMvP part of v1 is dropped. On the setup where I saw the
errors (HP Thunderbolt Dock G4), the I225-LMvP does not advertise L1.2
and the upstream port has no L1 PM Substates capability, so L1.2 is not
the cause; I will investigate that separately. As agreed with Dima
[2], disabling L1.2 unconditionally is not part of this series.

Testing: compile-tested only (igc builds cleanly with W=1). I have no
I226 hardware, so neither change has been runtime-tested on the
affected devices; testing on I226 / I226-LMvP would be appreciated.

The resume-path issue was reported by the Sashiko AI review of v1.
I used an AI coding assistant (Claude) to help with the locking
analysis and to draft the patches; I have reviewed them, compile-tested
them and take responsibility for them.

Changes in v2:
- Split v1 into separate patches, as suggested by Dima.
- Dropped the I225-LMvP L1.2 disable: L1.2 is not supported on that
  link, so it cannot explain the dock errors.
- New patch 1: stop calling pci_disable_link_state() from
  __igc_resume() (reported by Sashiko).
- Corrected the Fixes: tags.
- Changed the subject prefix to iwl-net.

[1] https://lore.kernel.org/all/20260925112850.189302-1-danividanivi@gmail.com/
[2] https://lore.kernel.org/all/5d45a583-198c-467d-afbe-8f19398e82f3@intel.com/

Daniel Viaño (2):
  igc: don't disable ASPM L1.2 from __igc_resume()
  igc: treat I226-LMvP as an I226 device

 drivers/net/ethernet/intel/igc/igc_base.c | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.53.0


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D26606A32C
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=D1/r2cbz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/8JqkyM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A071D4050D;
	Wed,  4 Nov 2026 06:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRCreQGaEqWA; Wed,  4 Nov 2026 06:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C314B405C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774088;
	b=OSEs9U9uuMdRsrvm34uwzPRI4o5v4jiMpIorPs5GsidQM8SBwe1tqsTo7dywVsTyo3s/
	 xIY79YGInyFRB+XF7H59NDxznMbYjYBq+iIhN8sKXGAQZ/eBGbqOE7sK/nVwRg0wG2YMP
	 iStCQp8+LjTdCi/+MkW9JYnb0HYVjeN0MyL94uwUhv+BdHmiyYxZMXkMG+nZkuwQ0r/UP
	 zZRUYVSTjeGuuVSQeoklJVkjF0p6rQJUzxGKot/Fa1E2SY9Pu8NkfTDxCzBBQE9QfcdKo
	 CIcvQW7hgh7JVaVm28M6OWY4sFOSUxoLmv92dHRhwVVyzZwbpt2wR2ZAIl1uo0lHAVg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793774088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=MHNlWY1egLAPDli9Hl3l2outM5ANrsxgd0TR3tsAmI0=;
	b=QlnbfEGK8tRyC04TzufuAvJqgtV+YGMyRr/HeUJatR7DDuCCvqiG3uuX1mQnP9NUranr
	 zp1Qeg11SOWk6TliQg9G3Meg8+UnShL++r9croU7ATucBvBfdr/LaRZdf72+5LcV2U+HM
	 APSm+gnoQjD1kfILXc6DXQLOVhaHibC39SaGIlEvAsDn3qjtAiZyAB5TwHgKjW4ZqD/yk
	 3h3ROX9URuXTb5J7yWEN/DAgTapkJv6WzMEKNTkguvLBrx3T5qjifaeoSvTfFyzz1zXHo
	 DNlDSkVi7/HR9oJM/IqgL4TikeOsKM39lruLwAKTJ/hRAhltUJDQtlf7AvSoizdyYdw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793774088;
	bh=MHNlWY1egLAPDli9Hl3l2outM5ANrsxgd0TR3tsAmI0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=D1/r2cbzk7zc8HBWG59gQZRRmO73abcw4audTpdDIAYWk1AaxGwBfwfVzPpXFoA4g
	 cbZk5nFAyOPeX6qZbp7vh22l03jFgtxGlccNt09FIYbAXKhkU6uUUyaDzr1iigJ1pO
	 nbM4B1SNLanj787oSGbgJN6LOmdufUTQRnbuAJtD8HnRkC7RNHo5MLc3Fw0itaJyzX
	 O0q86Dv48HAe4gAEN1rdbMfGQKYDeCFWrs6C6jISaXOxVaysgBsWt8N74EjNSimoGu
	 ESgqoM326Xs3mC4aEv7ajcBIRA8f8tA+rcqVLGOkUvGH6fOrkfGE7tx5Cz75QGvDci
	 tuiicuSyclQNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C314B405C6;
	Wed,  4 Nov 2026 06:34:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 343E92B6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19B0480D6F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:34:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6p5wBRGDncUU for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 06:34:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0253780BDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774086;
 b=JbtAL+fHlwQGzibZREtKMLbwWNfUwfGsL1bOqdJmKecPRWM00nq/IxbBoQTXOjclMwzv
 pE5CG0IO0hEFANyGZblWiMU82cD+mAYgGDDG902adxjrO4U+IAZ89rSX4eqN6O7URsUli
 IJz0JlqzUGy/oCLMnUp/ih6j4akMEHifDRK+6YVsHtWwKfnhUZ4nbF5I3g37tRC8kQWZt
 qzh2pZ/peoQJ4EFOtdFWFo+XvUOONebVs3dIbURsGkmkMOsD/RemAXrwjIR0w32OLY4oZ
 hH1U0HMTIsGSi97WtEZKGVMgKhZZ/yEERNNSP1jhF0/WRjGYtQzzuZITK4SaPtQw1cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793774086;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=MHNlWY1egLAPDli9Hl3l2outM5ANrsxgd0TR3tsAmI0=;
 b=pixn0eh+jZ0PFETRLM3ZV/meSGbl+CkiCFHReIGsURI3V8S20LyleMEFBjR8kS7xhGsm
 OxcOAvKYAy2cKYr1/nezLW1uUfaGXj1agKG7Fp/fsX+YeM/7SwZz0I4RgyIcr+hreAkWf
 eyeRnIioZpO8gbe3SOdUVn+lv8cIHot4fAXeNTqTIkebF4K9v6hsPMzmA8E0tXEtqKGRz
 /tUWyWFpZ9ZKx1YYCDmnbJUzidxGAmrD95bEy2z7KEZZEzTNaLUGjaz5gf+3kleQQPVKc
 K4bRozNq2VutljwtetnLg61kIoaCWTM7V/YbTmGQ5NgczdFK8OoPrAgNwKJ73XaNylQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="J/8JqkyM"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+tkusters.aweta.nl@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=J/8JqkyM
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0253780BDF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDCCD60A8D;
 Wed,  4 Nov 2026 06:34:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793774083;
 b=YrtUOuzuv5qfU4L2QWop+tSqyGImgJ5NqNlE87SZ2FOyTxfxJ43E41w0cQnaOzmJkx0f
 a6LtUt0xYJ40tTfmmR6xjyKvsZ4/6Pj7Y89s5tOm/sOeRqxea4Pu9x+3Zsl9vHkdo6CT6
 ZqYiterglMgS9TRFtHz5o+Rz2rhOIlGxyavDLvYp9uLAgcCOpXAebvFtDEdWtcWlgjF3L
 N5TGFM88+tksyG8Pg54W5F06EQ8ocv8YKbIfXTgTlpL5Ce4GPusm55DpiUhLF0Uzgdqcp
 PJp6JnRtTQr8OAq/TfcEow6pPf7uBy2Ls3bZorUIs8Y8neOwD6Np1mheEryxXy39IvA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793774083;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=MHNlWY1egLAPDli9Hl3l2outM5ANrsxgd0TR3tsAmI0=;
 b=GApRU04ddG67F7GNeU+tSYRzEJ44zJXTaDQrt0qq6i5yMj2w3HC8dJ1jKTgLuEX2BsHf
 43maQCjtnA2QVq6MUkioE5zguGmF4TbP+A+JugcpVV9i9llbRj6hxWd2UFyW304YcziK+
 CUns1bFV7Zz+ONTIr4lp8Q5RHDQiNoPI37zZTWPJziydyDr5aYtDvRAyoyl371kE9MJqC
 Kl4VbwPEkAHX/684YGv7ImWINTOerhWEPgTqzdmLnrFZyLvXhUUwRYEgYD1hnfJPUktgb
 0SxQgWNpdTrcmTo6ljgVlIoV8E/JK55v+XoMHDN8rDhIdn49eL71tHx20q/XUVfmwPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0706E1F000C1;
 Wed,  4 Nov 2026 06:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793774083;
 bh=MHNlWY1egLAPDli9Hl3l2outM5ANrsxgd0TR3tsAmI0=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=J/8JqkyMcXdwhEkHIkALyuUKwYITi+/ZdiNauIFjWER6bg7gfWkbMhieaBO+jfB3S
 aOwCacNVVzimVPVi1+Rm85iXLMyIf50ms6gRBTmbJCFA8qS9knI5XuCMiXN7G5PVQC
 Z8pnaarxF32TpICPeGqTyBcQ8X5Lp+DRAh0IZ9uAMRM/asQ91MbgitYlOxNIKGNW0c
 vmHsaF5jBK7LJyGCY7qQPipC9vAgLBht1FHjfG4+zX2M5UjS2DrlEkOBfrqXXksdMZ
 2ppqqbCyTgPrSOwlBuOpgn0D6NXW7oplWmoidgWolyRFpsuAewQ2jjI3dzPPY9yduB
 NXSdxvXESN7vA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8CFEE46CB6;
 Wed,  4 Nov 2026 06:34:42 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Wed, 04 Nov 2026 07:34:41 +0100
Subject: [PATCH net] igb: do not let a VF set other VMOLR bits through its
 frame size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
X-B4-Tracking: v=1; b=H4sIAADS6moC/yWMzQqDMBAGX0W+swuJxR98FfHQ6EZXNEqSSkF89
 6btcQZmLgT2wgFtdsHzKUF2l0DnGYb56SYmGROjUEWltXqQTIZOS349tpUaq6qSbVmPRiMlh2c
 r79+ug+OI/i/Dyyw8xO8I9/0BsR7w0nUAAAA=
X-Change-ID: 20261103-igb-vf-rlpml-8f065ef57db1
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Duyck <alexander.h.duyck@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793774082; l=2997;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=gJ/6Nb2DFZwQG8IMxy1R6SsS7T1wEalj9eb88cFYTSI=;
 b=lzQKI79dVW+WwBE1gL8azTYfgurUMIbjVTwexkCXObrI6VvUApkNYTHe9K8XyzJQaCm0589h4
 gN7vJgU9+4/DZLJptI9Gg0g3ja8nV816Ec83FI7bhsctJOaxaZ6MQhz
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Content-Transfer-Encoding: 7bit
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
Reply-To: tkusters@aweta.nl
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tjerk Kusters <tkusters@aweta.nl>

igb_set_vf_rlpml() gets the maximum frame size from the VF's
E1000_VF_SET_LPE mailbox message and takes it as a signed int. A value
with bit 31 set is negative, so it passes the "size >
MAX_JUMBO_FRAME_SIZE" clamp, and it is then ORed into the VF pool's
VMOLR without masking. Its upper bits set other bits of that register,
such as AUPE and ROPE.

A VF whose port VLAN was set by the PF has AUPE cleared, so that it only
receives frames tagged with that VLAN. Through this message it can set
AUPE again and receive untagged frames. It can also set ROPE, so that its
pool accepts unicast frames that match the Unicast Table Array; while the
PF fills that table, in promiscuous mode or when it has more unicast
addresses than receive address registers, that is all unicast traffic.
igb_set_vf_promisc() does not offer this to VFs.

Take the size as u32, so that such values are clamped to
MAX_JUMBO_FRAME_SIZE, which fits in the RLPML field.

Tested on an I350 with two VFs and kernel 7.3.1. VF 0 got port VLAN 100,
and a test build of igbvf sent its frame size with bits 31, 26 and 24
set. Before this patch, AUPE, ROPE and STRCRC were then set in that VF
pool's VMOLR (0x8f010bce); with it they stay clear, and the size is
clamped to 9728. The normal igbvf still sets its size (3022 at VF MTU
3000) as before.

This was found by the Sashiko AI review of another igb patch.

Link: https://lore.kernel.org/all/179370458190.488856.17697539789438631896@kernel.org/
Fixes: 4ae196dfd61d ("igb: Add support for enabling VFs to PF driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
The Sashiko AI review reported this as a pre-existing issue on v4 of my
igb Rx timestamp series:
https://lore.kernel.org/all/179370458190.488856.17697539789438631896@kernel.org/

The patch and its description were prepared with the help of an AI
coding assistant (Claude). I reviewed them and ran the test described in
the commit message on my test bench.
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a8c82c..d808ad37041c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4663,12 +4663,13 @@ void igb_setup_rctl(struct igb_adapter *adapter)
 	wr32(E1000_RCTL, rctl);
 }
 
-static inline int igb_set_vf_rlpml(struct igb_adapter *adapter, int size,
+static inline int igb_set_vf_rlpml(struct igb_adapter *adapter, u32 size,
 				   int vfn)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 vmolr;
 
+	/* size comes from the VF, keep it within the RLPML field */
 	if (size > MAX_JUMBO_FRAME_SIZE)
 		size = MAX_JUMBO_FRAME_SIZE;
 

---
base-commit: c3e67bd82b9b9b1a5118f09a429ccefe2aab0741
change-id: 20261103-igb-vf-rlpml-8f065ef57db1

Best regards,
--  
Tjerk Kusters <tkusters@aweta.nl>



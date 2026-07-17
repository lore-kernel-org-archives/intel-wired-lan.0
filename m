Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786DBC44507
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Jul 2026 08:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D4DD40609;
	Fri, 17 Jul 2026 08:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gTenXjOmU4AJ; Fri, 17 Jul 2026 08:51:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B7E440596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784278263;
	bh=VdViR0G1KMydncyi2V8OntbhkvpFS5IW5lP/oAPvnhs=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WUMCR8/zg4ENaf4swjzYxpg9TNCrClAErI7ye9IHhf/2kgD5a1bBkmW5tmkdwy+lp
	 DBGNtedI3+mJMRPoC2eRLPIMygvIhw6SN0OT/Y1A6Nh8WMlaE4oA3hfIcVZxJ2oLJQ
	 SFRHqVr+W4yi7gWCnuPLPGmtmHVLPKrHICqF2XQQ3vF7+r3Orbe6y8JAfLygklaets
	 k0fvuZBZi7KMqzvu69FbEfxQ3GPg9UrtWYfSC/wTZ6RDcd6qL1PK/HMnkjgOcdnm5E
	 fWpfEctw5d0JUBdiDNNfXV/BSxeZWwW9a9ZaN6bzkrdVFGSrwm9R1ROk0m+OsufwIH
	 TmY7ihAysZqww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B7E440596;
	Fri, 17 Jul 2026 08:51:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 44AF61F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 08:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 279C9409CF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 08:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNORFB3Prfmd for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Jul 2026 08:51:01 +0000 (UTC)
X-Greylist: delayed 356 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 17 Jul 2026 08:51:00 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EB35C409BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB35C409BE
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.223.130;
 helo=smtp-out1.suse.de; envelope-from=tbogendoerfer@suse.de;
 receiver=<UNKNOWN> 
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB35C409BE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 08:51:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F04678DE8;
 Fri, 17 Jul 2026 08:44:58 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A67B779AA;
 Fri, 17 Jul 2026 08:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KKFpAorrWWrKTgAAD6G6ig
 (envelope-from <tbogendoerfer@suse.de>); Fri, 17 Jul 2026 08:44:58 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 17 Jul 2026 10:44:52 +0200
Message-ID: <20260717084453.9521-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[netdev]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_rsa; 
 t=1784277899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VdViR0G1KMydncyi2V8OntbhkvpFS5IW5lP/oAPvnhs=;
 b=Dlxogzmf8W/Q6q7hjIN+ghXV7spmbkSKhcbYUtp4Cs5dQJLKPIKicnauHtrF0PpWa9hO+S
 MEJABf7rUWZ6OC8OrkIK0PufHujbxR2vDvVgGQltWQReIi+RddCB5+uioQ+rfNXkZaoDvI
 63kgMP5kD+XFHN29XKU71Q9uGPEwfCQ=
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_ed25519; t=1784277899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VdViR0G1KMydncyi2V8OntbhkvpFS5IW5lP/oAPvnhs=;
 b=veYVwi4Y8gMvfmPY/UWz/hNAcbLEy1ye0Q6fzGF0KDPvc+I1/xanqoET7Ifh6yuprMCz9e
 H3DwfBKbCG/whMBw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_rsa; 
 t=1784277898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VdViR0G1KMydncyi2V8OntbhkvpFS5IW5lP/oAPvnhs=;
 b=rdQS+H59OmTIEUAua7JgegFBlfVrtawYGm9aWX8wJ5keS42jGJeFjLhu729WxtCpZi38pq
 5NVgsOMsqdU6vIbxaWtAW97RBVAyD8hoM035IciXgBJEVivcKhimWg0NACDgXfnZrXLb9j
 9DEjp3A1q/q9GMXZBGFIV/zhpWbqog8=
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_ed25519; t=1784277898;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VdViR0G1KMydncyi2V8OntbhkvpFS5IW5lP/oAPvnhs=;
 b=xeb3S8hQKZ+x8F2JBaXGPZj7pHMfyv4pehTBQRZvJYZ8JATbXWsIbLgNK2GD8VCdWtRXhx
 Qgv6iWJmPZ76bUDg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=suse.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Dlxogzmf; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=veYVwi4Y; 
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=rdQS+H59; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=xeb3S8hQ
X-Mailman-Original-Authentication-Results: smtp-out1.suse.de;
	none
Subject: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter
 fallback message
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

Seeing an error message in a logfile triggers scripts/admins thinking of
problems. The LLDP fallback message itself is not an error, it just
indicates it's using a different filter mechanism. So rephrase to a
less "scary" message.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdc4fda89e9..59341b5a0c05 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2097,7 +2097,7 @@ void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 				goto report;
 
 			dev_info(dev,
-				 "Failed to add generic LLDP Rx filter on VSI %i error: %d, falling back to specialized AQ control\n",
+				 "Using generic LLDP Rx filter on VSI %i is not possible (%d), falling back to specialized AQ control\n",
 				 vsi->vsi_num, status);
 		}
 
-- 
2.51.0


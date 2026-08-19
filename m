Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB791C5DF85
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 08:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A7E980DA6;
	Wed, 19 Aug 2026 08:30:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6hWUVDvoFTgl; Wed, 19 Aug 2026 08:30:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787128223;
	bh=4I655Z8usTsABgDzcg+e8tOh9qDi1DnobFMKfs+spl8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4Pjdld2/EY30vwlruOit4r5ck2NTWqWGC4MFXac3YUoAEFjgwKzzag/p9kNoIhybF
	 kSxNYUIq0cerJiMr0XwwPbvis+EGrQzcfwBNpyVegA9vvVTQLJGxrja7C1VRPxIbH6
	 fnrEpkaFieJy/fdaZre3M96vsYd2iKF2jQ1ge2T/NsMpEXilSsILyGPHpAdyVv7OrH
	 ZnyhmpCU6+4QYUT9WwepV3GbrEbHu1sf7bJ8txh5FqsIGQGEz7je8qa07eINZT7LjO
	 mzoG5npUxYIqAbdvDhpPeAjJ94sceW/Xdtd0Pun7VulpKLiIOrXVfSSRHc+JPVxoMN
	 vqfkv7EjVDf4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1333580D93;
	Wed, 19 Aug 2026 08:30:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFFE5265
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 08:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B224540042
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 08:30:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Imt0T1Z5RbzA for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 08:30:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ONdqGDOM; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dpFAmo/r; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dpFAmo/r
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C4A340026
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 08:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787127916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4I655Z8usTsABgDzcg+e8tOh9qDi1DnobFMKfs+spl8=;
 b=ONdqGDOM/uPLL27e5yCJmgKP6agGpKMuS/lHPUJ4tY99wmRKaUQpdUa8RWmAg/foTQDecx
 QgcTKCBG//otNmD9ceh5wouzc/17HWr9VK1aaiyiBXi84KqLn53qO6tEceM0UPeY27lSDr
 CrHA/06vWDTRBZpdCmY3k4BL3yf1EGo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787128218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4I655Z8usTsABgDzcg+e8tOh9qDi1DnobFMKfs+spl8=;
 b=dpFAmo/rbscd5Zn1OdABaaNbHfxsJRq5zJB4wJ1q52aoaGzgyQCqz89pH7qoZws6Rh9lX/
 lv0poYl50mnkoHN4GnoOT5SdCYHYF6ZCO3TgL7o5ZqpW2B4BhksVx4boiZXqWlLgzxPjqe
 QxMSn30xzHrKD/DlPm4rO3LmWX1Lsuw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787128218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4I655Z8usTsABgDzcg+e8tOh9qDi1DnobFMKfs+spl8=;
 b=dpFAmo/rbscd5Zn1OdABaaNbHfxsJRq5zJB4wJ1q52aoaGzgyQCqz89pH7qoZws6Rh9lX/
 lv0poYl50mnkoHN4GnoOT5SdCYHYF6ZCO3TgL7o5ZqpW2B4BhksVx4boiZXqWlLgzxPjqe
 QxMSn30xzHrKD/DlPm4rO3LmWX1Lsuw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-lhC8i2QbM3-0QiVi97DAxQ-1; Wed,
 19 Aug 2026 04:25:10 -0400
X-MC-Unique: lhC8i2QbM3-0QiVi97DAxQ-1
X-Mimecast-MFC-AGG-ID: lhC8i2QbM3-0QiVi97DAxQ_1787127908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58403195604C; Wed, 19 Aug 2026 08:25:07 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.22.88.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B2741800348; Wed, 19 Aug 2026 08:25:01 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Jacob Keller <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>,
 Robert Malz <robert.malz@canonical.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: allow reading the last byte of the NVM and
 Shadow RAM regions
Date: Wed, 19 Aug 2026 10:24:58 +0200
Message-ID: <20260819082458.665947-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: utMUPutfwf0Fhy16mppxtaO33woL5xFT0YGsbqUOZHA_1787127908
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

ice_devlink_nvm_read() rejects a read whose end lands exactly on the
region size, so feeding back the size devlink itself reports fails:

  devlink region show pci/0000:04:00.0/nvm-flash
  pci/0000:04:00.0/nvm-flash: size 10485760 snapshot [] max 1

  devlink region read pci/0000:04:00.0/nvm-flash address 0 length 10485760
  Error: ice: Cannot read beyond the region size.

shadow-ram behaves the same. The regions are created with those sizes, so
a read ending on the size is the whole region and has to be allowed.
ice_read_flat_nvm() uses > for its own Shadow RAM check, and so does
ixgbe, which grew its region support from this code.

Fixes: 3af4b40b0f2f ("ice: implement direct read for NVM and Shadow RAM regions")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 8c2b63eef82bd5..a52b6044288975 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1953,7 +1953,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
-	if (offset + size >= nvm_size) {
+	if (offset + size > nvm_size) {
 		NL_SET_ERR_MSG_MOD(extack, "Cannot read beyond the region size");
 		return -ERANGE;
 	}
-- 
2.54.0


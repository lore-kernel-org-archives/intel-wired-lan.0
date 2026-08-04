Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89AEC5518F
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 08:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 950904070E;
	Tue,  4 Aug 2026 08:35:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r4KRMd7D0TtD; Tue,  4 Aug 2026 08:35:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79023406EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785832549;
	bh=EwWoMFmkHrUBoojEnGvrGh+7TlMjWGGUnHH4vpXCfXI=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ItkxfUfHS5YlMDMJdHgiGiSa1HxEG8NsUCZKZ27kwkQ0/NAgXp/3mFyVakmlNSs8p
	 zFZrWD4MtkPmzUXLDp4MDuqYNJ1Iqod0OrQe0+DeXFSaH8Kk8qhsyu5jYBbGf5W+Yc
	 gG9YKWIPHH49jIWXQIA5LQ2aMY6qzlYEho+y5jDkcc2mdv/22Vw+tID0DxL3SdXiui
	 CA12RH6pylNh1r5agjvfsED3NyT3InL69XqWhCMD/Xbk63htF/+CujFBV0eSiDbGeY
	 Yz6fk45BrQY1pRPLaXj5wCv9O4s8wDsD2qYxPu+H2lzmv5HZMRQUTPgIVXhrk/HoCC
	 rTv0eew9aEbGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79023406EE;
	Tue,  4 Aug 2026 08:35:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FC4423F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 08:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D81B406EE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 08:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RyXTCDcmaTwx for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 08:35:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=robert.malz@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 94803406EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94803406EC
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94803406EC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 08:35:45 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 91B1A3FBC6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 08:35:42 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4957287363bso18757035e9.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 04 Aug 2026 01:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785832542; x=1786437342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EwWoMFmkHrUBoojEnGvrGh+7TlMjWGGUnHH4vpXCfXI=;
 b=nLwy94Z94biYBiUHFjDbXTztVW58bgsDq1rAcBirGcSmE7S7wenAR5wE40/2Xz4iFf
 gwiP3BhhXOtjvaUUb49XS5DuEBKi3tXgPpkNgcYok/n6D12MQPa8c7ftTqtWjaTT0Jxb
 uU9fNPs9cpdAymK2KLL0eF+MfcyfID0UztMBbFy+Yv+9BL+ekwyDoMNxvPDDY+N94Pah
 ZfyP3Ufn8p8TvtfgyFnPrw2TxDZtYNtSnChpOIn6Be18ELkwXHzLfZ1kpkUtK1fJGLUp
 2rOYnLIhL8+UbUz2BuPS6qx9WpIRc0g/zrTIlXlRIUnMb/M9Ejic7W6Ad9/Y1AenvQOn
 /9sQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQOsg6KQXy3k2L/7KQC87eqTEuXOzjS9NaQGgxBJAfyokLr5B2AL+QxXX4iWFEnQsDwgoBpnk2Sa4L1tLMn8w=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwDIzsMPw6/uxas4pSiBDiOmgq7vl7Igtj0wQoaidUwm+2cdp9g
 Ah0crNDf7CH2mG6MAcWdHW8WKiQ95wEhvqjkOOCjWaE+oxGT72mkGtCU/SAWzFLqqQZqIYDYLWb
 vaA5FsE60YHpvhiutipZpcz+Ez1NCoP1VnDMrJWx+8JjwFTeV+pOIgEVrnaD2ACC6KbQfxx51pB
 2j90pr2aS6iv8=
X-Gm-Gg: AR+sD11sCee16Q6bnTKj9G+J1R+3hEH690PTCRtXyhq53l+EOkWfm5/bEBkdJowwsdD
 D9ZZutScL1DSGjYOsbYWTV8SDXGwOqWK1qYHazn9eph9MlMN6ry8myGY8zZJg1oa6e79iMywPj+
 lLf0716nSzgWGt3MNLnX/McG2C+3mdPtKpWWlvsLG3ZSpP9NImE0hVjU8R7RlP4i3vZhH1xDw/E
 RQkngeHrpZyQLv4S7hNgfb089LaYCap5d80olhxH2XZi85nMLTjmlLzExjsCXJMUOPH0H1JGOfg
 I3YpUJXHL/ndPp15tLG4qMuRrG/eu3M5CwCwzlA5DbZmRVE8dTUYGO1nnlnH0T8rPQkgUY1rEVW
 e9WQ59TJ+hptqnA329iiJx8o6oiE=
X-Received: by 2002:a05:600c:35c1:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-499484a820emr119807955e9.9.1785832541798; 
 Tue, 04 Aug 2026 01:35:41 -0700 (PDT)
X-Received: by 2002:a05:600c:35c1:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-499484a820emr119806935e9.9.1785832541293; 
 Tue, 04 Aug 2026 01:35:41 -0700 (PDT)
Received: from rmalz.. (77-236-28-43.static.play.pl. [77.236.28.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fd4c33sm61377825e9.8.2026.08.04.01.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 01:35:40 -0700 (PDT)
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Robert Malz <robert.malz@canonical.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue,  4 Aug 2026 10:35:36 +0200
Message-Id: <20260804083537.3997889-1-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785832542;
 bh=EwWoMFmkHrUBoojEnGvrGh+7TlMjWGGUnHH4vpXCfXI=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=RxnJN9gu4Gzypp3bcQFClKvwwVz8DX0o6qSl4RMrnl7udJ+DPyTAuhuj3oRdFT9rT
 30TTlxfivk/CQpQBKlUpUMMB47/39zv0roaSlcfHQ+5Q94om6fn+Uu/p7IESIv1J+w
 KSW2GOxsNnGc7Pvxzq5OVfH2UbsdzGzg3cVoc6KQNGGQPmTZ2ddNuOSHCwxv+P3Gt8
 PPYRvbUDUpYXG3hHHzAy1FMQ2AyCXmF3gIJ1pCeKbYaglWpNTaWVJYraedA1KPFkRA
 HAksoawRRS2Xoue6swiZ7l8PP8jyE0U8G+iebyaS/f7vUnKL8N+9PmNyiknXhZS9Jd
 NYUwG/T3r58OVGabrRv7kCzrWoWhCxnROO/1jzxmZYvTGde5XhspRsauuCdOaG0PjG
 WPCJvbBSuxp2iWLrsUUeK9P2MszxMTTPrtETKLPLoBxOE/eIPEHlIYXfJmXM3QPT8L
 6wnPv4jbrNpyNHYsUYuttgSf29MoBNnOdVA2oGhb2sLNlfy7kBbRS6jpNi8jK2gMiW
 na2hFBeL2HLjl87MoO4oAYOHKrhv3LcCiTPP6PwcqiI70w6+mf40dttsK00yK+aVOz
 0GRZ3UKttTxGGPX3/SauOH3UTxc0I1vjgzvS+L+jrvC6tV7G7zXOdgMufusPFtDanb
 tdcZ/XPLCNcKS4wKO2RDiFf4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=RxnJN9gu
Subject: [Intel-wired-lan] [PATCH iwl v4] ice: acquire NVM lock around each
 flash read
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
From: Robert Malz via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Robert Malz <robert.malz@canonical.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

FW caps the NVM read lock at a maximum of 3000ms regardless of the timeout
requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into
multiple ice_aq_read_nvm() commands, one per 4KB sector, all issued under a
single lock taken by the caller. Reading a large region can exceed 3000ms,
so FW reclaims the lock mid-read and the remaining commands might fail.

Move the lock acquire/release into ice_read_flat_nvm() so it brackets each
individual ice_aq_read_nvm() command, ensuring the lock is never held
across more than one FW read.

ice_release_nvm() issues its own AQ command and overwrites
hw->adminq.sq_last_status, which some callers inspect after a failed read.
Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
capture the failing read's AQ error before the release; callers that need
it (ice_discover_flash_size() and the ethtool/devlink log paths) use it
instead of sq_last_status, others pass NULL.

Callers that previously took the lock around ice_read_flat_nvm(),
ice_read_sr_word() or ice_read_flash_module() now call them without it.
The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
dropped. ice_read_sr_word() is now a thin wrapper, so ice_read_sr_word_aq()
is folded into it.

Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
v4:
- Fold ice_read_sr_word_aq() into ice_read_sr_word() now that the latter is
  only a wrapper.
- Reduce the scope of read_aq_err in ice_devlink_nvm_snapshot() to the read
  loop.
- Fix reverse christmas tree ordering of the added read_aq_err declarations.
v3:
- Log the failure via ice_debug() when ice_acquire_nvm() fails inside
  ice_read_flat_nvm(), rather than silently aborting the read.
v2:
- Replace the save/restore of sq_last_status across ice_release_nvm(),
  which could race with a concurrent AdminQ command, with a new optional
  read_aq_err output parameter.
- Add missing "Return:" kdoc to ice_read_sr_word().
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 90 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
 4 files changed, 58 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 22b7d8e6bd9e..8c2b63eef82b 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1890,27 +1890,18 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
 	 */
 	for (i = 0; i < num_blks; i++) {
 		u32 read_sz = min_t(u32, ICE_DEVLINK_READ_BLK_SIZE, left);
-
-		status = ice_acquire_nvm(hw, ICE_RES_READ);
-		if (status) {
-			dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
-				status, hw->adminq.sq_last_status);
-			NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
-			vfree(nvm_data);
-			return -EIO;
-		}
+		enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 
 		status = ice_read_flat_nvm(hw, i * ICE_DEVLINK_READ_BLK_SIZE,
-					   &read_sz, tmp, read_shadow_ram);
+					   &read_sz, tmp, read_shadow_ram,
+					   &read_aq_err);
 		if (status) {
 			dev_dbg(dev, "ice_read_flat_nvm failed after reading %u bytes, err %d aq_err %d\n",
-				read_sz, status, hw->adminq.sq_last_status);
+				read_sz, status, read_aq_err);
 			NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM contents");
-			ice_release_nvm(hw);
 			vfree(nvm_data);
 			return -EIO;
 		}
-		ice_release_nvm(hw);
 
 		tmp += read_sz;
 		left -= read_sz;
@@ -1943,6 +1934,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 				struct netlink_ext_ack *extack,
 				u64 offset, u32 size, u8 *data)
 {
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
@@ -1966,24 +1958,14 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 		return -ERANGE;
 	}
 
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (status) {
-		dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
-			status, hw->adminq.sq_last_status);
-		NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
-		return -EIO;
-	}
-
 	status = ice_read_flat_nvm(hw, (u32)offset, &size, data,
-				   read_shadow_ram);
+				   read_shadow_ram, &read_aq_err);
 	if (status) {
 		dev_dbg(dev, "ice_read_flat_nvm failed after reading %u bytes, err %d aq_err %d\n",
-			size, status, hw->adminq.sq_last_status);
+			size, status, read_aq_err);
 		NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM contents");
-		ice_release_nvm(hw);
 		return -EIO;
 	}
-	ice_release_nvm(hw);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 49371b065845..d3cc6fef6a09 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -853,6 +853,7 @@ static int
 ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
 	       u8 *bytes)
 {
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_hw *hw = &pf->hw;
 	struct device *dev;
@@ -869,24 +870,15 @@ ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (ret) {
-		dev_err(dev, "ice_acquire_nvm failed, err %d aq_err %s\n",
-			ret, libie_aq_str(hw->adminq.sq_last_status));
-		goto out;
-	}
-
 	ret = ice_read_flat_nvm(hw, eeprom->offset, &eeprom->len, buf,
-				false);
+				false, &read_aq_err);
 	if (ret) {
 		dev_err(dev, "ice_read_flat_nvm failed, err %d aq_err %s\n",
-			ret, libie_aq_str(hw->adminq.sq_last_status));
-		goto release;
+			ret, libie_aq_str(read_aq_err));
+		goto out;
 	}
 
 	memcpy(bytes, buf, eeprom->len);
-release:
-	ice_release_nvm(hw);
 out:
 	kfree(buf);
 	return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 7e187a804dfa..21f3b615dbbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -53,17 +53,27 @@ int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
  * @length: (in) number of bytes to read; (out) number of bytes actually read
  * @data: buffer to return data in (sized to fit the specified length)
  * @read_shadow_ram: if true, read from shadow RAM instead of NVM
+ * @read_aq_err: if non-NULL, receives the AQ error status of the failing read
  *
  * Reads a portion of the NVM, as a flat memory space. This function correctly
  * breaks read requests across Shadow RAM sectors and ensures that no single
  * read request exceeds the maximum 4KB read for a single AdminQ command.
  *
+ * FW caps the read lock at a maximum of 3000ms, so a read spanning multiple
+ * 4KB sectors cannot be done under a single lock without FW reclaiming it
+ * mid-read. The NVM lock is therefore acquired and released around each AQ
+ * read, so this function must be called without the lock held.
+ *
+ * Since ice_release_nvm() issues an AQ command that overwrites
+ * hw->adminq.sq_last_status, callers that need the failing read's AQ error
+ * must use @read_aq_err rather than inspecting sq_last_status afterwards.
+ *
  * Returns a status code on failure. Note that the data pointer may be
  * partially updated if some reads succeed before a failure.
  */
 int
 ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
-		  bool read_shadow_ram)
+		  bool read_shadow_ram, enum libie_aq_err *read_aq_err)
 {
 	u32 inlen = *length;
 	u32 bytes_read = 0;
@@ -92,12 +102,30 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 
 		last_cmd = !(bytes_read + read_size < inlen);
 
+		status = ice_acquire_nvm(hw, ICE_RES_READ);
+		if (status) {
+			ice_debug(hw, ICE_DBG_NVM, "Failed to acquire NVM lock, err %d aq_err %s\n",
+				  status, libie_aq_str(hw->adminq.sq_last_status));
+			break;
+		}
+
 		status = ice_aq_read_nvm(hw, ICE_AQC_NVM_START_POINT,
 					 offset, read_size,
 					 data + bytes_read, last_cmd,
 					 read_shadow_ram, NULL);
-		if (status)
+		if (status) {
+			/* Capture the read's AQ error before ice_release_nvm()
+			 * issues its own AQ command and overwrites
+			 * sq_last_status.
+			 */
+			if (read_aq_err)
+				*read_aq_err = hw->adminq.sq_last_status;
+
+			ice_release_nvm(hw);
 			break;
+		}
+
+		ice_release_nvm(hw);
 
 		bytes_read += read_size;
 		offset += read_size;
@@ -177,14 +205,19 @@ int ice_aq_erase_nvm(struct ice_hw *hw, u16 module_typeid, struct ice_sq_cd *cd)
 }
 
 /**
- * ice_read_sr_word_aq - Reads Shadow RAM via AQ
+ * ice_read_sr_word - Reads Shadow RAM word
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
  * @data: word read from the Shadow RAM
  *
  * Reads one 16 bit word from the Shadow RAM using ice_read_flat_nvm.
+ *
+ * The NVM lock is acquired and released internally by ice_read_flat_nvm()
+ * around the FW read, so this function must be called without the lock held.
+ *
+ * Return: zero on success, or a negative error code on failure.
  */
-static int ice_read_sr_word_aq(struct ice_hw *hw, u16 offset, u16 *data)
+int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
 {
 	u32 bytes = sizeof(u16);
 	__le16 data_local;
@@ -194,7 +227,7 @@ static int ice_read_sr_word_aq(struct ice_hw *hw, u16 offset, u16 *data)
 	 * Shadow RAM sector restrictions necessary when reading from the NVM.
 	 */
 	status = ice_read_flat_nvm(hw, offset * sizeof(u16), &bytes,
-				   (__force u8 *)&data_local, true);
+				   (__force u8 *)&data_local, true, NULL);
 	if (status)
 		return status;
 
@@ -330,13 +363,8 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
 		return -EINVAL;
 	}
 
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (status)
-		return status;
-
-	status = ice_read_flat_nvm(hw, start + offset, &length, data, false);
-
-	ice_release_nvm(hw);
+	status = ice_read_flat_nvm(hw, start + offset, &length, data, false,
+				   NULL);
 
 	return status;
 }
@@ -418,27 +446,6 @@ ice_read_netlist_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset
 	return status;
 }
 
-/**
- * ice_read_sr_word - Reads Shadow RAM word and acquire NVM if necessary
- * @hw: pointer to the HW structure
- * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
- * @data: word read from the Shadow RAM
- *
- * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_word_aq.
- */
-int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
-{
-	int status;
-
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (!status) {
-		status = ice_read_sr_word_aq(hw, offset, data);
-		ice_release_nvm(hw);
-	}
-
-	return status;
-}
-
 /**
  * ice_get_pfa_module_tlv - Reads sub module TLV from NVM PFA
  * @hw: pointer to hardware structure
@@ -856,20 +863,18 @@ int ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *net
 static int ice_discover_flash_size(struct ice_hw *hw)
 {
 	u32 min_size = 0, max_size = ICE_AQC_NVM_MAX_OFFSET + 1;
-	int status;
-
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (status)
-		return status;
+	int status = 0;
 
 	while ((max_size - min_size) > 1) {
+		enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 		u32 offset = (max_size + min_size) / 2;
 		u32 len = 1;
 		u8 data;
 
-		status = ice_read_flat_nvm(hw, offset, &len, &data, false);
+		status = ice_read_flat_nvm(hw, offset, &len, &data, false,
+					   &read_aq_err);
 		if (status == -EIO &&
-		    hw->adminq.sq_last_status == LIBIE_AQ_RC_EINVAL) {
+		    read_aq_err == LIBIE_AQ_RC_EINVAL) {
 			ice_debug(hw, ICE_DBG_NVM, "%s: New upper bound of %u bytes\n",
 				  __func__, offset);
 			status = 0;
@@ -880,7 +885,7 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 			min_size = offset;
 		} else {
 			/* an unexpected error occurred */
-			goto err_read_flat_nvm;
+			return status;
 		}
 	}
 
@@ -888,9 +893,6 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 
 	hw->flash.flash_size = max_size;
 
-err_read_flat_nvm:
-	ice_release_nvm(hw);
-
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
index 63cdc6bdac58..e1d1a11f5ca4 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.h
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
@@ -19,7 +19,7 @@ int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
 		    bool read_shadow_ram, struct ice_sq_cd *cd);
 int
 ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
-		  bool read_shadow_ram);
+		  bool read_shadow_ram, enum libie_aq_err *read_aq_err);
 int
 ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		       u16 module_type);
-- 
2.34.1


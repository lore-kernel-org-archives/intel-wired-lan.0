Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415DCC44520
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Jul 2026 12:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC7174093B;
	Fri, 17 Jul 2026 12:12:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 15sS0xpDSnuJ; Fri, 17 Jul 2026 12:12:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DAA2D4094A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784290363;
	bh=GBrdyPkwul5YJYP1uT72mZnAeocwxHHV9yqEnrWzVTs=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=GHQfyLdFEIpNKzPPv/VTPUffleXcomAPf/ro1jcLo1ue9EyVFx8ebLqAH3gLVvB/O
	 f5rPw4oGwpPXW4U2za1dyL9uhaHB9Yt3MeyjnvWGaIjWRraBoHAClq02ZGUcc6SP0p
	 LsFRdEBCVWsboGvV/SSDyqB1obnj3wf8uHoS/vECGV7156htfHfXNfoNpY2V8FxLqy
	 g2uNjzUWGU1vo8dPDUva3kSMIOI7QZg2rSSOnovTgRn7/2T/zCdGS/xbcFi41htdsG
	 FT/PCBVqtY8KKsxFRoACqhaAPAj/n+mTi/XE7SXXqG7IBNFbv0FBEXxDE+AhJ68ik4
	 mOvDd5rnIeYmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAA2D4094A;
	Fri, 17 Jul 2026 12:12:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 548C9320
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 12:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4668E60855
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 12:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id viY_DWrpdWTV for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Jul 2026 12:12:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=robert.malz@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B138460ABD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B138460ABD
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B138460ABD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 12:12:39 +0000 (UTC)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A059A3FBCC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 12:12:36 +0000 (UTC)
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c15fff01a30so385392466b.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 05:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290356; x=1784895156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GBrdyPkwul5YJYP1uT72mZnAeocwxHHV9yqEnrWzVTs=;
 b=qTHzUDla4cL0jqxPqUET+xn/CdbNAX84Gh8HKdtYMcIhjvX8I7M+vqCuHNbqh2C9la
 UC1YeCLJCaa1kTiDl50HE/0kIxVfOU0d5x5hWKYVN7uEhKweZ4idCv5ZClpG73ZmyOqo
 B6iwhhIQ2L3yvWt1YvLljDTzlYRctN4Q/yfwvz+orj+7tqr/rErAfSiM9BG3FLANElOQ
 H9ScNUo2+KHH711FxtDLXnHnmv/DP8MAG2Ib3kDkaIhZnHiGckrqodD9k89viYYnEpIF
 QJU9iFfKOkoC+LcgjFjBIQcQ48hID+68pYVhiiFwdmC3/TVxTioZwbYPmGGH4px3DRYm
 sFGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDjPjhEZgOw1JeEaEj9itzCp/RS5dXkM2vIY49bF5bDk2xOGS8V+wTathPwq/idJUmCV8hQ3ybtWOY1QcBzlk=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyTyDwIgj3T/xzoVDpolwB6mbYgAe91VN8BBOlxHRlWMlbjU8Ir
 b/TeZvO1D1dwFPlkVC1GB4doePx3/rxWqIlAoQXoHHBJZpgHBHVrVgcU8utsMqhBF5hoQIxkyeu
 S2ojBMwRFu85LU6PRFElWaC8kSDr+8isa7pj/I1m+b6C3wG6j4Np9yp9yWYw/KWtWpavEZMh1gU
 Irk8jRd5Cf7eQ=
X-Gm-Gg: AfdE7cmeLbp/Hmp77f4Pn9TXZ9gJhE6YYo1RFzv9ufOoShQJOsnnME+dhCBVP4F8KWt
 YKPC8ZCMgDtJ7XfswLcnGm6+K/oMu3826ljFBfLPAF/3M1H/zsBSPRvgHfgET8ptDJV0GH+mRS5
 rItGI+gphpeFWniL6XNPdJocnkDb3/UNezgUChB25n+cPwrr8UK9wTD0H9bkH8FkitsNFL9Nm13
 hxxNqGFefqH70Jfkjk5En8YPOHwOiYbxIaLiu+qMNh1pVaXbSqvxTuKsJa/e7pDlO23187Qz0ob
 Hg2D2MqMQBkSCdI9/yrV6x8LmEBQeHFbM01cHPDfgr1Hb+RZ1xq+g8m22/JoWiSzpziRBwIdKLl
 FIg==
X-Received: by 2002:a17:907:944a:b0:c12:e178:9e68 with SMTP id
 a640c23a62f3a-c16b470c47amr101221366b.19.1784290355560; 
 Fri, 17 Jul 2026 05:12:35 -0700 (PDT)
X-Received: by 2002:a17:907:944a:b0:c12:e178:9e68 with SMTP id
 a640c23a62f3a-c16b470c47amr101218466b.19.1784290354880; 
 Fri, 17 Jul 2026 05:12:34 -0700 (PDT)
Received: from rmalz.. ([194.182.29.251]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6fef2477sm595249a12.7.2026.07.17.05.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:12:34 -0700 (PDT)
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>
Cc: Robert Malz <robert.malz@canonical.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 17 Jul 2026 14:12:23 +0200
Message-Id: <20260717121224.3908963-1-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784290356;
 bh=GBrdyPkwul5YJYP1uT72mZnAeocwxHHV9yqEnrWzVTs=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=gZr2ebKqfEpq2Se21ttZHYJKC65HO6rSr7vNsliXdApj1YxDJW5yEyh58EDSqlTAI
 Se5BrdJOlMXB2diQcMlBgs/WRzCqMVS5i2i8Ej1xOj6Qw7ESI6KUI3lFfFxzb9qe+o
 Byr728O9ATp0NZKzjb5ZI0vgLMJORP3XswswAA8845eNAyNsXjrhfjp6ZIoQl9YBY8
 Krv32HznUn2NR6eq7vbceoPXQ39hYOY4nu9XV9EfxlwIGVJ5scpM/xfE33TQJ2Ghxm
 DryJ/Zl3531UazrxUObUj+2TERem+KkwqDOZW5bePAwlv6dSxryRx4Nqlb9vdm746V
 /RluqvlLgm+GXpm3T8npNH/8fGN6nvqX+R4Wlb2nwAOxDYueIhMjKQkKkPBZ4PYovX
 5QiVLM03XovgAYZDNr9S3bjCRhRNqcnroyBbfuvMs0Lsnd17J3cL4pXSXzCCcj8LWU
 C9fHtwhXMevNmo5M6lZOOMwUhSHt3EMLK1wK8Ld7QqXYI1SzZKIEAn61J4lae0dj7a
 46gqlN8g/X2oYyDcPSIEAapFGWNx6BJlFnERgIEjFxMF5UDVXB7iii8kLxnRMQzk8a
 opcXpr6i6a+7iqYdPQg9LvF0V6t9R7GwhXhMxMu4XJ7r/zDC9XDX+cwlTZetK6anGD
 4SM/U0uvGbgfcRf+sT0EmsfU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=gZr2ebKq
Subject: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around each
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
dropped.

Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
v2:
- Replace the save/restore of sq_last_status across ice_release_nvm(),
  which could race with a concurrent AdminQ command, with a new optional
  read_aq_err output parameter.
- Add missing "Return:" kdoc to ice_read_sr_word().
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 76 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
 4 files changed, 56 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 22b7d8e6bd9e..5a1ab9654fb8 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct device *dev = ice_pf_to_dev(pf);
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_hw *hw = &pf->hw;
 	bool read_shadow_ram;
 	u8 *nvm_data, *tmp, i;
@@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
 	for (i = 0; i < num_blks; i++) {
 		u32 read_sz = min_t(u32, ICE_DEVLINK_READ_BLK_SIZE, left);
 
-		status = ice_acquire_nvm(hw, ICE_RES_READ);
-		if (status) {
-			dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
-				status, hw->adminq.sq_last_status);
-			NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
-			vfree(nvm_data);
-			return -EIO;
-		}
-
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
@@ -1945,6 +1936,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct device *dev = ice_pf_to_dev(pf);
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_hw *hw = &pf->hw;
 	bool read_shadow_ram;
 	u64 nvm_size;
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
index 49371b065845..ce5f5fbaea69 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -854,6 +854,7 @@ ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
 	       u8 *bytes)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_hw *hw = &pf->hw;
 	struct device *dev;
 	int ret;
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
index 7e187a804dfa..5b7373a1c06d 100644
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
@@ -92,12 +102,27 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 
 		last_cmd = !(bytes_read + read_size < inlen);
 
+		status = ice_acquire_nvm(hw, ICE_RES_READ);
+		if (status)
+			break;
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
@@ -194,7 +219,7 @@ static int ice_read_sr_word_aq(struct ice_hw *hw, u16 offset, u16 *data)
 	 * Shadow RAM sector restrictions necessary when reading from the NVM.
 	 */
 	status = ice_read_flat_nvm(hw, offset * sizeof(u16), &bytes,
-				   (__force u8 *)&data_local, true);
+				   (__force u8 *)&data_local, true, NULL);
 	if (status)
 		return status;
 
@@ -330,13 +355,8 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
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
@@ -419,24 +439,21 @@ ice_read_netlist_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset
 }
 
 /**
- * ice_read_sr_word - Reads Shadow RAM word and acquire NVM if necessary
+ * ice_read_sr_word - Reads Shadow RAM word
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
  * @data: word read from the Shadow RAM
  *
- * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_word_aq.
+ * Reads one 16 bit word from the Shadow RAM using ice_read_sr_word_aq.
+ *
+ * The NVM lock is acquired and released internally by ice_read_flat_nvm()
+ * around the FW read, so this function must be called without the lock held.
+ *
+ * Return: zero on success, or a negative error code on failure.
  */
 int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
 {
-	int status;
-
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (!status) {
-		status = ice_read_sr_word_aq(hw, offset, data);
-		ice_release_nvm(hw);
-	}
-
-	return status;
+	return ice_read_sr_word_aq(hw, offset, data);
 }
 
 /**
@@ -856,20 +873,18 @@ int ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *net
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
 		u32 offset = (max_size + min_size) / 2;
+		enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
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
@@ -880,7 +895,7 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 			min_size = offset;
 		} else {
 			/* an unexpected error occurred */
-			goto err_read_flat_nvm;
+			return status;
 		}
 	}
 
@@ -888,9 +903,6 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 
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


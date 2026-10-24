Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267CC606A31B
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fDZcKAsz;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=flAEHZxc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2A81408E8;
	Sat, 24 Oct 2026 16:37:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gMxEAROgDig; Sat, 24 Oct 2026 16:37:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2488408D3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792859832;
	b=PvF7uCpOGZH4TEF+Qt8l237584BtxVGmoaN5XorSaRQcxEG3v0cx8twH1zCR2Q48d2md
	 lx9Hzqk8utUj7qhH+YYOKY9cBoYnhEULMehi9b5Sgeo8CD28bqm4/K+vNkHGO560FKlkq
	 Kw9XeFxUTogDauRXeFmN65HS600gx5w8wzUiZKnEXVCCDW/ANu2vQphUOHaOvZIrUlkmD
	 7/esiqZebNUJTtOSrn6Ge9fGr9doqKd2im5LGfaJyP53YinpKY1gWRqUZ2qn60yJ9V3Tu
	 7kJ9L2E9AQ3IMprXOk3OZ22ciVcTFsNKifnpkxD6Lnr4q4bUjiUy8n93GSWzgCpyFIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792859832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9hI96XsZatd2IyoCczE5AUX5n1Tyz2vidQ0WEIeQnIs=;
	b=itr7I2DrCaq4nIONjQD3q3dt2Nf6zuaNd3IQLPf3pjKTcWnzS/YVimlhCUhtZpgGWNMP
	 2Gqx6Uka93Yf1v6uLEywafQcMxNx9FjlMqNaN4mblWRzwQCeHuUls0dmcfi0m0S6LmY2N
	 vZcFZKkU/+MywTrfljkPjrgh0M2Xms0cDXFVc9ifEh7KIQI1iJE3IuRkvTdcHEWmkDDEm
	 S3EQY6RRqpspicem/otCGX7MJlwVa//yeXUNUfJMF940n4K4pFtBr4c/opHTgHS85aIde
	 sO7g44cCftBSJSdJ6vSsjX4m40cnyUuDiBh5zkibkExzPrW7Ae0ODpDIJ3geeOWOdGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792859832;
	bh=9hI96XsZatd2IyoCczE5AUX5n1Tyz2vidQ0WEIeQnIs=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fDZcKAsz98u3xeHexERXpYnQ+BgomUPYM2Dti2ffLaKylOZIYFbgBA7Rx+LBbK4X4
	 JAqgBhD6xCHPUPk3hdmPN7JdwEyYSlgYMWujIbCXL8veNFGIXPYFbpxBOLw9o29CT8
	 DKxF/r6kz9RVre5C2IOGZGTaPHp3SWrjvYmXOmmU/mZwZC98Zz1VV16FUdULDWhGYU
	 tyhgLH5yEsFgwVum9jjXZUkusO3po3HYm3sh2kxjb/PBpbP17LLm1xwgz5AL+OPNwP
	 0kAmjW0IKX7Gc7hWIEv9aWc1CguX5vXEHQPzCnvgwwDL+LBdmuD3hzD7HEdk+1dX3C
	 3Zf2LM/0S/Jqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2488408D3;
	Sat, 24 Oct 2026 16:37:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 19EE34D1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 16:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0056A4006B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 16:37:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dvEtnM49aSta for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 16:37:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D8FA140049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792859830;
 b=Zc4q3pgKQOXwOFrpIpM6ZwJEesiKmSdwIWg1JsH4la+PC0OgsOtb4Xqpu2SgrwbQu+iQ
 SNXI1/XnhwIf5Y/Wg8cVSfZYSIWUhj7dO3z5R8rgxpD1eMjeUtINKkSYKOU3aoV08o35h
 X+iUIGGnAZrD0aCTXB+r6wnHZ+2yit/EZMtMCQnV+JG1qfaaSwXPclpoy055Ql9a37wO3
 ne0Md4xL97A5dba3J+ppw66GAB3vNnAAprTGyUm2J4h3CVMAca+9zRGcNJy6Wg+mH/ZAI
 /j3Bh8U/O2/VUmo+35i84w0O4MmJRnuXmxl49Az+rM7EXW0OzMNUj16ZCDew8SFCEXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792859830;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=9hI96XsZatd2IyoCczE5AUX5n1Tyz2vidQ0WEIeQnIs=;
 b=cI5/Mlo9TfaJrRHD51h13e3UgLJHBTK8Ye7DDuxfVIE07uhOrI/m1+iXqNNvWR58Sha6
 rN7ijqtCPrxU5KfEw873oME35agi4FjfMSpICICei/27bdLc8nqp+nYsOWlBJJ/5fGCEA
 Uli+wXw6+v9JhVBvAoma9a2NFVVXD0W82hSGDClqP757rMdxrbNvBdLe5qfmMxjHeEru0
 W8IxgWLiZJ2EKLBJT23BbdYAojs9sGrGVmxvs5cWAgYHSIgxYTJdKTNX6FaogfeXbqq1P
 3PYja4HRnCfDD9DmVg4VoDrJrne/I12h7oVdbUnEPFpMfLsljqeknzrf+uR2T0Ae0rQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=flAEHZxc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=flAEHZxc
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8FA140049
 for <intel-wired-lan@osuosl.org>; Sat, 24 Oct 2026 16:37:07 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1141159f8f.2
 for <intel-wired-lan@osuosl.org>; Sat, 24 Oct 2026 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792859825; x=1793464625; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9hI96XsZatd2IyoCczE5AUX5n1Tyz2vidQ0WEIeQnIs=;
 b=flAEHZxcbvAe346Dof7SybVKoxd8TLKueLROBJgdXz6eoDk/yexcXA19bgwIWcp25o
 qZER5UP5TBsiSIzx4n+B6e3nTE5YD2/MSkTEfqzb4suCIUVw6kzpc9iggf2o/y3Hwm0C
 /4UZhzKb9BdRyIUL9ioukC8/8e3TtIA2qtEIQU8HTeaVkiIyy/f/BbbbFKepjLnGAMXB
 R9xub/RzjunwzoSC1guqiKX+7PMnwZK8BA5d2HlDS6qTcsxvEsJjzDBMOxSXJ7o4Gh7v
 YCkiCsVM83UMPt5YeJBSyseMQm9PQG5cig6nektFKfLs+jPvAA/RS4BklEo9DYb2GYu8
 OrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859825; x=1793464625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9hI96XsZatd2IyoCczE5AUX5n1Tyz2vidQ0WEIeQnIs=;
 b=gjQ+769DTEAmLa/qDRN1XD638k65BhPD08ykhP3ZJj+NGTrgg2hBQjBASEV1fzQk9Y
 Q5bFHTIIc3MZDfbqqBVHvLVWdGQHavAYVMJJeBXjgsRY/jbkILyyDnafpyw2JcadYXEy
 heyTJDZc6yeChiV6mH2X/6pZCE0E4juYSzySXssZLcAWQMUCV84F7m6CPWV8pxm2cqG2
 Fh/tqZ+3zIwDw7sm93w9Ocz/2u4hlZoBBxRf+V/qR79t62rHPGKUFs00xHgzkPwVGM3U
 mBL3/Ic2PQCgXMCcl/Dpsuch8ZOtky7ovXxu9wH+U6r33wRHv4WKL+aw8l+XN+nluKoq
 5BxQ==
X-Gm-Message-State: AFq9FYJ78F1VP9nRdkEsDlz3eWyEFfjCfP4nxwoDMNTyqJpx7s91NN00
 mpd18pjQE8wSBakVLUEQDtzOqdmQn/SL621h3zlomQuUj7X+K05n1If1DkgaBg==
X-Gm-Gg: AYBFou10WSRgklZGeqc8dOiFpCEA0xBR/7RY2LRKcB24J5tgT3sPZPdJSKENlG8TxSD
 a2X0wjLng5dsVRVzuZYD+yiY+iEhQZff0cmauNKoASHGUVPzLPqJ7G+KwarTR4KijNg44yW/K04
 uNodJVIXSRVIh2hmpHEauF+PmKd0ytfR/bQxgjC74nhlZAOS3JBHAsUQrz57pVzJI17Xl4uDm5t
 UhTkLtPFWG/FLnthgFd4EnepHSQFr+bFDvu+ks/cViz+zc3sjRyYR1ZTp85WJ8+hNmmmpbNUdLW
 SYgIhPnwAaZ4q/zWVhzC2aVKwDADX9vy7hSXJt1JHbneHuncbhQQoJ0fam0IRVvjRzIpyax3edr
 BJefuUEsBLp8lmgwCxf5MxtA4fEszomZFf0bo7AEK4TzaS48G3+r6rairACrAtolX2SFUrNHjsG
 K9Bm4QxKRbodVRkKqUcc+9Q4MA11WNaaArwZZBvp5GjL39obfvvsmAxNcc1b/bmFREl95ky//Cw
 /qcwQMXW+Hdbe/ih7VHBba2ySc3zkF5URloAV9qg0SCRTfW1IVFe4uiHUiTRgZ4LXV98573NGbq
 LIxgeWcve9iTocJ7sE5dgVNlDc/QuOq5Yh7scJPXOac=
X-Received: by 2002:a05:6000:4285:b0:48e:bf0:352 with SMTP id
 ffacd0b85a97d-48e3eb4676cmr4690580f8f.5.1792859825333; 
 Sat, 24 Oct 2026 09:37:05 -0700 (PDT)
Received: from sashaneftin-pc-GB-BSi5-1135G7.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecde7easm5108880f8f.52.2026.10.24.09.37.02
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:37:02 -0700 (PDT)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@osuosl.org
Subject: [iwl-next, v1] igc: remove unused igc_update_nvm_checksum()
Date: Sat, 24 Oct 2026 19:37:01 +0300
Message-ID: <20261024163701.134489-1-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igc_update_nvm_checksum() has no callers in the tree. The i225 NVM
operations use their own implementation, igc_update_nvm_checksum_i225(),
which is what nvm->ops.update points to in igc_init_nvm_params_i225().

Remove the dead generic function and its prototype from igc_nvm.h.
While at it, add the include guard name as a comment to the closing #endif
in igc_nvm.h.

No functional change.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_i225.c |  4 +--
 drivers/net/ethernet/intel/igc/igc_nvm.c  | 31 -----------------------
 drivers/net/ethernet/intel/igc/igc_nvm.h  |  3 +--
 3 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 5226d10cc95b..0971debca3a4 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -220,7 +220,7 @@ static s32 igc_read_nvm_srrd_i225(struct igc_hw *hw, u16 offset, u16 words,
  *
  * Writes data to Shadow Ram at offset using EEWR register.
  *
- * If igc_update_nvm_checksum is not called after this function , the
+ * If igc_update_nvm_checksum_i225 is not called after this function , the
  * Shadow Ram will most likely contain an invalid checksum.
  */
 static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
@@ -275,7 +275,7 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
  *
  * Writes data to Shadow RAM at offset using EEWR register.
  *
- * If igc_update_nvm_checksum is not called after this function , the
+ * If igc_update_nvm_checksum_i225 is not called after this function , the
  * data will not be committed to FLASH and also Shadow RAM will most likely
  * contain an invalid checksum.
  *
diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
index a47b8d39238c..b69889bfeb42 100644
--- a/drivers/net/ethernet/intel/igc/igc_nvm.c
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
@@ -132,34 +132,3 @@ s32 igc_validate_nvm_checksum(struct igc_hw *hw)
 out:
 	return ret_val;
 }
-
-/**
- * igc_update_nvm_checksum - Update EEPROM checksum
- * @hw: pointer to the HW structure
- *
- * Updates the EEPROM checksum by reading/adding each word of the EEPROM
- * up to the checksum.  Then calculates the EEPROM checksum and writes the
- * value to the EEPROM.
- */
-s32 igc_update_nvm_checksum(struct igc_hw *hw)
-{
-	u16 checksum = 0;
-	u16 i, nvm_data;
-	s32  ret_val;
-
-	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
-		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
-		if (ret_val) {
-			hw_dbg("NVM Read Error while updating checksum.\n");
-			goto out;
-		}
-		checksum += nvm_data;
-	}
-	checksum = NVM_SUM - checksum;
-	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
-	if (ret_val)
-		hw_dbg("NVM Write Error while updating checksum.\n");
-
-out:
-	return ret_val;
-}
diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.h b/drivers/net/ethernet/intel/igc/igc_nvm.h
index ab78d0c64547..d5f1f1a449eb 100644
--- a/drivers/net/ethernet/intel/igc/igc_nvm.h
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.h
@@ -7,6 +7,5 @@
 s32 igc_read_mac_addr(struct igc_hw *hw);
 s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
 s32 igc_validate_nvm_checksum(struct igc_hw *hw);
-s32 igc_update_nvm_checksum(struct igc_hw *hw);
 
-#endif
+#endif /* _IGC_NVM_H_ */
-- 
2.53.0


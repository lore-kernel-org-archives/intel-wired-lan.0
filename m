Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D393C982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 09:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3085A40768;
	Tue, 22 Sep 2026 09:12:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RmwdQOK0kUkx; Tue, 22 Sep 2026 09:12:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 83A9540813
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790068322;
	b=MZ4b17KlV3+BjuwIu7y/Ew09HZMZDrJncLsajr8s14rvzbE4q+xPLb/nonpWGdHHH8cw
	 V9WCzQxKiC1bFDHulutfCQklv9CC7QAx76TejH8dgb0S9bjotHV11fPD1X5Wf5hf33GK1
	 sKi1ezYZOx5Ej2l/Ct4Al+yqkLMPwTfwso32rN2SKOxF8CL3s+Yl03sr1naQVasuGwiAE
	 ZQoO/gVWu+80QP81mcm86aX3E+Y20ONrdaGwGDq/OcTh7s7yTVuDYcHy3oP9OhEwshUeT
	 qudEUAxZhlpqKr9Co2kp6F5OwC7WwPSZTfg7PHBuQ2wG6j5dEQCQUiOHbZ1HYK2o0NQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790068322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JZB0Slkp1cTB3zAnWSwmos8fcy3POuFLh4py+bqB5yk=;
	b=sNOFn+CHtn9EobnRhEFYitFk1gn4NRnRZ8T5G+GBgPX3tmyEo1KFKnlwiG6ytjpOseoM
	 cBHc3mTaodjz9EI52rc6R78c8Qui13ZkMOCm6wdpJWzCRk1o4Oi4U5J1HNylyyYEE9/91
	 bWbOnJAHwco1W1VCbUg0xiIZoJFidj5w6IpG4VfGWS7kBRMyZEN1xzCwxNmbur2hXmCsy
	 mEUJEnswgC0fiCfQ3fL9s6FzYkNrndcrCD78ZyiiTvutWgcIeOv0elpBQBTXcvcnPVUQG
	 MajlEQ8sUq+nzrIeo3bSnZTkWHhxbBF6+ia5GJlogvwK+TKoKyHKzekWu1bROSYs4eg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=eT14op8Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790068322;
	bh=JZB0Slkp1cTB3zAnWSwmos8fcy3POuFLh4py+bqB5yk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s6SUO7YOzc7WnTPHnJ1hNHkaSM0z2zz+ZGUMczFWrMlXQAhP8iu8gMlpUqTkEglAN
	 e1OGrz/E+SZ8/poeh886l3ytQCdTRyagX9Qnb80stbED07bqMlxPNRZXUogG8K/WtM
	 OT5OnDjqwD707yIM/bDyfcHp3sdAE0wHGkQ5VY2cnossmLHk0QIfG1L/B3oVTTotzy
	 uATo/+NvdVy6UfCh4IUii5Gmg/AAwXDcHD/QmBODHUbyf2gvT4oq2JMc+KUI40kvCY
	 Q6mctVCIO0rDIVizs9C99oI+cbRUoBfqdyLNUbu1TmF4wryJshaO65tMBspCaZpDR/
	 nl30zZNkeMT+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83A9540813;
	Tue, 22 Sep 2026 09:12:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D412B3A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 09:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C60A640813
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 09:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GEUZxokOlKHY for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 09:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 349FE40768
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790068321;
 b=Jr8HnF/LV0tSFTcfsZbCgSOFXunPKqoHRGIoKrnL+9+HyF9pYsWrk41+j8P2TKfRW3I6
 Ou8cMBPY8qEn2pdstjLaSoen5iD39/WZRYszqEPB14GMdijpJiMoksmLefbHNfnEK1J+4
 H1YnYEbuaZRXCNh2+GujqInIb1DahbIC8YvK03twKwL5VprA9B6YHw2/3VwG3YJ9pq5tf
 iyi3fV/o70s748zqk8giNlV4+R8JKoLYVK+jQSHplBYrnZlCwtX341iYbjXdrlv9rTf2k
 XcujL9MNvXtKNf7k+J4EM5kL0+Yg99y1w2NrZAhm6+GaGYfbbffDSvBkiSihjcGAf1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790068321;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=JZB0Slkp1cTB3zAnWSwmos8fcy3POuFLh4py+bqB5yk=;
 b=Imp1ye2pC4nTm9w+ei32Yiq9wZ4x6T5T0xUQyoLbp7iiVG+Fy3xSF4J5M7FtP2k7jybh
 OymDBR0sjA7KE7OU8fNzJKp9Zp1VKS43/gBIMpx9uBRZIBiBwfLadhfZoWQKkv0GpLmCp
 uFCDCHx6IVqieSv4xJejAz6WxWNWZq+YkIkkCZorZHp9Oe+IS4AiVJ/763L3hUxIRfWCP
 W8GWyCrMYTJrSSACspxGE0JVRiO6o/hgLKlj0j1U4kHhQqtd8uMZRx+4nIeBAvYbHGquB
 H+qJoMj5Ej+0gT2WkAzmT4/0FYN6gQjJlXZbGg/lEkAXHDbtnPHKJCtz/AIDgmtNsYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=eT14op8Z; 
 arc=none smtp.remote-ip=117.135.210.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=eT14op8Z
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 349FE40768
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JZ
 B0Slkp1cTB3zAnWSwmos8fcy3POuFLh4py+bqB5yk=; b=eT14op8ZJEjCwld797
 9NeAezOI4tg/JlPsp4eTU74QEi8ZGnglumaAZ9qg4QvlMEXKBCcn5qhzDn+08rwE
 lrnz6dJFjcphyWHnfF8YK7bysyiIofF4sAArEWhHqoriZS+D8pMySqT0Ij9IKrJ7
 9ERRHZEgTrofJv37soEks7LkI=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3HzY9RrJq0uQVAA--.17646S2; 
 Tue, 22 Sep 2026 17:11:25 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net v3] i40e: limit the DDP profile count returned by the
 firmware
Date: Tue, 22 Sep 2026 17:11:23 +0800
Message-Id: <20260922091123.506598-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3HzY9RrJq0uQVAA--.17646S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4UWw1Utw18JF1DKw4xtFb_yoWrXr4fpF
 W5JFWDGryDJa1j93yUGFW7uFyfu3WfAryYga4a93s8urn8tF4kWa48tFWFkFy7ZrWvkr90
 qFs5Cry8CF4DJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul-ewUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlB3nvmqyRj0E1QAA3i
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

From: Linkui Xiao <xiaolinkui@kylinos.cn>

i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer, which
is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries plus the
4 byte p_count header. i40e_ddp_does_profile_exist() and
i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
without bounding it, so a firmware reporting more than 16 profiles makes
both helpers walk past the end of the on-stack buff[] and compare against
whatever happens to follow it on the stack.

The same buffer is handed to the firmware as an indirect admin queue
buffer, and the admin queue code copies all of it into the DMA bounce
buffer before submitting the command, so its uninitialized contents were
visible to the device as well.

Zero initialize buff[] and reject the list when the firmware reports more
profiles than the buffer can hold, instead of answering from a list that
was only partially read. Both helpers already report errors to
i40e_ddp_load(), which aborts the operation.

Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v3:
- Zero initialize buff[] in both helpers: the whole buffer is copied into
  the admin queue DMA bounce buffer and copied back afterwards, so its
  contents were exposed to the device, and entries the firmware never
  wrote were compared against. (Sashiko AI review)
- Reject the list when the firmware reports more profiles than buff[] can
  hold, instead of silently clamping the scan and then answering from a
  list that was only partially read. (Sashiko AI review)
- Dropped the Reviewed-by tag, as the code changed after the review.

 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index daa9f2c42f70..49a98c0e001a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -53,9 +53,9 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 				       struct i40e_profile_info *pinfo)
 {
 	struct i40e_ddp_profile_list *profile_list;
-	u8 buff[I40E_PROFILE_LIST_SIZE];
+	u8 buff[I40E_PROFILE_LIST_SIZE] = {};
 	int status;
-	int i;
+	u32 i;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
 				      NULL);
@@ -63,6 +63,13 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 		return -1;
 
 	profile_list = (struct i40e_ddp_profile_list *)buff;
+	/* The firmware is not required to report a profile count that fits
+	 * into the buffer we gave it; refuse to read such a list instead of
+	 * walking past the end of buff[].
+	 */
+	if (profile_list->p_count > I40E_MAX_PROFILE_NUM)
+		return -EIO;
+
 	for (i = 0; i < profile_list->p_count; i++) {
 		if (i40e_ddp_profiles_eq(pinfo, &profile_list->p_info[i]))
 			return 1;
@@ -108,9 +115,9 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 					 struct i40e_profile_info *pinfo)
 {
 	struct i40e_ddp_profile_list *profile_list;
-	u8 buff[I40E_PROFILE_LIST_SIZE];
+	u8 buff[I40E_PROFILE_LIST_SIZE] = {};
 	int status;
-	int i;
+	u32 i;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
 				      NULL);
@@ -118,6 +125,13 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 		return -EIO;
 
 	profile_list = (struct i40e_ddp_profile_list *)buff;
+	/* The firmware is not required to report a profile count that fits
+	 * into the buffer we gave it; refuse to read such a list instead of
+	 * walking past the end of buff[].
+	 */
+	if (profile_list->p_count > I40E_MAX_PROFILE_NUM)
+		return -EIO;
+
 	for (i = 0; i < profile_list->p_count; i++) {
 		if (i40e_ddp_profiles_overlap(pinfo,
 					      &profile_list->p_info[i]))
-- 
2.25.1


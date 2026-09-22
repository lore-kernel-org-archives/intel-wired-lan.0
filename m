Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BD9C982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 15:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E966402A6;
	Tue, 22 Sep 2026 15:52:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4eOa941bafZ; Tue, 22 Sep 2026 15:52:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8D0A040387
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790092362;
	b=fsre/T2vQtyq/hfgfzsz7uWEUpOm9+Ko2pvorhcf0W1Pl2NaBUdCZypISmnsZmMF4Rh0
	 ZUJzQBZlQ1oRHla6dAL3GffmOsofpS8obMVUIwh2D6FdI+WuYDeAvFpHLnGx/srQeNleD
	 7s3FO7RT0Jeng8mMb9IZFlZyrY4nNVRDWWH/CgmxQMl8j2mGT3dmDMUIPEkhgAc94Ke4b
	 jbmtxVk8GBATkfa8Rn3/+wam+P1eovGcjz0vVnr4PCvFjASEXzo2/gfj9i4+u7fEd+mWv
	 BQgDUpLEP0ZhD3egPX1/AqDolxKGkTQ/5RbLUtK7gkJBPzOK9oLbFfx2wvW2T8EGBUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790092362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
	b=HcFJPQjJNau6ZRf2uR1zlu6mws8v0AK5Lyhd/GiCK8PIHPkB0ouTUD9vvAvhzNKPniEC
	 D3JgfJkkOu7ogs720SgLjqKg5iPBGf+52ihbAKJADyx1qdpviPbiQfd85IlWDA5Z1wjcv
	 XZ3srm5xQifEUsc3Zjcxs+RFXLaxfuOA4qiojU81NuKJ8EU8Ogp9+AU7XJQd+HRDGXOe6
	 +mVv02FrSX+sh5K2oaPQyl6Qb4PQERdiqC9MaedOLek5gBDT5LA+0dqb9N8ee9pK4NqqO
	 z8mR0cnJAsabrsG43xTc4+QIX9eBX1hFy0LoC0zfxYehI1OyBhU83AwlRWw5QuX8JUg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790092362;
	bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HmdmmmKXOGai5IbMRWGazFg8fYjKi8hqYVFkqQsLk83ECb+zIOfTOQXUG7YWg0rNx
	 xvRFWG3nKMa6GiQA1bWdsbTr/jOvt65+DVV2ZbQO6naKhxje7zegbW+UcQnGZiqYG3
	 BidisdgfCibDZf3ypgDHY3U31hUwOE/bQEIh6Jf6PX+646taoeNdsN+mlkySMcHSqu
	 pIVTMFmO82hogIVolwO944NEoJ10ZJMY0v8l/BBsTtqlZVFkufGeygZlnJ+fY6eqc1
	 8/V4JVOgn2HxFc+NIs/GQCVaAnQWLdqCHfJ2xER73j/ObgQSggVyBy2exvr0BmidEa
	 /Bv29ecpBpSOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D0A040387;
	Tue, 22 Sep 2026 15:52:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 208FE12C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 15:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1251C80DA1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 15:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUupevuu2ykG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 15:52:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 27704809F5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790092360;
 b=KQGmcZmTdPuPN+yKOOW0CuEjuIfGg7GBZB1ZZ+qS61YxM21Crb9Baa1xhs1EBWEoG2Rh
 jhYrqbc/wMDi4n23WJcSK8Nu4mRmlJd4BE8ROHy6Phw8/WsMbkkwBocBs/f+mdqqNxsoq
 xJsS+OQJgR0uDGrFA/bH6izIDwvLzDC1LbbrVx/LNHmYFRT7z/L5ep66pBPhSCjQIT6A2
 28yU+DWXX9If5DJuchvFY0FzqpSWbPaCNvtrCtdglQD2b78sK9gUx9QZ/K/a2AhmL3Z81
 noTLuUASFcAOOtWIp0WxW/rUNY1sxlGGldsiubR4mV1ZBZhmRZ+yOvfr3rW7a21N73A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790092360;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
 b=o21eITpZ2MjUCGIjrWylLuqbshivs/5vlN6IgFay5jBsXtQZBxJjjO0uzEy6oh/4NVW3
 81fHCbhwTHnXvbWksZYcwM14Ngr5yXmRnzexOPdQ0NwE4TQA7Mc8bz5LW/BL55f0kJBi+
 C3qgpJaKhEv47B9WCKodPZdMbNzkSiL6fybkCpzi/c/12U6QufVVtZomvSqlgu/MeWkmm
 shT0LO6u28hfM3zIx9547SUXFOB/u14AXIm163Yjp2IbTmygnHtgJu4Bvei0t/vFkQ44y
 7YBquniv2yhPG+/gBzN7YLH4//hTZPit+P+rV4W9X1wiXxc0KaY1guTHlh2nkytwaBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="gU5b3/P+"; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=nsvatoslav515@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gU5b3/P+
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27704809F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 15:52:39 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a8038a9f10so6261499a12.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790092358; x=1790697158; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
 b=gU5b3/P+8AThwPJtKnlWJKpn85/ANgvq+6ZjU7fBkVtN/QXEEaT0Co0fxMdE+Izz0T
 9c67uJ0um/3IQSB+v3hcANkR1Tsoufp/iL2HNCdCpAVkHZ3hUth688E+cwWWaSRRpKGS
 LRQaYmpfcnb22YcL5jfSB2G8hpyxbQ+jbW1EldRUS64xNY1fZnMPZIw/OAVOK/U9Gtjj
 fTIAoAAkGndBY2ixdG8Z3NOBomjzWmZflCRP7MdoocFD6e4UAyKY03ZO14fFZbklr+In
 FK1T5WHQjwIEl++htykK0GR+7YzqiuaEf9ZThTdOtn9ZD9YkumZZ4abXw4jBvv/DFvOH
 ckXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790092358; x=1790697158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
 b=ZEQpG7u8WAF9y0pId2Wjzu01YKLzHgBLNYE6JCTAq5P75IEivnQG2+FGBF+LQ085Oy
 Lx22TiAfDs7txerVY3yvyovUxOVCzEWViyUr5383QARNEODhHUibvJsyUXSg/AiNmlcq
 BwREqpCovBGDRogVdB0uegU9tQG+u6RRqkjJFr4rQzimG31sLGN9kA76lHqC8VAz+rrM
 Es2sj9VPJcnRxDi7ef7v2Ehvl3XvJsUk3Vfh65xRNoIBc5Lwp54bFHPdwWkz183UmJo8
 Trky5fkGNG+Rx4tpGvLjv9m5F4gZNazEWckKBLJPFFZSR7xmt5trxjEDw6EyLyjXz+xa
 GAzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcBfpGLstGR/tfywGraNLipyP3Wnh9HyG9qldVazyKNcJo6bii5cqOkfKRM2zpaV/rRaaM22rUxWgHpga6o5E=@lists.osuosl.org
X-Gm-Message-State: AFuF++nLf7WmDaofxNXmpYDKs0VFKeld2dIuJkJcJDBeCBTCMguoua70
 uzFj+lb1NtRVvxVglDg7jaKvUtYs8dkFJa+YxXcRX2yBfHvUB41cwrJ5
X-Gm-Gg: AYBFou0rv+zZsnHa9x4ABA9Z8MkJprr1KlbQmmnevH/F3+32pBraTA/jxTuBXe7flxT
 xqr/AUcFRMFSuVKazT4PDRFMbvpP9O2urEgnqbfTuKq+CjgPm7vi6plS8WNDTvELx4xMZ68Pxs8
 U1ByjEO0vsP4GIrgTJ6LFhO+hPVoOYGJNmQhvgGaNTDYf/Y6HukQqqqFyU5IS6fhBUDwy0jGjwD
 Y1e4kDgx8rWXXMYCZ+5+NM7xoUTzfwsZ7J3glGXdCbT5pWMUAsyeAE6qmE69SpDyLWkhrJE4dMl
 6lizJ2ojzLuNEMnJW75QJlwvN+TBXavWK06ef8rbqTwhzQ4gvpzEH5WTqzbMPhHBlVFOv4Kioxd
 JwrupTK7Q4c6gNI4xKzLQCUPSbTn8khLGYj1n7/CqEm6+wKPRaya6ktl+U0ciPQbjn7RDh3qir5
 2QypN8n8j6PHIKwlQzEoL7E/WwYWV8eFa8r7glujT5VHyt/QP0Sk0U/9zep/zO3cV6beFo6GivK
 RW4LaAb8fMG7ihg
X-Received: by 2002:a05:6402:274e:b0:6aa:9f93:e991 with SMTP id
 4fb4d7f45d1cf-6aa9f93ece3mr3291043a12.3.1790092357607; 
 Tue, 22 Sep 2026 08:52:37 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aaa44e6262sm1347326a12.11.2026.09.22.08.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:52:35 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, ffainelli@freebox.fr, auke-jan.h.kok@intel.com,
 jgarzik@redhat.com, joe@perches.com, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
 Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Subject: [PATCH net v2] net: e1000: fix warning in iounmap on probe failure
Date: Tue, 22 Sep 2026 18:51:39 +0300
Message-ID: <20260922155139.67364-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

During a probe failure, the e1000 driver error handling path calls
iounmap() on hw->ce4100_gbe_mdio_base_virt and hw->hw_addr without
checking if they were previously mapped. This triggers a kernel warning
(WARN) rather than a fatal crash when passed an uninitialized pointer.

This issue was found by Syzbot. The exact kernel configuration (.config)
and the C reproducer used to trigger this warning are available on the
Syzbot dashboard.

Fix this by adding NULL checks before calling iounmap().

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Fixes: 13acde8fffc0a ("e1000: cleanup CE4100 MDIO registers access")
Fixes: 1dc329180fe22 ("e1000: Use hw, er32, and ew32")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v2:
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags
  - Added Reviewed-by tag from Aleksandr Loktionov

 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..156903089fa6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
-	iounmap(hw->hw_addr);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->hw_addr)
+		iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
-- 
2.47.3


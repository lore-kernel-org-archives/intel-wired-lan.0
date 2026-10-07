Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50B2CA600C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7751440602;
	Thu,  8 Oct 2026 15:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id InJBEvcv3j9p; Thu,  8 Oct 2026 15:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D790740713
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473250;
	b=YCRdwdgfmLSRxH+LkwIwwPhdhbsRCUC7rm9vJTN6Bi0lI2UAzUqR8BSRSDGl1XziDvXs
	 ngZUW+5x+i5++FBQq93w6YSCp11Dxr1UUrt2S56oF2lIPvwSIOf6hfKUAAngd/1BWP9ck
	 XPgr0zxfn1WrgKjg2XP7jZ5agfysTa4hR953QjGMN/M7sleZYSBfBN2oatJ39me7bN2mi
	 ZcUBH9SRZkX7RtfBH4V6N3tdKydA718kApt/nCsRY8kegs3oeTdozSnGusdJ8N1MF+zGS
	 OQNpwKy41kvahWVotJ4M4jLR0iy+PG9feeBBB38+CRJoh+vjLJbbwkcpsIL44sqx4pQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v9LzkPOzVBtC2oeBzL2RQojlIYdLdy9WRgZ+InvbO8E=;
	b=HfugVHZsGBrsXhuF4+MvnIQ4YCC/Q94/2dIJb27XkSvH4VjZZ+t6K98h2TFLSxMQiZwV
	 JJYHAQvww8rxc0dKW59KB0NYIUjPTvWR+PAGAw51KHRD1g+8ztLhXMcdQePVjrJ0Z0fq0
	 ae9wudkqrZHlz4LVhRpElRyyQ7afGOBjASnP7trtZOkB85/+xOXofS+DYino1cqEkZpTQ
	 M+4Eeg6Z1MVzXGop/vC0OGLlm02Y+gLPArXEuf0aQ8g9cveKv3OmPFj+UHlgnwpC6O2c6
	 LW97tRNZz7ygXK5zaqeKRJIp4rdity1PvzrL4pjPMu2PQ0vSq3pknSo8ok8dCrfyttw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473250;
	bh=v9LzkPOzVBtC2oeBzL2RQojlIYdLdy9WRgZ+InvbO8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CF7hwHUfuGoulupjV/LZa55RqP+0Fvv8XpLaLLkjfKoAVUDCPMg0GgOUZSmNpj4jC
	 Iz+1r9AlZQJD3P41JIQVvQLCbBZkgIrEho8S74fTnAbbdZLlC3bMXdjHgidkzcplmU
	 eVf7nDjpft4lLyKPwVWJ95hullB1ZaoePmRJP46huUhTHTyPsbvZMakdGK0hOwoj4U
	 e67OePwWjAyrJeRXIQ+oYaPtKqOYYKX8AgthkxnOZEb75EJxQcS6p6mEIpBGc7MA9Z
	 oakz3Z9kmSHAKl9pWb6ShF8Gq1QcufsIjIocijrCAfj45IWOckh75oen+ahTC0E/mz
	 8oX3R+4H8vAkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D790740713;
	Thu,  8 Oct 2026 15:27:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BCCAE32F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2D4160871
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UMFFP1OKpM8c for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D25C16062C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::730"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791397010;
 b=fzEqnA2re52ugVGGElbS6rAwxEn6zbN542/k881eg6xjwEo25EgITubqSHFMRGkY6XpD
 tSeqnPNFPIpBkn8/BJgqB8hy/Dsq/sYYLAIq4AjEihdBjizZNZCQz2wxks/4benX8R5My
 JNsMerbRqryij36GauHC9mzuPBbHdJPO+b5wM19VetwBS5z7cFz9SWbg7yJLelivTWE4Z
 7ztsDmNEvf6mSXr0uPQm6PcNNIgTAO8PBPkQkRVJAAvtZLliE3S9evuWmmZBfBcD3sDRt
 3ahVttOBHRv8Tf0jyOyTX9nrgBnnYe2HYhraGDVJ+lljE5qMgcn8yQR2ClFVJdeiKhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791397010;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=v9LzkPOzVBtC2oeBzL2RQojlIYdLdy9WRgZ+InvbO8E=;
 b=hYggbtNoBhIZcSxBhcqbniPZ89nMCt/+JnWUw45fO5M3rhVlSEbWMqREdyVUsJS1qBld
 Oxn4kMCzEuyQDIKL56caT2prb63hh3JVvlLOWeGNHZTxFdyZ8/HuFeEzLuUdgq9wbEAWx
 nY4UkS9zW5kUi9CvGhKx0aHAfd+d/mCI/wRj8o5SvEiGCS14fCa/ZL0NMJ9beZLWfCgA7
 sEOlv34c+crJ608vutbQqzmq+x9JidskMtNvjGvZSYAJkj+UnblYYs844Xu0j2+XXmld5
 nfXBXmUBiCNIhpHuf4aCmtc0cBn50ZAVOjqpSEfxzLMA32euWP66u55L9XVcFnSdLNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=XuPSZkjN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::730"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=XuPSZkjN
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D25C16062C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:49 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-93e63522076so135693485a.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791397008; x=1792001808; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v9LzkPOzVBtC2oeBzL2RQojlIYdLdy9WRgZ+InvbO8E=;
 b=XuPSZkjNiVIzL87aMMDlYfXAyztSU1Or2w2Yw02A7DJ2S+oigx5un8o5jbK27G/1pk
 JXg4jEF0WvBqV0oeM1TpO/7euxyiea8tRBN33W6hUjq2MMTi7A5CM0ZiuPged0pUbHwi
 cM74a9SlFSfqCqOs4BEXDrR4/FgcknglOpuZK5jG2t9iCnEjUmfQtZwjCuDhcSWpgbbN
 CpeP9r2DOoh1LJX9rZ5vLo3uHkKbckI+Z/uVGw4WElFBImTqbTNNQtc25xSciY+ogGPv
 XAJHBQGXnE4f8AXaUn5FyPTUA7Ws2fHjYcb19Wu6w6QeFuRoRjMU8wEMFd9QYoViyzkf
 ntaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791397008; x=1792001808;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v9LzkPOzVBtC2oeBzL2RQojlIYdLdy9WRgZ+InvbO8E=;
 b=DhEfq9LrDsqz5mBinmoGgBwAsB6e0NWG2WK616VoTUCK474QtLQQQvQbfLi/lFpClI
 kYGA9/IS+2kprOXAQ16TMHO4zNgHDrxuhYfxXJ6GHlF1rrJzYd4+q1ksPuYc99fJPeVm
 TotANu14tFmfPbrtUC80lNDdu3cUj5R5dtPsV23rcyGfJFMe/qSG8YAYesdnc+WTsNKX
 NTZoPWpvRelCN/2EeiGcQUMzw2mDeFcvi9lpU44HzKrVUJLQ89WlXEpa38DUW1C7kDnc
 S3XpFMamBlrNltD+W8cf2aLN79pBo0B0iN0cPD/QAYSsLtrN3hwg6NWher7tOj204lPW
 5dpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz37axXw5Nk+fBOtFFe0OcyQOlSNLTfFyPFfz/xft0xxySEITSW44kb7YgTQ2PDjSCFr05LOUaKz81rNB9PoXk=@lists.osuosl.org
X-Gm-Message-State: AFuF++nu8RcMKWfGBme73yAcPcxpeLrMQ3FNmUeA6yFPqXQwcLM55XpU
 SN8GQtvfxC+TlEgyMyDV66rDqCMRLsULiyCrv7Yoy4toUL+0uOB7l7bucFsqPglEYj8=
X-Gm-Gg: AYBFou201tCvr33ti9G0rZihgNqLI9fjzBWroWhmn30idt5AQDPkcpSDa+O2pCvx3jA
 Wvrnep+89PiyShPKvF2t8+WIzU/4BLK4MzWgVXqyH7aa3oONgBupXwVZRVW3zEwEaeptvqGzC6G
 UgdjIhPvf/yf9BU5ZroUARb/gVaw66o8ki+fF9G9JHOPwwKHlR7fMBF/06UUs8wEXE2moKqSWdT
 KfQSh060dXhHQJ1Go4DKdCc/1HvSYebjaoWetcc+EWdejw763nJ1RWOiKWhjrp0+LywRpI2EGBD
 x3NQRC8J5AozjOvoy9U0ZTZ/XhV+zTzPwsfIA5AQhN5RSCBpA5LqeeCGPMziJoxhpyywyUMXocy
 mFQUgvyxMpoObQW18icXUP3wKg1ivdmI4bm+eVP9JexJm5nD4BvV7oNv1RPr9P2aAioXYEk6Czq
 Y6kbhUW6r3GzRis1t4lE1pGlqhFrTTqFlMNrmNfrR2ccQV6uGZvHVa7oaxpjfDdA8Z2cJhDe4sR
 ZqiTWPh2AX+5rc=
X-Received: by 2002:a05:620a:1d01:b0:92e:bc28:5479 with SMTP id
 af79cd13be357-93e9b0d409fmr622164685a.2.1791397008056; 
 Wed, 07 Oct 2026 11:16:48 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91996cb6482sm26056716d6.14.2026.10.07.11.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:21 +0000
Subject: [PATCH net-next 8/9] qlcnic: use pskb_may_pull() to pull excess TX
 frags into the head
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-8-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1162;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=SB4NDDKRAhqSJIc9FavKPbItFv2yX/PiEJ0MJpAzuVo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKawHW1ued0W6S4cwaeFnOXmxDTI/W4Hxcn7RUYBu6+BybT6utdZRP6YL9LzmS5Mmr1yUPxsj4f
 B1rA2kxPagA8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA
X-Mailman-Approved-At: Thu, 08 Oct 2026 15:27:22 +0000
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

qlcnic_xmit_frame() pulls the frags that don't fit in a TX descriptor
into the head with __pskb_pull_tail().  It already checks the result.
Switch to pskb_may_pull(), which takes the length the head should end
up with and checks it against the skb, so this driver no longer calls
__pskb_pull_tail() directly.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index 761ef3bc8193..4a81d499e51c 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -682,7 +682,7 @@ netdev_tx_t qlcnic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 		for (i = 0; i < (frag_count - QLCNIC_MAX_FRAGS_PER_TX); i++)
 			delta += skb_frag_size(&skb_shinfo(skb)->frags[i]);
 
-		if (!__pskb_pull_tail(skb, delta))
+		if (!pskb_may_pull(skb, skb_headlen(skb) + delta))
 			goto drop_packet;
 
 		frag_count = 1 + skb_shinfo(skb)->nr_frags;

-- 
2.55.0


Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E95EB1076
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2FA081779;
	Tue, 10 Mar 2026 15:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZwXtUG4h4ZL; Tue, 10 Mar 2026 15:28:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 696B081886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156503;
	bh=BJ66tlRJGWcr6zQKUuqut9b4VgLqQ75FULJQ++XQI3c=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F5Pc4lB7Zf2yvxEjSh+LTqnXfUhTHq5+D2JCIfpbQJmu+PK1RhMsoHbzVJX6oWboi
	 E0AjUSLKXReZA5nlVqoGIg0udQ3gNMPvNQpAVE1jHdJaViowAzCTNUyh+YDOpQ+aqf
	 RNzgC4t45wzdIEnSORCnPgPP3SWOen5KveXLINBlzNQ1LDM3zBvslS1GeK1gumDIDF
	 n8EDbG796IOO5c7am1YryXEh2vH1AN3nrmVN37/qs6og0jc34aY0i6ED0EF7O56PUQ
	 KpibkxecFUhkS0NJdOiR9PKS0juJpNlMTDeB8Q2Xco9ya4DzlA5HXuO0puUNnEL0pA
	 fL6twTiesyEBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 696B081886;
	Tue, 10 Mar 2026 15:28:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EAEBB8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 13:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 107BD84017
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 13:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxnnIWQ5LS1f for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 13:34:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=lee@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 700D584023
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 700D584023
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 700D584023
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 13:34:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DBB2D60054;
 Tue, 10 Mar 2026 13:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1338AC19423;
 Tue, 10 Mar 2026 13:33:50 +0000 (UTC)
From: Lee Jones <lee@kernel.org>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
In-Reply-To: <20260310-b4-is_err_or_null-v1-51-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-51-bd63b656022d@avm.de>
Message-Id: <177314963081.2226692.3105447886678957300.b4-ty@kernel.org>
Date: Tue, 10 Mar 2026 13:33:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:28:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773149641;
 bh=1YnmztTcNk3Ff+PgeiUurE/Sk941AjWRBcXze9NtmZ0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gbboZny9vDD72Pka+n0iXs0baByjKbSZoFC4cppvyGvi6DURLPzP7/PURy6H4x0SE
 hZcTDQvWtiIR96dUWEkTSxfg7YW1/icauTRQtPPhn3DjatNJnXXgx9ePr2EFS/J1xE
 m2MZHJen8/8vAxVjX4Rh0mvAwOneBCTEICPjlkx0jZOCBN/iedVV5+9QBqwIzFk1vO
 tVOWY5YqoR5nPBwka2P8esnXtwU65aqvGrom7R8xo/zbp7HcZsAU1Ct1Z6jDsVgPm9
 q6q+cosYNG9tKwHqU9XoTXUFgoVy3XzQYbAwRSYwrOvATdzUAyZiFt5O4W3gYPYlF6
 gVdqFVkFvSybA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=gbboZny9
Subject: Re: [Intel-wired-lan] (subset) [PATCH 51/61] leds: Prefer
 IS_ERR_OR_NULL over manual NULL check
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

On Tue, 10 Mar 2026 12:49:17 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> 

Applied, thanks!

[51/61] leds: Prefer IS_ERR_OR_NULL over manual NULL check
        commit: e68f95a51d1a8c1594b536c4d495cbea38d47561

--
Lee Jones [李琼斯]


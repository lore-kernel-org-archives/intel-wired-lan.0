Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED02AD358CE
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 08:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8649483D71;
	Thu, 29 Jan 2026 08:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RLBxkmActDNH; Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9BF683D66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769674113;
	bh=lvyYhp3YK3hujIht/O5jpZat7FhbRgETp76pldcr/+M=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MKd5QfwdiXpnW/EW+Eyn/0RL19OnCllorGdck13AwJIMcH3VSECC9w12Qybp/jj+4
	 T8e2MMiWIomozS7TQx+Ce1YzUAgrzpEkbbSDUtptMSKjS+pu5ar/fX+IGGl/xALRG4
	 vkHfASABFmAUSzDTAa99W8DTBZ3oCCGnQqAJlPltfnAYtUkpKTFRQmBlSE5POjOTRU
	 Tocy+J9BcGQvBL/gBo0qyrauDAOz9cRakgs+FMDyqV+Z8wCWjbg8E71HUvT4UH45zI
	 ci4PLt7QEi57KikklN/ggHc2ZGhuYVwh6MBes3pxAS9R7uMTLokep6MJca6ByacNhR
	 HH3KWyNZK6u3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9BF683D66;
	Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F7CE118
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3506D60858
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_c2PFR0UNgJ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9881F606F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9881F606F1
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9881F606F1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D53F3444ED;
 Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68E0C19421;
 Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlN4m-0000000ERMf-2vI7; Thu, 29 Jan 2026 09:08:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 29 Jan 2026 09:07:53 +0100
Message-ID: <6c6504dbc4d78555392db94b93dab711eac83f41.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769674110;
 bh=aGtXVSLt63dj+krdfmEJciMSaeT6Bvc5GNuMaIsTXoE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GwUPwuKchix0ktaGFZ14BD7+iWe+YGEUESq5oT0WaHhHb6rszMj7fIaXDG9dn3yb8
 DCU+GP/MdvDwctj36xsGMnzkJY6i73EcapVpFjojhXXx1BsgVLOklXUgfbFYsJoVXf
 iM3KDxbFQw0+ZQ29a/C4aD3ILPURhu8kDrhMyCQmoXktjOOEL6rqm5WFJ6sclD0QHe
 mmmogdnoD0jtWSKror7JoHDUsWqaY8eEsdmDYq+lOuonMxmWGKPcNjpDp8rYvlQXQn
 HVMKOrQ+fk5bKLKQ3RpqEcmCfp5buVAk0q+A20BIEwbWxIfpf3vgVaJmC0uE50nbor
 ad2VfdLhF2itg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GwUPwuKc
Subject: [Intel-wired-lan] [PATCH v3 02/30] docs: kdoc_re: don't go past the
 end of a line
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

The logic which checks if the line ends with ";" is currently
broken: it may try to read past the buffer.

Fix it by checking before trying to access line[pos].

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 19e777e2c97e..a0402c065d3a 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -265,7 +265,7 @@ class NestedMatch:
             out += new_sub
 
             # Drop end ';' if any
-            if line[pos] == ';':
+            if pos < len(line) and line[pos] == ';':
                 pos += 1
 
             cur_pos = pos
-- 
2.52.0


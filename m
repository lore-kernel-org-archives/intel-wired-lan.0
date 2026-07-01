Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD60C43327
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Jul 2026 13:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8713C410BE;
	Wed,  1 Jul 2026 13:57:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTRFMXNSTB6S; Wed,  1 Jul 2026 13:57:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CE1F410B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782914247;
	bh=zag35WAocY+5o+OvST/25DSXMEyjKxN2j2GDhfTpF5s=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EajReQeZ2qWagsQHRuCyIeKeCHgNmaNRYAir5e4PeXO4DnBeuPzXMEZHvcwe2715K
	 89e0zcOlyC4PhKQlfhq+kBnSsWMCfBqDlapNh1/VG7kowgitqhTAgnlJ1hjw4fRBlt
	 11wfag0w/ZOY2x7m856uwmo6ZUAHEsaYDgDiu7ED6Bekcb8x6IkuJMATv6EJ4UU1Mj
	 gjs+NHSWE8jQK7w1BxghLMdSjkvn8Z2dwBxliXsr0jYxtSIa/c3r+0rpPcDFAoNkJY
	 Hr34pkZiRwRgRscVG+fwl9ELih05ZUPGLSd2mAl+IvL5QOlbjNNlnCnObbO6OG8KwR
	 vcnthS4/Lw9YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CE1F410B1;
	Wed,  1 Jul 2026 13:57:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F82C127
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 13:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10D3D60EE1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 13:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 353lyHK9TRPn for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Jul 2026 13:57:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 31D3660EDF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31D3660EDF
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31D3660EDF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 13:57:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7182941252;
 Wed,  1 Jul 2026 13:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF371F00A3D;
 Wed,  1 Jul 2026 13:57:20 +0000 (UTC)
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 01 Jul 2026 16:57:17 +0300
Message-Id: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0cRWoC/yXMwQ6CMBAE0F8he3aTgkLQXzEeumW09VDNLhATw
 r/b6vFNZmYjgyYYXZqNFGuy9MoF7aGhEH1+gNNUTJ3rBjccHcuJJ00r1BhzhGbMLD3c2Mt59NJ
 SWb4V9/T5vV5vf9siT4S5XtWGeAOL+hxijSpp37/MWFb8jgAAAA==
X-Change-ID: 20260630-b4-drivers-ethernet-b5e085b98ab1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Sudarsana Kalluru <skalluru@marvell.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, Mike Rapoport <rppt@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-net-drivers@amd.com, netdev@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1782914244;
 bh=zag35WAocY+5o+OvST/25DSXMEyjKxN2j2GDhfTpF5s=;
 h=From:Subject:Date:To:Cc;
 b=TlVDab3taKef0cAHAYzvZWbe8q1YtiZZL2iPNyoLbK/g1DgwhDk/Gg9XGmwG9yKBF
 PnWzy//tKPnrrbIuL4frm/k3LfXeFGF2iCiZ2yEZWg2OFMYpIXXwpiqEGDdeYqHh12
 FxuPhn3YvDMqXdAYksh7EzEe29c/SLkcjH6s6U2CkKGL02I4pNZDh36BF+vzSNse+L
 4L4BLyrOyvTeZB/fzHFqta9oFP7ZoXHXgsn7JsvszUlmHn9T2thGwzYpuKnFPY6iZ4
 /hQnQLexd22jTT31Sc43CUIAg/Usjb6WzwhcixRdNrLp6OWItHPtroKWH161IHgwTI
 elkTYlpzGTUfw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TlVDab3t
Subject: [Intel-wired-lan] [PATCH 0/4] drivers/net/ethernet: replace
 __get_free_pages() with kmalloc()
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

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/drivers-net-ethernet

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

---
v2 changes:
- split out ethernet drivers from a larger set 

v1: https://patch.msgid.link/20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org

---
Mike Rapoport (Microsoft) (4):
      bnx2x: use kzalloc() to allocate mac filtering list
      ice: use kzalloc() to allocate staging buffer for reading from GNSS
      sfc/siena: use kmalloc() to allocate logging buffer
      sfc: use kmalloc() to allocate logging buffer

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_gnss.c      | 5 +++--
 drivers/net/ethernet/sfc/mcdi.c                | 7 ++++---
 drivers/net/ethernet/sfc/siena/mcdi.c          | 7 ++++---
 4 files changed, 14 insertions(+), 11 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260630-b4-drivers-ethernet-b5e085b98ab1

Best regards,
--  
Sincerely yours,
Mike.


Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77E606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1zz5ffjx;
	dkim=pass (2048-bit key, unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=x89mWjhG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C09B605F8;
	Mon,  2 Nov 2026 22:32:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYwV0TG8d5Hl; Mon,  2 Nov 2026 22:32:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 605AA60642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658766;
	b=EWSMlyG1e46diFc0bZfyJU3b7EL6DSsqF74Ek8zzxfkhQY1dhOOs7xNOc92XL5Ki7Ued
	 QMJ5kMIRXvS1+6zJTi6YCOEkWfKcaRPCgv8yy9CeufGeVg6IJ04ZzqYbVqBfJ47Vf1Csh
	 8jHUZ0IurldG7qaKHUu0b9E3vSc5EtJsS9EIaynr/EY6ok6q5IZW/0Z+2vj0ZQuhZ9PqI
	 Cj0NFtQboKUGzkN9jb2lUX4EKlh2CEZofDAYV5S11+9YNqb5weob6BwtRHiyfvlNZRGZK
	 XOaqBgm8uA1cGMu5R20AUsMcQlROTlhBuUN3vb34SmgbUFcm/3kHuvlSLuCawMtuFZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wCcV0rg12r0VQC1RmFLoD9rDhMDyyca61RfRGBocBOM=;
	b=tMirrqCaKNVZRt7hHw/CAtPQj8G7aONpwtDvOXb0/ErmBWk4B+mJoHWoCDr2pHQ+mIGl
	 73EuaUghONABlLBPKTcKwdXY5h72Tmnmpw1EkUNFL/QsZtV2lM0L7+4uwDUrzBwxbQeaJ
	 i8dE1F/7kUwvd6R3JzraQcQ8XMT4nY8kST6tvbMrhNTvNjToAkYRUNf/1zvaGxHU6zj+L
	 /sEcDGTcmUN6666lAXqlPiK0B72gEKU4Hpm56C7QfSy37QWEaC5/6j+8kkEeP8iuekQeY
	 4BahuZbYRW62FcxNNg9FmWf5ivbb91c81Ryuw4wep+kka1oHY7J8F/RWYrBkAaQgm9A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658766;
	bh=wCcV0rg12r0VQC1RmFLoD9rDhMDyyca61RfRGBocBOM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1zz5ffjxmtd3PlUQmJWUogWT5kxkvr9QA9k5JDYWHzUbPX5CSuDo7oQopCSPhGtYq
	 yekhb11A7ixaOBPUg4vVqkbUJHxk/c6G4jSR26TntyCKkF/QkxiJ+qdsc+Tq8/+Vpt
	 Fc71SW0kMPhTChzyZSi53j6ntZ5h67OKvAdJE6gxzu2cBD0/RAzrUIlhgx228DYIxU
	 scQE4ouKhmUHJ3+4n/C2gqfYI1e5EOKwzSomRhIhwRg/0WrO1m5Tpr2xkZvlotqhPR
	 ToxjtT8z2S0d+jXZNaD/hHnp/iowU590r5JK332WuPTTgEkx2rkpmFZ/j28I4fyWN7
	 HAoDMYJWlp8HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 605AA60642;
	Mon,  2 Nov 2026 22:32:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 752312AC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A68F400B3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T5YMtPEVLw1l for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 18:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1A80440083
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793384146;
 b=XwNJcXL2Qtd7/Qr0oBt2nWWy+bXB0ps5+ZF4MTngqgUh5UYs0GoIXJvNQ2DidfMqAXvO
 8n/hGZptoz5h9IdGqHZsjY6utO9IK1Y5L4Yiqftq78l2iVxqzEtaOXQOza13c+vQtQb1R
 4h3hNQu7LZBjWXICh8ccfWx1faYJQqZgoscTrZT6QCge9z7UmnJ33ieYeI8kC2QJgfrz2
 3Ut+Ynjh9BbqBex7EMCLixLT1cABqzDPX6h8UlMPKZ7svMz9y4ZbW4rtS6B9c9FFFUsfB
 +9uEd8iOwS2GbIA6jNJJt6RUMkmjsrP9E6JXS4EP1SS+ANEPQmAjIeJjbYOVKTWyOEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793384146;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=wCcV0rg12r0VQC1RmFLoD9rDhMDyyca61RfRGBocBOM=;
 b=d1wGn3lbQGbeMEFXlhu+GzH3uxsV6CCFlyppvw5+eafENwlQybhL8dnB0/gLvRzl8tTc
 EO+edKWwHqzl7678gAJNFTvLEIHlWg1wjsmIt3ODtbPQyCzfRVT+qQyKoG6z+YMjR+uqO
 N5cDxIy200yFItCDiMtzuNy4/jozwfJuqCeJ77IloI4JnKa/RI+zAVpJD0OzJrE9R/BHt
 wqLOBgvwRb4/jjLRbRnF8PWMuRP2QE/cTTExdw6Rk9bcGh6RY1sr6NEuIglGui+ihbi7s
 nMP43aYlXM2nJfsXd/awYKCPq48fa6ucvu9cw7V+Zlfk1ZII66vFHQAZFiy0AqYbCsQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=x6u.co;
 dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google
 header.b=x89mWjhG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com;
 envelope-from=dhu@x6u.co; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256
 header.s=google header.b=x89mWjhG
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A80440083
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:45 +0000 (UTC)
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-7ce6cb4c6faso598376137.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1793384144; x=1793988944; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wCcV0rg12r0VQC1RmFLoD9rDhMDyyca61RfRGBocBOM=;
 b=x89mWjhGXiZlfqTGiLxgBZI3096AgMKou0mULsC2tUpPzX6pD2SpdwxBeRSrX0tUYv
 MCzGQcoGlsyghQnNnYHTwlzycF+0r09OkTQlRV9z2lJZrj3RVFLwiPl35q9sLrWJhqPO
 YCNFdZEigLGrbJ2G6LUpXtj44mSkYqrgTJDJvNtV4cDCcKenoFkXWRWLXpOQnBnUoXzm
 Xh9ACFBFB3+fi2hdL+pJdxhgtAGsMow1l/uzHjf60CaNBfZVT6oIkp7GJ7Gk1KP9pEep
 lhxWThCbsZTb3yfIbzWNP+0CwAdOL1KXG9xYjFi5y9Ut8hmayineU/pHSgmOHGoO9ySQ
 rpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384144; x=1793988944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wCcV0rg12r0VQC1RmFLoD9rDhMDyyca61RfRGBocBOM=;
 b=HkXrFY0bEOgcAtF0TvkAo+QgEePDRNQtqq2h2mkuw1mACWfuTGeci+PsikfCsKovly
 OQs8m/I07KpUItmWxoMAQ48JhNI5E+C+xMd13FESOIUawQOkkuD8qCA869LeNqpSqCKk
 IKPolsH5+odNejdLkjVvV2gnZSnuNQU7esmTPwQf5waArT9tIYckhgYscenr4zaLAzIx
 bwu27qVnrOBxkpPJTU5+/lIww0/idyOt2tLqGyTOTXSiTM8aKMajflzi7ZBG1nB5Ca/g
 w8S+S722D0CQMc5y7nyNwUhrTZ+ARfvRD11exnCLwQBi6YfM7JBBpap6vv9OrluAO8u9
 6Oyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMotLXkkw17obAy349L6wPz47irKlXddCL3gXy8bmdpD7u6hAXgJpdFCWZbxvk/xfs2kkdPlf9QUXGMF6BUko=@lists.osuosl.org
X-Gm-Message-State: AFq9FYI/axniVeMtX8WXWWFe1f2+6AT9znSNvg2scL1ctzAnw6nYf/Kc
 MC628hBmFToyIZL2UK3S5vUOsgywJEdxEdg29el563pZfnjGFJvNB4s1AUwGInygNQaN
X-Gm-Gg: AYBFou1E2ijXJClnlPlilRcn74kD8m33kavVT7yVaVbyKPZV9u31hCHRQLmeyTBglpW
 MngKmVrg5f1fMQp08LoFNRJI2VM9NZcloSgmwFf6QWEvP8z2iQvz9eYbrJdu6embV+NwLaWOtRC
 RpBuqc71NwR+GWuwNx2rIMXjo6oh96XfYFtYLr2YuhiZO+BhXdVwcHjy51Tfr6FgIJ8796dkp3f
 bWepJZspOHjVdJawCqd/v/BmuBQzaVbfyyIIS2RASSzC54p4NpsB/LejPumhtHxhFj4afTx80Yv
 GcTbJ64m8P2DSYM/X5MHD9NWgGWiqrkV5h/Ok1263O1eG8BXn6ZOs2n/dqU8oC5RS2oN+GfUYEh
 cy2yunHuenDBQHlVJpZqd1m0GWH3HYJB/F2L7M9bHiP0qXBIcmCDLvtfY5llsWH6jrFPSZLGQ5D
 61OTbOiZZQtl3ux5gXtvVkhhgOesh8FE1b8n3GG/uNp8FpFxa8FS9DFG/tkaaw5CtV1KzcWDS8W
 brXbzAxCUbMLlw94sF618jfut2snUINdbUPBRT3FUGZwmTha2MDKFrxugOvR8S9iLEKyxrj16aU
 jKnlnb2nSnzY7hKC60lwyotbnS5yQH/OK4ZCqMi7FuGoo1X+f2beBOMOayLf43zoppXQsZbwLbo
 THpaPeAIt8jcMofB5v8BXkCZ3fxzt3P46hOG1hSAR81Q=
X-Received: by 2002:a05:6102:442c:b0:7d0:6cf3:d8f3 with SMTP id
 ada2fe7eead31-7d0726cdc38mr1776278137.18.1793384143954; 
 Fri, 30 Oct 2026 11:15:43 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d07754c1c6sm3077931137.3.2026.10.30.11.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:15:43 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Hu <xuehaohu@google.com>
Subject: [PATCH rdma-next v4 0/6] RDMA/irdma: Add support for ioctl
Date: Fri, 30 Oct 2026 18:15:06 +0000
Message-ID: <20261030181512.2056056-1-dhu@x6u.co>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 22:32:42 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Hu <xuehaohu@google.com>

Hello,

This patch series introduces support for uverbs ioctl queue creation
(QP, CQ, and SRQ) in the irdma driver. This series makes progress towards
modernizing irdma. This enables 1-step queue creation from pinned UMEMs
and shared dma-buf heaps (system_cc_shared), providing RDMA support for
Confidential Computing (CoCo) guest environments where memory encryption
otherwise prevents standard host-VA-based queues from operating.

Historically, irdma relied on legacy write() commands for queue setup.
This series modernizes irdma's queue creation path by adopting the ioctl
infrastructure:

1. Plumbs uverbs_attr_bundle into the irdma QP and SRQ creation routines.
2. Registers irdma's UVERBS ioctl namespace definition for QP, CQ, and SRQ.
3. Implements 1-step queue buffer creation for QP, CQ, and SRQ using
   UVERBS_ATTR_CREATE_*_BUF_UMEM attributes and ib_umem_get_attr(),
   configuring hardware Page Buffer Lists (PBLs) directly from pinned umems.
4. Split CQ creation setup logic by umode and kmode into separate
   routines to be consistent with other queue creation logic.
5. Adds support for driver-specific shadow area UMEM attributes during CQ
   creation with CQ resize capability.
6. Preserves backward compatibility with legacy 2-step write() path
   registrations when UMEM attributes are not provided.

User space rdma-core PR: https://github.com/linux-rdma/rdma-core/pull/1766

Testing:
Verified with rc_pingpong, srq_pingpong, and dmabuf_pingpong over irdma
devices in Confidential VM environments.

Changes in v4:
- Reject dma-buf queue creation in iWARP mode and enforce page-offset
  alignment unconditionally in irdma_setup_q_pbl_from_umem() (Jacob)
- Bound attr->cqe in irdma_create_user_cq() to prevent cq_pages overflow (Sashiko)
- Fix to irdma_cq_free_rsrc() was sent separately (Sashiko)
- Link to v3: https://lore.kernel.org/all/20261016202909.1289496-1-dhu@x6u.co/

Changes in v3:
- Improve patch 4/6 to split umode cq creation to a new callback
  .create_user_cq() (irdma_create_user_cq) (Leon)
- Clean up duplicate bounds and NULL checks in cq creation path (Leon)
- Link to v2: https://lore.kernel.org/all/20261015011940.4122452-1-dhu@x6u.co/

Changes in v2:
- Add patch 4/6 to split out setup logic from irdma_create_cq() into
  umode and kmode helpers (Leon).
- Rewrap commit messages to ~75 characters (Leon).
- Fix a pble/umem resource leak in irdma_resize_cq() (Sashiko).
- Link to v1: https://lore.kernel.org/all/20261011011022.1445352-1-dhu@x6u.co/

David Hu (6):
  RDMA/irdma: Plumb uverbs_attr_bundle for QP, SRQ
  RDMA/irdma: Register irdma UVERBS ioctl namespace
  RDMA/irdma: Support UMEM attribute for QP creation
  RDMA/irdma: Split CQ setup to umode and kmode
  RDMA/irdma: Support UMEM attribute for CQ creation
  RDMA/irdma: Support UMEM attribute for SRQ creation

 drivers/infiniband/hw/irdma/utils.c |  12 +-
 drivers/infiniband/hw/irdma/verbs.c | 759 ++++++++++++++++++++--------
 include/uapi/rdma/irdma-abi.h       |   5 +
 3 files changed, 573 insertions(+), 203 deletions(-)


base-commit: c3e8e9451e6f1b69f685b75e0fbf14f3d0fb2539
-- 
2.56.0.317.g454f8302e1-goog


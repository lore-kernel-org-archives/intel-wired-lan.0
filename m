Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B185BC02192
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Feb 2025 18:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4898741740;
	Wed,  5 Feb 2025 18:20:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l9gAxYydak5D; Wed,  5 Feb 2025 18:20:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DDA542654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1738779643;
	bh=nWe+xYuCHEgXnrFzCl7hGVmyhXjsUnJjq10f+2GLKxw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vuuu31JRrkf8NNOgdd0e/yyPkov7Nl4h4W3J3jjr4Z7oImnxk11XSyihhISbrC0JZ
	 4mN8+9V9ow3y/HLfQ/tZyi67ZHbnw8psXuowvMLK1cGwGljCZrmCDwj4DBHKkUzZwy
	 YfwuOh0ptDK1ai42Os5JaTVJU550DRE5oae8xWhPczRxlCNEptwioj5LBPY/f44P2m
	 Clv2VEak/rH8Z5pR5HIJF9ghFIjlX9GIccsKJAhFzjeOg63iUbNicG4lMIDnCMRVIA
	 HYcA/PldW4nKMt1QSqstNoRlbkVHJIkY6DeZazMVFbLOnXbk7dHFcR0f1PxnVRJZYM
	 EkEoXyNxwWUVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DDA542654;
	Wed,  5 Feb 2025 18:20:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E4CFCD
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Feb 2025 18:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60951605D2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Feb 2025 18:20:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buTLsL0BDuxM for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Feb 2025 18:20:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=leon@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B65E2605CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B65E2605CA
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B65E2605CA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Feb 2025 18:20:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A8ADB5C2978;
 Wed,  5 Feb 2025 18:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721CFC4CED1;
 Wed,  5 Feb 2025 18:20:38 +0000 (UTC)
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Ayush Sawal <ayush.sawal@chelsio.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, Louis Peens <louis.peens@corigine.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com,
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Ilia Lin <ilia.lin@kernel.org>
Date: Wed,  5 Feb 2025 20:20:19 +0200
Message-ID: <cover.1738778580.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1738779639;
 bh=WM5rllHSSQ5cLPRxWaqxDpADFHh0zDNaSDIlvDY+JxM=;
 h=From:To:Cc:Subject:Date:From;
 b=YqYWYkcMGa0v+i6qaCS/cxhsjs4s4RDlavCy7IPsxr/13fNNjaqsjdG+GqcLg0/QR
 zSb/XWRMn9OMnJBALnM2Q8lzvwcI9LB4Zf+Nj3w8Y06sEBw/sy/EjcU0c6M55i59YW
 +92U3VZ5zLxvddUmf3jttdkvpR9kwL6QiS1tRvgzy2QigC8Mmz2etLa6s0L3zwQVd3
 /BVOQW4Z0rg9jdx1nD1L7+83vYJn1/Qx9xwNpvHt482RlpryJ4nktXh/omVrtu7WA3
 laI4LnePfKcr2UYtxAgK65FYzeoRXBT2I5iZy3KAWO2VGkY8jRwXgCNsJ7MGeWOxly
 tEYCJTOThuLtw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YqYWYkcM
Subject: [Intel-wired-lan] [PATCH ipsec-next 0/5] Support PTMU in tunnel
 mode for packet offload
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

Hi,

This series refactors the xdo_dev_offload_ok() to be global place for
drivers to check if their offload can perform encryption for xmit packets.

Such common place gives us an option to check MTU and PMTU at one place.

Thanks

Leon Romanovsky (5):
  xfrm: delay initialization of offload path till its actually requested
  xfrm: simplify SA initialization routine
  xfrm: rely on XFRM offload
  xfrm: provide common xdo_dev_offload_ok callback implementation
  xfrm: check for PMTU in tunnel mode for packet offload

 Documentation/networking/xfrm_device.rst      |  3 +-
 drivers/net/bonding/bond_main.c               | 16 ++-----
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 21 ---------
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       | 16 -------
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 21 ---------
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 21 ---------
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 15 ------
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 16 -------
 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 11 -----
 drivers/net/netdevsim/ipsec.c                 | 11 -----
 drivers/net/netdevsim/netdevsim.h             |  1 -
 include/net/xfrm.h                            | 22 ++++++++-
 net/xfrm/xfrm_device.c                        | 47 ++++++++++++++-----
 net/xfrm/xfrm_output.c                        |  6 ++-
 net/xfrm/xfrm_state.c                         | 40 +++++++---------
 net/xfrm/xfrm_user.c                          |  2 +-
 16 files changed, 84 insertions(+), 185 deletions(-)

-- 
2.48.1


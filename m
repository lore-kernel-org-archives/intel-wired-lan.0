Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8B1112584E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Mar 2026 15:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8423D8466F;
	Wed, 11 Mar 2026 15:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-N-8nv1PW9O; Wed, 11 Mar 2026 15:33:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF5DC84668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773243239;
	bh=JGYhPK256pxU9EiY8jbQSSjgozqR8V5kd9EUseD+GRo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q423eqjbR+R9E22iNQN6UHlKMyr+zlhoJ4kUjG4oCnKjsDTrA49EuYg2PqgoY9evG
	 hNN3yYV2A0WYNfiHbJr3bAe4drYZTZGBCGSegvjk2+dYZ2/cCIIAD5kKE3LUaFRO2S
	 e0ku9tHFimp6RzdBc4UzbG2XumTYhEUcdUt96o4oifE/PC1Mg93/TzPj1/ow5hOE+F
	 Nd5i0eBlJdAsnolWSla6JFS0Z+tj1msQ4/rF+kuwq817qlI/4TX/JMIjAfjvE91fO7
	 viDjxIG8bD3PSnKEIV5c00Mk1pAVRm6FgC0NmMU4f6tsykm98E5S/LrTf59yJSyAWW
	 JCldiNNyq8Auw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF5DC84668;
	Wed, 11 Mar 2026 15:33:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23BC7228
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 09:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11EF0615FB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 09:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oLu32wJpmXx4 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Mar 2026 09:32:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 727B160FFE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 727B160FFE
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 727B160FFE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 09:32:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 53DD143DE9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 09:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CAFC2BCB7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 09:32:26 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso13636818d50.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 02:32:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Pcwciccj80+RlAnQM7OU+SbXR2DzV3vRWPJeG1lvfJKCU5vhk3SLJt3jVDJTVrlveJIQNaOqqckcWpYsCjU=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yzts7efi9WrE74s28MKRsW3O0lycR/8FNKijNJkfyIGzYPBA0nC
 H5K6m7XBhY5yvnzk9hzoicm/dfF/75JMLpWQkljA34O1uYgHl71QvFYe392JfJwb77dRh7imgHU
 0nueNWmdEvBMB5obMufIFsmY5BMaF84U=
X-Received: by 2002:a05:690e:144d:b0:64c:e890:fbb9 with SMTP id
 956f58d0204a3-64d656f696dmr1649157d50.20.1773221544775; Wed, 11 Mar 2026
 02:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Mar 2026 10:32:12 +0100
X-Gmail-Original-Message-ID: <CAD++jLnDv00ErgVdQ4EBpKH9KMWrPD8ODrQ6m846zyQ=wNzCzQ@mail.gmail.com>
X-Gm-Features: AaiRm52aI8z_G2E4qYaKWPEA43RhLektjwMDQXSLwHd-Xy_BYcin-6heFFY4jM4
Message-ID: <CAD++jLnDv00ErgVdQ4EBpKH9KMWrPD8ODrQ6m846zyQ=wNzCzQ@mail.gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
 samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:33:54 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773221546;
 bh=JGYhPK256pxU9EiY8jbQSSjgozqR8V5kd9EUseD+GRo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HFhFoVNiTrG9LQIv0ppKNoD/HrLrqirjTX+9UZCfZCZR1ACy9KY8vzAF+UubsxXyb
 7A/AuxjB4pyfRVKpNo6VtwqDxAsV9i3OOu1suwbvFFD+dDURdR+fYaKC55vrGeQY9Q
 cSfgyMDf/Q66zJ3KWwfMvjGW3KxBKWlpZI+D0gyhlDHCmqkd60AvBaOv309nWmMVWV
 CYlN2OWwesW62EumkmGZjYKDzJerzMaIQkjARv2P34b/XlQnitMbZc1GQEBU1oFAvA
 btyT8hZcwwyybJD9LXcRDJBi0I3lkqqR8+lcx+5G7+1oP2ywnfC8KCi8970yZ/P/V5
 nMGE+UjgzzO6g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=HFhFoVNi
Subject: Re: [Intel-wired-lan] [PATCH 41/61] pinctrl: Prefer IS_ERR_OR_NULL
 over manual NULL check
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

On Tue, Mar 10, 2026 at 12:55=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wr=
ote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Linus Walleij <linusw@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Patch applied to the pinctrl tree as obviously correct.

Yours,
Linus Walleij

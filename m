Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E28CA600B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 12:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B5F36068B;
	Thu,  8 Oct 2026 12:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PDUuft-tevlH; Thu,  8 Oct 2026 12:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 81655608CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791464322;
	b=m4ZsTDNn03KvM9cz1fFij2AMOXTgB/d99D2qrxf8Uk7hEffMkkpowSpwSlb/hK6dyukh
	 8UWe/1uI+6VRBUFJqguN+k/oTbRCMWlzbpdEibqFS38l1Lh0AHgVNwwrw3WHmDBYNzZtm
	 ta7rU7ayU8jTfr5s6YeokqBxgnhPFeZw3qDQCwZIAZ79njmF4xuwGfLpXFfUXUa9EfA0d
	 92AWsNnKMGFu51gZ/ounbupgYhSH9q61N64LPLSzwFfXDuxU3dtOrI5CLlSRLfZq+70pC
	 GF8oUCp9b54WtEtNGM7RWm5b96fg6L13V6wsGc9FM5Jp9g6oqZ/k8OjkFt+YQjXsbUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791464322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MrcCKlAt0s4Z5C37o82vZjoMrryZh2UceEpNbjZksCE=;
	b=e11dTXRjpoxSStC0zVu5ywiIJItiR+eHGXfAO1dNXAUkxjkVmSRiAWAGu2vN85hUKWza
	 xE+jaGe7jZGnbrT7TwljuJnwjw2VzMoWkqbzFtTZ5w9LFDDlbsygM4u0RGhOTv+Dga2tf
	 Bu58M3kCGO+SL3WQh8rjBhjxXcwcJaC5hiYn1dgnEgFV2/PrSvEGQaHazYUJa2e08Rfrr
	 XABNePtULWwRJ8zJQRhct7I9ahnlNXAQmvjnuDTz+ubnJf8RC9RRjNBPHYhb9vYotthVJ
	 ycGEs8i+gG6OR8wKy7zoZHt8Dun8YN5eku7S9cjDeDFQgT+s3YT3Gvb78WzH8tpJ/fg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791464322;
	bh=MrcCKlAt0s4Z5C37o82vZjoMrryZh2UceEpNbjZksCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OItZX+O8v7yzrbbFZreuOY950eDAcx1gueT1etLNSUx4LOodwP8DFrnlBNYDF/RCm
	 SU4WDsaiikQdrBiQ876lyTv8eVcFro2lPuhrCX0XK/zaKrI5Akc6lffNVtHEqCwMiW
	 50Np+se5nlMAFthqfPy4ezQdSszumx9iiY2uP9VmX7AttmwV2hsbLJPrupL5ZnphPV
	 nkcEKlzoNsjReR2T7CdmrlJG1+gqgBFs3ltSo4Q7030uO2s87zoK1m38R30hR/IscG
	 LFyDTi4tvCERdas94L7vJ3mHKcaTX6TophBcB7D+JfssmlrKHUXndBdnpkMAZuX2dW
	 hfziFpGGk9Q6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81655608CA;
	Thu,  8 Oct 2026 12:58:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EBA41A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44132400E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QSeuuVeHle3w for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 12:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2814740059
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791464320;
 b=KkxRX70nuPS+1xk4tUt7nAxegw49zVFHBzMnVtkzS/SfFbWHich4UCdwtsTJnvNHxO2S
 3hoix6BOrRrXX06ikzxFt8gZEw5mmVe0rLBssJhF6LnXyYLBTGoGXeL5026CnmQWS0YJD
 iCo5wDgr3SHcs83l8AklC9dLty+uOir2WRGIyiJV2WUVJaFT5RprLZ5cNvP6ykIm0HPuL
 3FZZwA3Q5P2EpzKPZDI+t8iCXhl4Cb/a4oGujIkum+C9Q++MbhE1NVMAQ4RFdK22MYcBa
 12Xsr/qHwUorJuIOudF3TWIF+EWx2vtn5o3yMv8nj9UYINB5aKwvy+5Hr+V12KRa7Ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791464320;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=MrcCKlAt0s4Z5C37o82vZjoMrryZh2UceEpNbjZksCE=;
 b=C3zJv/lx9YOxcJ9Ysr3VSGw3OIcpbenyigpsDmQPoinf8IFdlRPZDV5YzR5U/1j6S1/J
 LhW0pYt3qR03FnEZTKsFu4esd8loOtPADdnrrPa731WrVv/vWTolepBtV+9QMdoU8gJdT
 2IVLzsYm5tGlj5avGAjT8IHfd/aAVJB7O91gpV979w1E0aw3P6PMVql8omxMzS5R2C5mG
 QEaCRTEwtfYFJjj0Z5atjlpKlFLRDyoKx/KDPKH5JDPLD1tgYuZZ1HRyOzQJ2ipCEByYk
 EQ+z02upMwQPX2Yid6TOqhHIAPz+GUmb+Ic1TIY4Dst0SkVcMM7XKtSgY1F8r/efAVg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b="LiH/tPoO"; 
 arc=none smtp.remote-ip=220.197.31.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=LiH/tPoO
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2814740059
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mr
 cCKlAt0s4Z5C37o82vZjoMrryZh2UceEpNbjZksCE=; b=LiH/tPoO5CDory7wIH
 OY5k7QYbyo3/LrWXisAIPGx7y6V77Gl3y5wDTFY8NYk6aERtO3aZrcPheJ5tFWvd
 pjFUYnDzz1iaO2h5bNGIfykj+t+1m1QTNHpYp7Wovk1ihQ9bump0b4haKSe6JuLi
 Wemt2YCuGvljS8ZxnX/01A73Y=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8NWk8dqh6CpBA--.7046S5;
 Thu, 08 Oct 2026 20:58:03 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF start
 fails
Date: Thu,  8 Oct 2026 20:57:54 +0800
Message-Id: <20261008125754.3520773-4-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261008125754.3520773-1-xiaolinkui@126.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PykvCgD3v8NWk8dqh6CpBA--.7046S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF43Xw17GF47WrW5AFy7ZFb_yoWrXw4Upr
 Z5Zr9xKr4kJF17W395Ww1UZas3CayftFWru340kw1Skws8GryaqF1UKryavFyxGa97Aaya
 vw4Dur1ruw1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UH5lnUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBuHXmrHk1s3YwAA3n
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

ice_init_vf_vsi_res() reserves vf->num_msix vectors out of
pf->virt_irq_tracker with ice_virt_get_irqs() as its very first step,
but neither of the two error paths below it gives them back. A NULL
from ice_vf_vsi_setup() returns -ENOMEM straight away, and the
release_vsi label only releases the VSI.

ice_start_vfs() leaks the same vectors. Its teardown loop undoes the
queue mappings and the VF VSI of the VFs it already started, and the
eswitch attach failure path releases the VSI of the VF it is working
on, but neither calls ice_virt_free_irqs(). The caller then runs
ice_free_vf_entries(), which drops the last reference on every VF, so
nothing further down the error path can release the reservation
either.

The tracker bitmap is only freed in ice_deinit_virt_irq_tracker(), so
the leaked vectors stay reserved for the whole lifetime of the driver
instance. Every failed "echo N > sriov_numvfs" permanently shrinks the
pool that ice_set_per_vf_res() divides up, and after enough retries
ice_virt_get_irqs() fails with -ENOENT for good even though the
hardware vectors are idle. ice_dis_vf_mappings() meanwhile re-points
GLINT_VECT2FUNC of exactly those vectors back at the PF while the
bitmap still books them to the VF.

Release the vectors on all three paths, the way ice_free_vfs() does
for a VF that is torn down normally.

Found by code inspection of the VF setup and teardown error paths. It
was not triggered and no stack trace or error message was observed.
Compile-tested only, not run on hardware.

Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v3:
- Correct the Fixes: tag. The leak starts at 4d38cb44bd32, which replaced the
  computed first vector index with a reservation from the bitmap and left the
  error paths below it unchanged; a203163274a4 only renamed that helper and
  moved the tracker, so it is not the commit that introduced the leak.
- Include how the issue was found, that it has not been triggered, and that the
  change is compile tested only, as netdev-bot asked for.
- Free the IRQs before the VSI is released on the eswitch attach failure
  path, as Tomasz asked for, and keep the teardown loop in that same order.
  The teardown loop hunk now sits inside vf->cfg_lock instead of next to
  the detach, so the Reviewed-by tags from Tomasz Lichwala and Aleksandr
  Loktionov are not carried over.
 drivers/net/ethernet/intel/ice/ice_sriov.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 470aec8849b6..444d05a9bcb0 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -458,8 +458,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
 		return -ENOMEM;
 
 	vsi = ice_vf_vsi_setup(vf);
-	if (!vsi)
-		return -ENOMEM;
+	if (!vsi) {
+		err = -ENOMEM;
+		goto free_irqs;
+	}
 
 	err = ice_vf_init_host_cfg(vf, vsi);
 	if (err)
@@ -469,6 +471,8 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
 
 release_vsi:
 	ice_vf_vsi_release(vf);
+free_irqs:
+	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
 	return err;
 }
 
@@ -501,6 +505,8 @@ static int ice_start_vfs(struct ice_pf *pf)
 			if (retval) {
 				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
 					vf->vf_id, retval);
+				ice_virt_free_irqs(pf, vf->first_vector_idx,
+						   vf->num_msix);
 				ice_vf_vsi_release(vf);
 				goto teardown;
 			}
@@ -537,6 +543,7 @@ static int ice_start_vfs(struct ice_pf *pf)
 		ice_eswitch_detach_vf(pf, vf);
 
 		mutex_lock(&vf->cfg_lock);
+		ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
 		ice_dis_vf_mappings(vf);
 		ice_vf_vsi_release(vf);
 		mutex_unlock(&vf->cfg_lock);
-- 
2.25.1


Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A705CC982CF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 11:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CC2080F48;
	Thu, 17 Sep 2026 11:19:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZ241vyf51L4; Thu, 17 Sep 2026 11:19:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D811880F21
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789643958;
	b=LNhXfysK528RA3Gv336wDLEHHqocgoojF9y7ogTEeuYFn3RYovpqjXVcvPhy5CJ+iSXT
	 Q77sICZLe7sLjQPyskoJOukZL9RJch4tkw6tYdISx+MEX7kv/uZMrfSfw6PEUFBxGnCV+
	 JKirfi+km36no0Ne4hxagc3E943APxn/eoSJqaswyjEXKSptJbt5MIVB57uvhUyWBZmlf
	 RVT6VtLuLyXpM6dipfUD22x4ykhY/VrQi/Y0EIaJYBAbswsXhRK6jmBaTs3AWnsgqYm6b
	 ax6bRg54J+kinyiXe//WcpHP2xNImckxY5PNZqNf923imSFBQN7bCrrQ104CBiUNJzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789643958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PIh/HuC0sqNDglcaATOBIvMfpJ5jUgZCIPEmpZOWsUE=;
	b=etBTJhIsbckJfbND+9nkVzJPDewsoMhGxtyNXyiLWOfk1832GpOxbvQfoW/NjbaCkJC6
	 FI3Zp51cSbGdx+H0Jg8PeD6to/dC4douapesz5MCF2J9f5CFukvqPqpeQt0uF2j47qhaL
	 AW3cWjnR2ti87NsCCxltSckJh+8jphDCglblG1or/H9bKcscTQrQaS6IWG9Xvf8+LF1b8
	 c5DZUYEExxKcEcAunHexqVQPmof/8wtomkNdtPhvOBUWHJYQBPZX7go1MW0vq3QrlUhd1
	 iyoOSzYSTN/c07+eJ198rzcCYY3hgo933vfH4sQYdxja+r8tdhMo1DU4Aib88bJ11qA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=iscas.ac.cn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789643958;
	bh=PIh/HuC0sqNDglcaATOBIvMfpJ5jUgZCIPEmpZOWsUE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KZyWmVmJXt6wHX6cuVSSM8YYGsDbqlOvaohY66fRFeWJp0Kb7Lbke7LreFx2JB6bq
	 qcY4ZLzQ9kz1TcVjX16YeZqIpmU9BoOzji9MPgRS1q6Nc2Tuq/DQFjrs64LyccKk7K
	 ao0Gsbe9++B2jxHaDYM0FrKt2+qRF9aCr26ZnByTSbU5yT4wzMa9LTZt45SmADvUJK
	 il9kCYYyYPF+nRhJy0ZU1VkrLu3krX6RO/G6bHVucx36F2xtbELjpgo+khLNtCp+Jo
	 JuwnTlY+MuBvRyr1EEnEMYCBFjRKa2POgbbI9hIjdDlO7IXiOj+ViLO5AHjXcC9Gmc
	 6Ce6Ld7vgIMaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D811880F21;
	Thu, 17 Sep 2026 11:19:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF97413D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D158280F21
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6d9Wm0AtGri1 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 11:19:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6549E80F1C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789643957;
 b=ihthkmjop95NP5OZE6MswTjO4kq//OxWBP7YavjfljN4QRsCI2n07Smu1KFXXAsDq7oD
 yq98LWq/ti4SeYLt/tHJdRP+5e58wssScRS/v1PU0dQv3wNc4x/Ed9HT3lWAJoXr4WTJL
 Kk5zH7maAmx1+Gm13/Is1CIHcqr2T8c/yEAPCJ6Rx6a3cY09gSzZrMBxuVn3WTjEkp6Kl
 38TT9On89t4RI0IteDdTj13bSCxrpZ6WaMr1GSPEnfKKqLzrCQ56nVK6X5VrNKfKo1gvu
 ADrl3uBVDcspRitzvlJSxfMANcAeeGDCiouzLisk4A9tJy6+BpedkLGud1zp3DDgazw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789643957;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=PIh/HuC0sqNDglcaATOBIvMfpJ5jUgZCIPEmpZOWsUE=;
 b=H4DubN66I2YV4H+PdJesmNpb1WyiwqudVgpDaWyRcjo/pq+gXyd/feO9NUah5K/wGME4
 i+fT7R4OzclJLSCWfPW4eVeAynKOO6C+fkP31xs6g7ncWHcpGqQ0NCBtCnKkZxpOJSuL/
 dROdh3MQAp7/4xvCMim5DvOBWYI7s/j6yeeNCzOQvklVyDVTGT9oOQX9FBX3Ocp1Ljg1p
 GreDvf/qvGuNu2MnAncSi9uJoF2dy3ed199ClRIWnP5vEmyqLKsebUKD0M/p1lA0FaTE9
 /3kHmnvO3pHcW8NEUvZ9AfwuxhYWOaKBKhgaTETEyto2h/STX+BKc7dxiKn37vDKwyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.25
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.25;
 helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6549E80F1C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:19:15 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowACH8z3SyqtqWUl_CA--.1419S2;
 Thu, 17 Sep 2026 19:11:14 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kalyan.kodamagula@intel.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 michal.swiatkowski@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Date: Thu, 17 Sep 2026 11:11:14 +0000
Message-Id: <20260917111114.2148482-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACH8z3SyqtqWUl_CA--.1419S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4fAryDKry5Ar47AF48Xrb_yoWkZrbE9w
 47Zr93Xr4UuFnYvw4Fkr17u3s29r1UXr9YvayIy393G347Ary5JrykWrn3Xr4IgFWkCa4D
 Zw13uFyfC3W2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbgkYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
 s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
 kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
 Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
 W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
 v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
 I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
 CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
 5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
 W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
 1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
 v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
 vjxU7H7KDUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMNA2qrrRle+gAAsb
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

ice_get_vf_by_id() takes a reference on the VF, which the caller has to
release with ice_put_vf(). The switchdev mode check now happens after
the VF is looked up and returns -EOPNOTSUPP without dropping that
reference, leaking it.

Use the existing out_put_vf label instead.

Fixes: 83b49e7f63da ("ice: check if VF exists before mode check")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..202224dba1a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1384,7 +1384,8 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	if (ice_is_eswitch_mode_switchdev(pf)) {
 		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out_put_vf;
 	}
 
 	ret = ice_check_vf_ready_for_cfg(vf);
-- 
2.34.1


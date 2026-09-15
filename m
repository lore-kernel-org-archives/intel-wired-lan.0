Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D4FC88E53
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 10:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF22D403AE;
	Tue, 15 Sep 2026 10:55:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Arted7h0qt8Z; Tue, 15 Sep 2026 10:55:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 37DB340573
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789469739;
	b=KsGZ2Y/SouuxBLMdBhAccDyyw2+13f7R6Q3Dhet7mkdd/T/8FveFlkV0LcuGgxNofWyg
	 UEBHJoFD7sgh+yRNgkO/IQya4OmQWs9wPk0+FOWHyRiuTaoTbxjtT8ZNmmclRsf2ttAl6
	 R9UH+DLZT6dIoKFJu1Mg6yDu3f/EsXn03g3tXtKlyzJcKzW+S87Pd975NVbid6JpoQKWq
	 wBG+iN3c1e2XEMNSeLHLof3x1fMv0dvX7jIc+TpFmksiC9zEvhwCrTfxIL/D41tuBbas9
	 jVmD+YPiwu2T6oQg2yMvSBZuNcWvyFjPhGliZZd1Agxm0U7ljmQHgHeT7ZYB5xqsfwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789469739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ItMo0Ijf+IBEa3gflKGxVBmdGZlVr9v/TYueIOJl/yc=;
	b=ZrGOcDGtbtutu8BFVxWTUm3viWZsP57KuIXbAS1ZH6wdnjjsx1E+Iro76IvXRaFoVK4s
	 5dQKkW8iXl71ageTQxG9o69/DlPrss+lvQPUlS7r6LG6ZAwtR6AhECAiqFm/CtpSjfCgz
	 WKVahwX4vO3mEaeRdcsuj/m/GoV1PVCiewRB6LcR/naVXFDuvNOsdk4ruh21Y3VUctRK9
	 Zhxb2FHqVqeSWcnMSTk1CfnqDncVC1L2Ply/LppuU0eqHoFegwZafH+3PBE4N1uHLr8Cb
	 o+kKmakWWo0faUUjWI7gp6NN9GjwSwy912Ri8QPoCtZ00AO2EdGQw9FwDdvV+yXCGGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=i3jBU6pZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789469739;
	bh=ItMo0Ijf+IBEa3gflKGxVBmdGZlVr9v/TYueIOJl/yc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tajFyGFT3oO/tcUoa+n8bIi1gK422yCt3xNykeW+f36XSOkDFEQeRe9eE3QLeZqSL
	 Ot+3LzXVBlCWlFQwHNZXEl99Qv6WO1Qer5XdvAIUdSUcVP4K+d18kHLCzSrg+c86+j
	 uWl0wP8H2kP3LgieMIP+sa+eLHPg+gjuPTM3x5J49W9+RJTr2HQC1EGu8uxY2CyUvO
	 ULg7np+JObf7zo1AqpSZ7HxWaC8G0U0U4kVugvz/DLT9ZB004Tph8KLf9/ThPMcuX9
	 FsOvHanl+z1dVugPY4Su2xv9CUH9w/PPBVMzkTaMmlSOThIyrAs2LMy9hXjUIsJTRp
	 Wr5x4IjvkV6Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37DB340573;
	Tue, 15 Sep 2026 10:55:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA68CEB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 10:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D071740573
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 10:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DjvszUKrXD8k for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 10:55:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 94FA8403AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789469737;
 b=pKFAuelTyz/daGx0jpeVEzlQCK1QpP5Ycrg9WKDRj2uFj2lVwJeEOgGS3yIRodGwh3Wo
 BtXryQiFk42tHTDZ7bFHkgfYbHIway6espsCDgIujlCawYDY3EumibZW5KTKPPOTUN+ob
 vYpxzbxCaYga/Smedn7etuwuwu5I5z0JYqRPVWJKCdiHWEnVQslQ8PQgDGGZOKF3j5ry1
 mBfiY00ZwRvxUheqVpL3RqZAZ8BPkP9qxiyRADVeGPAfqW5+VZrPcBx6JoZXbH8/3axt4
 wEtO+9sR9cBcjUSzrXs6TBlpolG/jb2JYKP8z5HVHFPs0K+SYn0m8PfH/knHRrvV8Ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789469737;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=ItMo0Ijf+IBEa3gflKGxVBmdGZlVr9v/TYueIOJl/yc=;
 b=Xt4Fk9tqcA46DH7Hfcfg/4FCUiHJeKGHqjh/Gd6/+7eu18E9N2voi7RRDnJxyRji1yRD
 Aulz0uDSafWPRydwxZ2jsVyLKl6L9bC+1K/MzDq5Ksiti2r5nFD69H9VMK8jgB+b0cirn
 +HSOWYIT4Ua7KiQWhvmCQX56DOigitIp4nIuyPN3M0/QwCSpw1XHaNa95UMQIA2gsJgp6
 F8x2cuh/wxo5izcos/nWLFx+P9c/kanhB3u/WpyuNGT2/PKLk9Cl0enxdo6gosbK4sPJK
 dtC0fUukO4DEvFpymQ6Kz/pqvZddmVdYFCv301UaGN2G3VrWLFZ872H4QALCpAa9cDg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=i3jBU6pZ; 
 arc=none smtp.remote-ip=117.135.210.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.7;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=i3jBU6pZ
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94FA8403AE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=It
 Mo0Ijf+IBEa3gflKGxVBmdGZlVr9v/TYueIOJl/yc=; b=i3jBU6pZgpO2vQjxmk
 1nOMSTpfimMjHXndxqrYWomVbTQt9ex8HnRQjS65wKQmxpOxCDLMabA25eUkA08E
 oY/uwyRO26/xJRHd2QET7VpU6bnPomKqkOmc/06wazG6gRPrJmIX+8BUNTXdPVTh
 S0SQnn0+aFZr5+IRJOC6i0lq0=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3X275I6lqXI5EBQ--.27399S2; 
 Tue, 15 Sep 2026 18:54:50 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference in
 i40e_lan_del_device()
Date: Tue, 15 Sep 2026 18:54:47 +0800
Message-Id: <20260915105447.574951-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3X275I6lqXI5EBQ--.27399S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4fCFW3XFW8GFWUtrWkJFb_yoW8KrW3pr
 W7Ja45CrW5Jw43WayjqFW8uFyrJw40k345Kr13Crs09Fn8tF92yFWYyryrAas3ArWktFnx
 tF9Fya48Ar4DGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UniSLUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBoM4mqpI-o+jwAA33
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

i40e_lan_del_device() dereferences pf->cinst unconditionally. pf->cinst
is only assigned by i40e_client_add_instance(), which resets it to NULL
whenever the i40e_client_instance allocation, i40e_client_get_params()
or i40e_register_auxiliary_dev() fails, and it returns void so
i40e_lan_add_device() cannot report any of that to its caller.

i40e_lan_add_device() can also fail before it ever gets there, for
example when the i40e_device allocation fails, and i40e_probe() only
prints a message instead of clearing I40E_FLAG_IWARP_ENA. i40e_remove()
therefore still calls i40e_lan_del_device() and dereferences a NULL
pf->cinst.

Only tear the auxiliary device down when an instance was actually
created. Removing the PF from the i40e_devices list below does not
depend on it.

Fixes: f4370a85d62e ("i40e: Register auxiliary devices to provide RDMA")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 84a97ca8a6d8..9a4f50af5347 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -496,15 +496,22 @@ int i40e_lan_add_device(struct i40e_pf *pf)
  **/
 int i40e_lan_del_device(struct i40e_pf *pf)
 {
-	struct auxiliary_device *aux_dev = pf->cinst->lan_info.aux_dev;
+	struct auxiliary_device *aux_dev;
 	struct i40e_device *ldev, *tmp;
 	int ret = -ENODEV;
 
-	auxiliary_device_delete(aux_dev);
-	auxiliary_device_uninit(aux_dev);
+	/* i40e_client_add_instance() leaves pf->cinst NULL when it fails,
+	 * so there may be no auxiliary device to tear down here.
+	 */
+	if (pf->cinst) {
+		aux_dev = pf->cinst->lan_info.aux_dev;
 
-	/* First, remove any client instance. */
-	i40e_client_del_instance(pf);
+		auxiliary_device_delete(aux_dev);
+		auxiliary_device_uninit(aux_dev);
+
+		/* First, remove any client instance. */
+		i40e_client_del_instance(pf);
+	}
 
 	mutex_lock(&i40e_device_mutex);
 	list_for_each_entry_safe(ldev, tmp, &i40e_devices, list) {
-- 
2.25.1


Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37550C54F51
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Jul 2026 22:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E51A040A49;
	Tue, 28 Jul 2026 22:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mPTCRVnnwoPn; Tue, 28 Jul 2026 22:17:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE17A40A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785277076;
	bh=Rph2h3dE8sb+UJdXEnVycWrs9s4Lm7LfpmQXzCBdBQc=;
	h=From:To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RNyVY/ayardcW4K+1T9o4ew4QHErTpxM0k6KYhi1l73fsKlnF/FwM5mEa0QvWUQQK
	 8aptsdbtmnGMlRVeKBuDgvHcsn0I02PajYc1e5rgJ0OjFgLMxZRlafbcbhC11TNo2H
	 a/c5yvAqgPYR3BGWDIbqMPLoAbUdTQejhX6Ggd27ME05+8ebQub8i66IlDOA7HAjKu
	 6mkg3opETn4jIi7RFlA2DAf0Ihi4Ah62OXmGXw+g6GEYLAGSoR5xe67Ar9vM75RSfL
	 tY5U952C5tLLBpFe++KIQsYR6YvjTMyDdPxaJyOrTnj96L/iiIzFdNvg6IXUA9vp1w
	 AoeTlacdTh5kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE17A40A54;
	Tue, 28 Jul 2026 22:17:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CDB9845B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 21:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74ED040181
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 21:21:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mf7eyGj2CQZG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Jul 2026 21:21:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.12.53.23;
 helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com;
 envelope-from=prvs=662859186=wanjay@amazon.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4285F40173
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4285F40173
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4285F40173
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 21:21:13 +0000 (UTC)
X-CSE-ConnectionGUID: idheG03mRY+LhvN+EIAPfg==
X-CSE-MsgGUID: 14Rk5fhGQ6mwrdt3wJZ5jQ==
X-IronPort-AV: E=Sophos;i="6.25,191,1779148800"; d="scan'208";a="24401549"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 21:21:13 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:6950]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.26:2525]
 with esmtp (Farcaster)
 id a466488d-2184-44ba-833f-c4bd70da0407; Tue, 28 Jul 2026 21:21:13 +0000 (UTC)
X-Farcaster-Flow-ID: a466488d-2184-44ba-833f-c4bd70da0407
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 28 Jul 2026 21:21:12 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 28 Jul 2026 21:21:12 +0000
From: Jay Wang <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
 <jacob.e.keller@intel.com>, <anthony.l.nguyen@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Kunwu Chan
 <chentao@kylinos.cn>, Wang Haoran <haoranwangsec@gmail.com>, "Amir Mohammad
 Jahangirzad" <a.jahangirzad@gmail.com>, Dawid Osuchowski
 <dawid.osuchowski@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Simon Horman <horms@kernel.org>, Kunwu Chan
 <kunwu.chan@linux.dev>, Rinitha S <sx.rinitha@intel.com>
Date: Tue, 28 Jul 2026 21:21:11 +0000
Message-ID: <20260728212111.30972-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.198.4]
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Mailman-Approved-At: Tue, 28 Jul 2026 22:17:55 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1785273674; x=1816809674;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Rph2h3dE8sb+UJdXEnVycWrs9s4Lm7LfpmQXzCBdBQc=;
 b=G3L/ml6iUER1J84JhFA9q/cXr6Nas2jhkQ/Lb6DDrtGvCYgGA23sqwTn
 EB8UXgosWX6sqvAYmS1CvDKWAc8Y7gtnyws3rvCSv2Qy0UYLjv6aPOjNT
 MZ31ILlZhW+H8+ezLUacdIWAA7uxkwvX0CMUoSfsaST3EcxnqounY2raw
 qsh4c8oPfog2ZY5ImB38dI0GC66TfbHhWM8YBZ//XsZoGdQCHl07nQAf2
 i9sR6PyZMhsyers0ykRQnuJf/WLPUVurD0QvizsEgfn0WDtKr6pR2BYVc
 LUZeJ5wDwPcR9eST0OBIASZb5gII2fUy+YDTKznjgpjVbmh1qQuXnBZC5
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=G3L/ml6i
Subject: [Intel-wired-lan] [PATCH 6.1.y] i40e: remove read access to debugfs
 files
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

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 9fcdb1c3c4ba134434694c001dbff343f1ffa319 ]

The 'command' and 'netdev_ops' debugfs files are a legacy debugging
interface supported by the i40e driver since its early days by commit
02e9c290814c ("i40e: debugfs interface").

Both of these debugfs files provide a read handler which is mostly useless,
and which is implemented with questionable logic. They both use a static
256 byte buffer which is initialized to the empty string. In the case of
the 'command' file this buffer is literally never used and simply wastes
space. In the case of the 'netdev_ops' file, the last command written is
saved here.

On read, the files contents are presented as the name of the device
followed by a colon and then the contents of their respective static
buffer. For 'command' this will always be "<device>: ". For 'netdev_ops',
this will be "<device>: <last command written>". But note the buffer is
shared between all devices operated by this module. At best, it is mostly
meaningless information, and at worse it could be accessed simultaneously
as there doesn't appear to be any locking mechanism.

We have also recently received multiple reports for both read functions
about their use of snprintf and potential overflow that could result in
reading arbitrary kernel memory. For the 'command' file, this is
definitely impossible, since the static buffer is always zero and never
written to. For the 'netdev_ops' file, it does appear to be possible, if
the user carefully crafts the command input, it will be copied into the
buffer, which could be large enough to cause snprintf to truncate, which
then causes the copy_to_user to read beyond the length of the buffer
allocated by kzalloc.

A minimal fix would be to replace snprintf() with scnprintf() which would
cap the return to the number of bytes written, preventing an overflow. A
more involved fix would be to drop the mostly useless static buffers,
saving 512 bytes and modifying the read functions to stop needing those as
input.

Instead, lets just completely drop the read access to these files. These
are debug interfaces exposed as part of debugfs, and I don't believe that
dropping read access will break any script, as the provided output is
pretty useless. You can find the netdev name through other more standard
interfaces, and the 'netdev_ops' interface can easily result in garbage if
you issue simultaneous writes to multiple devices at once.

In order to properly remove the i40e_dbg_netdev_ops_buf, we need to
refactor its write function to avoid using the static buffer. Instead, use
the same logic as the i40e_dbg_command_write, with an allocated buffer.
Update the code to use this instead of the static buffer, and ensure we
free the buffer on exit. This fixes simultaneous writes to 'netdev_ops' on
multiple devices, and allows us to remove the now unused static buffer
along with removing the read access.

Fixes: 02e9c290814c ("i40e: debugfs interface")
Reported-by: Kunwu Chan <chentao@kylinos.cn>
Closes: https://lore.kernel.org/intel-wired-lan/20231208031950.47410-1-chentao@kylinos.cn/
Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Closes: https://lore.kernel.org/all/CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com/
Reported-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Closes: https://lore.kernel.org/all/20250722115017.206969-1-a.jahangirzad@gmail.com/
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kunwu Chan <kunwu.chan@linux.dev>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
[Adapted to 6.1: context conflict due to 6.1 using pf->vsi[pf->lan_vsi]
 vs i40e_pf_get_main_vsi(pf) in the removed read functions; resolution
 is simply to delete the 6.1 version of those functions.]
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 121 +++---------------
 1 file changed, 19 insertions(+), 102 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index b438cf846c41b..5b59db6a5439c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -57,47 +57,6 @@ static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
  * setup, adding or removing filters, or other things.  Many of
  * these will be useful for some forms of unit testing.
  **************************************************************/
-static char i40e_dbg_command_buf[256] = "";
-
-/**
- * i40e_dbg_command_read - read for command datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- **/
-static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
-				     size_t count, loff_t *ppos)
-{
-	struct i40e_pf *pf = filp->private_data;
-	int bytes_not_copied;
-	int buf_size = 256;
-	char *buf;
-	int len;
-
-	/* don't allow partial reads */
-	if (*ppos != 0)
-		return 0;
-	if (count < buf_size)
-		return -ENOSPC;
-
-	buf = kzalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOSPC;
-
-	len = snprintf(buf, buf_size, "%s: %s\n",
-		       pf->vsi[pf->lan_vsi]->netdev->name,
-		       i40e_dbg_command_buf);
-
-	bytes_not_copied = copy_to_user(buffer, buf, len);
-	kfree(buf);
-
-	if (bytes_not_copied)
-		return -EFAULT;
-
-	*ppos = len;
-	return len;
-}
 
 static char *i40e_filter_state_string[] = {
 	"INVALID",
@@ -1636,7 +1595,6 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 static const struct file_operations i40e_dbg_command_fops = {
 	.owner = THIS_MODULE,
 	.open =  simple_open,
-	.read =  i40e_dbg_command_read,
 	.write = i40e_dbg_command_write,
 };
 
@@ -1645,47 +1603,6 @@ static const struct file_operations i40e_dbg_command_fops = {
  * The netdev_ops entry in debugfs is for giving the driver commands
  * to be executed from the netdev operations.
  **************************************************************/
-static char i40e_dbg_netdev_ops_buf[256] = "";
-
-/**
- * i40e_dbg_netdev_ops_read - read for netdev_ops datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- **/
-static ssize_t i40e_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
-					size_t count, loff_t *ppos)
-{
-	struct i40e_pf *pf = filp->private_data;
-	int bytes_not_copied;
-	int buf_size = 256;
-	char *buf;
-	int len;
-
-	/* don't allow partal reads */
-	if (*ppos != 0)
-		return 0;
-	if (count < buf_size)
-		return -ENOSPC;
-
-	buf = kzalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOSPC;
-
-	len = snprintf(buf, buf_size, "%s: %s\n",
-		       pf->vsi[pf->lan_vsi]->netdev->name,
-		       i40e_dbg_netdev_ops_buf);
-
-	bytes_not_copied = copy_to_user(buffer, buf, len);
-	kfree(buf);
-
-	if (bytes_not_copied)
-		return -EFAULT;
-
-	*ppos = len;
-	return len;
-}
 
 /**
  * i40e_dbg_netdev_ops_write - write into netdev_ops datum
@@ -1699,35 +1616,36 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 					 size_t count, loff_t *ppos)
 {
 	struct i40e_pf *pf = filp->private_data;
+	char *cmd_buf, *buf_tmp;
 	int bytes_not_copied;
 	struct i40e_vsi *vsi;
-	char *buf_tmp;
 	int vsi_seid;
 	int i, cnt;
 
 	/* don't allow partial writes */
 	if (*ppos != 0)
 		return 0;
-	if (count >= sizeof(i40e_dbg_netdev_ops_buf))
-		return -ENOSPC;
 
-	memset(i40e_dbg_netdev_ops_buf, 0, sizeof(i40e_dbg_netdev_ops_buf));
-	bytes_not_copied = copy_from_user(i40e_dbg_netdev_ops_buf,
-					  buffer, count);
-	if (bytes_not_copied)
+	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
+	if (!cmd_buf)
+		return count;
+	bytes_not_copied = copy_from_user(cmd_buf, buffer, count);
+	if (bytes_not_copied) {
+		kfree(cmd_buf);
 		return -EFAULT;
-	i40e_dbg_netdev_ops_buf[count] = '\0';
+	}
+	cmd_buf[count] = '\0';
 
-	buf_tmp = strchr(i40e_dbg_netdev_ops_buf, '\n');
+	buf_tmp = strchr(cmd_buf, '\n');
 	if (buf_tmp) {
 		*buf_tmp = '\0';
-		count = buf_tmp - i40e_dbg_netdev_ops_buf + 1;
+		count = buf_tmp - cmd_buf + 1;
 	}
 
-	if (strncmp(i40e_dbg_netdev_ops_buf, "change_mtu", 10) == 0) {
+	if (strncmp(cmd_buf, "change_mtu", 10) == 0) {
 		int mtu;
 
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[11], "%i %i",
+		cnt = sscanf(&cmd_buf[11], "%i %i",
 			     &vsi_seid, &mtu);
 		if (cnt != 2) {
 			dev_info(&pf->pdev->dev, "change_mtu <vsi_seid> <mtu>\n");
@@ -1749,8 +1667,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "Could not acquire RTNL - please try again\n");
 		}
 
-	} else if (strncmp(i40e_dbg_netdev_ops_buf, "set_rx_mode", 11) == 0) {
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[11], "%i", &vsi_seid);
+	} else if (strncmp(cmd_buf, "set_rx_mode", 11) == 0) {
+		cnt = sscanf(&cmd_buf[11], "%i", &vsi_seid);
 		if (cnt != 1) {
 			dev_info(&pf->pdev->dev, "set_rx_mode <vsi_seid>\n");
 			goto netdev_ops_write_done;
@@ -1770,8 +1688,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "Could not acquire RTNL - please try again\n");
 		}
 
-	} else if (strncmp(i40e_dbg_netdev_ops_buf, "napi", 4) == 0) {
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[4], "%i", &vsi_seid);
+	} else if (strncmp(cmd_buf, "napi", 4) == 0) {
+		cnt = sscanf(&cmd_buf[4], "%i", &vsi_seid);
 		if (cnt != 1) {
 			dev_info(&pf->pdev->dev, "napi <vsi_seid>\n");
 			goto netdev_ops_write_done;
@@ -1789,21 +1707,20 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "napi called\n");
 		}
 	} else {
-		dev_info(&pf->pdev->dev, "unknown command '%s'\n",
-			 i40e_dbg_netdev_ops_buf);
+		dev_info(&pf->pdev->dev, "unknown command '%s'\n", cmd_buf);
 		dev_info(&pf->pdev->dev, "available commands\n");
 		dev_info(&pf->pdev->dev, "  change_mtu <vsi_seid> <mtu>\n");
 		dev_info(&pf->pdev->dev, "  set_rx_mode <vsi_seid>\n");
 		dev_info(&pf->pdev->dev, "  napi <vsi_seid>\n");
 	}
 netdev_ops_write_done:
+	kfree(cmd_buf);
 	return count;
 }
 
 static const struct file_operations i40e_dbg_netdev_ops_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = i40e_dbg_netdev_ops_read,
 	.write = i40e_dbg_netdev_ops_write,
 };
 
-- 
2.47.3


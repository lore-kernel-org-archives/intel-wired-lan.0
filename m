Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DEDC5AC7A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 23:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5AD140903;
	Thu,  6 Aug 2026 23:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VvVDkzR2C9ri; Thu,  6 Aug 2026 23:29:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5A8340904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786058970;
	bh=m4AcnQRhEDZ+EydrdS5Nv+6C2yrHGgiq+Zc/wRZ1zzY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=51HKi5ogG6SW9gIPbHXzD4QdKPIrFXqCnam85H7nAVax+IgfoNdtuqZ0OEuV4p0gj
	 cAjpafu3XPRZNkkT6XcLNo+sdO/2Qcp54SBmQ5lTYBj6baw5FQpRJrYKAcV5lNAodb
	 RI08sTg5tCVGyUy3yaRUdNPXvm7op4Q9OPFEwdLVHfsxyk29E5KanIEQ8xc4+oGzc1
	 GRQXJ/n8jJPeykQcNEFuSpC0enzLT9rJgystBpKlFvw5vZWVdO9PruHrsgNNw9e5vO
	 QKRfwzUxiNghyK5EBB7l/Q6He5RtHcs05Xdi+rfbxUquQnW7lBeaI5h2MwGBRqQ5kZ
	 zuCYeotVPa0Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5A8340904;
	Thu,  6 Aug 2026 23:29:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F653392
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3571E605E6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RAbx9dFNnBHD for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 23:29:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 64425605C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64425605C9
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64425605C9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:28 +0000 (UTC)
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6689402c7bfso3196353d50.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 16:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786058967; x=1786663767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m4AcnQRhEDZ+EydrdS5Nv+6C2yrHGgiq+Zc/wRZ1zzY=;
 b=OycjSmYqfuMAjgZE4Pta6z5hZLqeclRiiIEy3BqVRqbMjB8EexbHGUJoCwgup8Pqg8
 BioJF9m3x4wF4qAaQtKYOfD+gmxzAo89pm+/fCasY+PwgPrTYjiS1/0Dj6S/yXbmdgff
 FAbM9mkVPvOU8C1jaX1eFui0VxUjJazRqZCBjei9MikrhPmeBKI36+2lbiaeZEFZezIs
 70yPunAuGLPtM8BNg26M2v5S5AZS6i+6xLpnSvi3APixFiZlCy2WrBuWgg4pw7392gpR
 UAhwGE6mmN4gQSdZeqNp+iXGLn5Z67Cc2INMqd58lHYca51VC5RwxFDYBkDhNUUyXgXu
 yp9A==
X-Gm-Message-State: AOJu0YyCPcE1tzCCApMTLLwx8FcpBH7/a2BUzjgKl9tMkqKc5eIn6OsE
 FYJLmaGbfa5VeFPvTn79YqSeEL4MwHwWuP7GP0v/5yWhuyDsw8zgRcypzCRUsg==
X-Gm-Gg: AR+sD126nciPnZ4x/6CoN7hrUSzltiILb6Kcy8EWRY8WpHcL5ailCMwd2q2iByl3MTP
 9DeEmJhy7IuCpTgV//b1yXLjLQUr/9RzaPWNpr6CoX/hxQrVqqncJYZ2sfgOgcdehV9LWBXCcwR
 UW+f6O5JK6J2eWqCRVZa5LjcjpaPFfPuDzzra60pEMlMde1gQmGAOX4PcmhpDHnwlDHrI55rwk5
 NCS5+7+QDtGBv/20DWSjL/qdn9gPwhBMzFDuiisk3gubbWmLfF39++uk9ZllDq2MzxnH5HH3DBb
 ej9ITURHYowMMrYYV7RpWgSMKobP/FVC1kyoDxsNCuieBTZLZBPiC/ooXEVnyhpnmIf3P22wVFi
 6mKdBFHcYJ9dXa+bb44QFcCDIbQl2KlNBk7PgzMwR/dkw+1romgv8HdUZqJC6OV7aNHUythCo20
 QDVmAx2ppado/Kk7qTkrsp9a9Ra/ZcvDqoGIU/09CMoN+tQo2/ApHi/z5inAdzt8KlpOtCLr4Q9
 G/NvJBfI4Ig12ge0nA7gcT9ZTYVIuaxPqkuPXcyv4TUTe4mKBhhybFDii4=
X-Received: by 2002:a05:690e:4553:10b0:668:8dfd:8c7f with SMTP id
 956f58d0204a3-6699ab5702fmr8625314d50.43.1786058967110; 
 Thu, 06 Aug 2026 16:29:27 -0700 (PDT)
Received: from willemb.c.googlers.com.com
 (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:29:26 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
Date: Thu,  6 Aug 2026 19:26:01 -0400
Message-ID: <20260806232913.4020403-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786058967; x=1786663767; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m4AcnQRhEDZ+EydrdS5Nv+6C2yrHGgiq+Zc/wRZ1zzY=;
 b=ZZ8UbvGYNa2/NCkfHOIiliZHfZ6kIBXnhR58eySxmwhjb93gXdTLQmmEz+cpe8mzdQ
 A/QBYSMycmVlU/ejnUp68aT1Jg9pMwdPgbnOTzYhMwRd82DbtBF88pRksL3QuuEDcNWl
 9WOM0wddhKeqtDwxJuNH++Z/QViLsNnVw8X0+zkI87Oi9/AwSYbtZvL1bqOn97UyoSJ8
 6dyOZSdmH6gpdRXQSTRYgmILss/KsBf1Gm4ykgKOQJ5OqJU0jGql45u0HKivpBYtqWxT
 hYlBGNHWux06AggyXXg8Xn9ZsW8YOf13yvrwqk7KvcTheT9N4q8OQvtdz7Oh3OdA95KC
 mo+Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZZ8UbvGY
Subject: [Intel-wired-lan] [PATCH net-next v4 4/6] selftests: drv-net:
 refactor so_txtime errqueue handling
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

From: Willem de Bruijn <willemb@google.com>

Prepare error queue handling for upcoming SO_EE_ORIGIN_TIMESTAMPING
messages in the next patch in this series.

Convert do_recv_errqueue_timeout into dispatcher do_recv_errqueue
and move SO_EE_ORIGIN_TXTIME specific code into a separate helper.

This will make the next patch a lot more readable.

No functional changes.

Signed-off-by: Willem de Bruijn <willemb@google.com>

--

Changes
  v3 -> v4
    - rename func to do_recv_errqueue_txtime
---
 .../testing/selftests/drivers/net/so_txtime.c | 66 ++++++++++---------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 55a386f3d1b9..f6f3253ed174 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -158,7 +158,40 @@ static void do_recv_verify_empty(int fdr)
 		error(1, 0, "recv: not empty as expected (%d, %d)", ret, errno);
 }
 
-static int do_recv_errqueue_timeout(int fdt)
+static int do_recv_errqueue_txtime(struct sock_extended_err *err,
+				   const char payload_char)
+{
+	const char *reason = NULL;
+	int64_t tstamp = 0;
+
+	switch (err->ee_errno) {
+	case ECANCELED:
+		if (err->ee_code != SO_EE_CODE_TXTIME_MISSED)
+			error(1, 0, "errqueue: unknown ECANCELED %u\n",
+			      err->ee_code);
+		reason = "missed txtime";
+	break;
+	case EINVAL:
+		if (err->ee_code != SO_EE_CODE_TXTIME_INVALID_PARAM)
+			error(1, 0, "errqueue: unknown EINVAL %u\n",
+			      err->ee_code);
+		reason = "invalid txtime";
+	break;
+	default:
+		error(1, 0, "errqueue: errno %u code %u\n",
+		      err->ee_errno, err->ee_code);
+	}
+
+	tstamp = ((int64_t)err->ee_data) << 32 | err->ee_info;
+	tstamp -= (int64_t)glob_tstart;
+	tstamp /= 1000 * 1000;
+	fprintf(stderr, "send: pkt %c at %" PRId64 "ms dropped: %s\n",
+		payload_char, tstamp, reason);
+
+	return 1;
+}
+
+static int do_recv_errqueue(int fdt)
 {
 	char control[CMSG_SPACE(sizeof(struct sock_extended_err)) +
 		     CMSG_SPACE(sizeof(struct sockaddr_in6))] = {0};
@@ -169,7 +202,6 @@ static int do_recv_errqueue_timeout(int fdt)
 	struct msghdr msg = {0};
 	struct iovec iov = {0};
 	struct cmsghdr *cm;
-	int64_t tstamp = 0;
 
 	iov.iov_base = data;
 	iov.iov_len = sizeof(data);
@@ -181,8 +213,6 @@ static int do_recv_errqueue_timeout(int fdt)
 	msg.msg_controllen = sizeof(control);
 
 	while (1) {
-		const char *reason = NULL;
-
 		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
 		if (ret == -1 && errno == EAGAIN)
 			break;
@@ -201,33 +231,9 @@ static int do_recv_errqueue_timeout(int fdt)
 		if (err->ee_origin != SO_EE_ORIGIN_TXTIME)
 			error(1, 0, "errqueue: origin 0x%x\n", err->ee_origin);
 
-		switch (err->ee_errno) {
-		case ECANCELED:
-			if (err->ee_code != SO_EE_CODE_TXTIME_MISSED)
-				error(1, 0, "errqueue: unknown ECANCELED %u\n",
-				      err->ee_code);
-			reason = "missed txtime";
-		break;
-		case EINVAL:
-			if (err->ee_code != SO_EE_CODE_TXTIME_INVALID_PARAM)
-				error(1, 0, "errqueue: unknown EINVAL %u\n",
-				      err->ee_code);
-			reason = "invalid txtime";
-		break;
-		default:
-			error(1, 0, "errqueue: errno %u code %u\n",
-			      err->ee_errno, err->ee_code);
-		}
-
-		tstamp = ((int64_t) err->ee_data) << 32 | err->ee_info;
-		tstamp -= (int64_t) glob_tstart;
-		tstamp /= 1000 * 1000;
-		fprintf(stderr, "send: pkt %c at %" PRId64 "ms dropped: %s\n",
-			data[ret - 1], tstamp, reason);
-
+		num_tstamp += do_recv_errqueue_txtime(err, data[ret - 1]);
 		msg.msg_flags = 0;
 		msg.msg_controllen = sizeof(control);
-		num_tstamp++;
 	}
 
 	return num_tstamp;
@@ -245,7 +251,7 @@ static void recv_errqueue_msgs(int fdt)
 			error(1, errno, "poll");
 
 		if (ret && (pfd.revents & POLLERR))
-			num_tstamp += do_recv_errqueue_timeout(fdt);
+			num_tstamp += do_recv_errqueue(fdt);
 
 		if (num_tstamp == cfg_num_pkt)
 			break;
-- 
2.55.0.679.g6767b8d81c-goog


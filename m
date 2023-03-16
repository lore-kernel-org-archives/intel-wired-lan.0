Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE72C6FD1F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Mar 2023 15:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AB1681F7F;
	Thu, 16 Mar 2023 15:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AB1681F7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678979644;
	bh=7vc01dkHnlSeeuX0FMZex1pCovBalDqNjqEHAeh8Ik0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:Cc:From;
	b=RCToGB7MyEoOg4Qs4ZRVBX1TcpBr7g1fTb/7ikE9605iSH2bFY5GoYNOfhiQynZ3k
	 i4Se+pEZ3BBT+j3i7rQDFctQwCCtAyYTpYCXkuOBbJd4Lp+DfT6REOpwNWmOqHRAnP
	 g21QZhKEOFt/TC4ccsUE9Vbop01zaqZQPVaMcb6/AgEIvokbMg/7CCVUhmAIur1dEw
	 +upBqva7o+GntmSr0QksieV08qsafWoJG8Pr9LOMpYq0aLfoE25eIJdYOeuktrNRH7
	 W/FApK6EMrqKfiWWoRA6QQr0mmaF/x0vCuwUTCIa4isRgiHg0Cbq+ya8eGVhwMpSeB
	 MK6Gk/COA0Pdg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ey1-kxCiVftj; Thu, 16 Mar 2023 15:14:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31E9A81951;
	Thu, 16 Mar 2023 15:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31E9A81951
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 698161BF473
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Mar 2023 10:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37F8E60B0F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Mar 2023 10:57:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37F8E60B0F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K1n9w6u-5lg0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Mar 2023 10:57:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69B46610BD
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69B46610BD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Mar 2023 10:57:50 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32G9nNlO006145; Thu, 16 Mar 2023 10:55:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbsp13s59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Mar 2023 10:55:36 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32GARZTS026173;
 Thu, 16 Mar 2023 10:55:36 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbsp13s3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Mar 2023 10:55:35 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32G1dJX9001150;
 Thu, 16 Mar 2023 10:55:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pbsmrgf2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Mar 2023 10:55:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 32GAtTlv44433682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Mar 2023 10:55:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2A6120043;
 Thu, 16 Mar 2023 10:55:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54B7220040;
 Thu, 16 Mar 2023 10:55:27 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 16 Mar 2023 10:55:27 +0000 (GMT)
Date: Thu, 16 Mar 2023 16:25:26 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <20230316105526.GH1005120@linux.vnet.ibm.com>
References: <20230315072019.GG1005120@linux.vnet.ibm.com>
 <f59701c0-3cf1-8053-2790-4a543ac4f461@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f59701c0-3cf1-8053-2790-4a543ac4f461@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YoBWzne-AGpI5mg3tI1NeRCKZDxzNv_k
X-Proofpoint-ORIG-GUID: tn3_PS5-vYKxDjHTdP9K4hJ-TkG9j5WM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_07,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160085
X-Mailman-Approved-At: Thu, 16 Mar 2023 15:13:55 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=7zUVLqfgkxlB/CvIYtJSDlbWyrbMGiJIYvxL53W0EtM=;
 b=PL08ZsD+XtRM09GxqYDQj39mqLXK8twanm7rwQqnIQfwioUlu8HBi0o0Aglcuj1RSBMW
 Tta74D7W0va/3zRGoMytz/7QIWFORrhqDDBiQ1xAsPZixxzWKOSTJPUtf/4p1EgT/1dC
 5ne0FkzdJwCC7siVMR9QsX65QmXpiuJa3Lw0G4XiFHqkPP2lICNkZc3Pp/XyYkmJEkU6
 77iPpJiAXoNyPD/NUkXXH1ulGqxFK9LZ1M8BX1lS1vJcuZ0jN3xKfjVl36LR+aKXspqx
 Ibvd99uv/XQXvlKADPpOmaH4NIbmTA8thfyWigMu+31RVbk3bv1CUOpAi7unR7supj2S UA== 
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com
 header.a=rsa-sha256 header.s=pp1 header.b=PL08ZsD+
Subject: Re: [Intel-wired-lan] igc driver causes suspend to fail if
 powersave is enabled
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
 "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Avivi,
 Amir" <amir.avivi@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

* Neftin, Sasha <sasha.neftin@intel.com> [2023-03-15 21:04:07]:

> On 3/15/2023 09:20, Srikar Dronamraju wrote:
> > Hi,
> >
> > On Lenovo ThinkPad P15 Gen 2i with I225-LM Ethernet card running Fedora 37
> > kernel 6.1.13-200.fc37.x86_64, running powertop --auto-tune causes suspend
> > and reboot to fail. Once suspend fails, networking stops working even for
> > wireless. Infact as a normal user, I cant even start a sudo session after
> > trying to suspend.
> Hello,
> Is the i225 card on board (under PCH downstream port) or connected via
> thunderbolt?
> Did you see the same problem on other platforms?
> I will forward this inquiry to our PAE.>

I dont think its connected to thunderbolt. But I am not sure.
So, can you let me know how do I figure this out?

Some additional information if that helps

$ lspci -vt
-[0000:00]-+-00.0  Intel Corporation 11th Gen Core Processor Host Bridge/DRAM Registers
           +-01.0-[01]--+-00.0  NVIDIA Corporation TU117GLM [T1200 Laptop GPU]
           |            \-00.1  NVIDIA Corporation Device 10fa
           +-02.0  Intel Corporation TigerLake-H GT1 [UHD Graphics]
           +-04.0  Intel Corporation TigerLake-LP Dynamic Tuning Processor Participant
           +-06.0-[04]----00.0  Micron Technology Inc Device 5407
           +-07.0-[20-49]--
           +-07.1-[50-79]--
           +-0d.0  Intel Corporation Tiger Lake-H Thunderbolt 4 USB Controller
           +-0d.2  Intel Corporation Tiger Lake-H Thunderbolt 4 NHI #0
           +-14.0  Intel Corporation Tiger Lake-H USB 3.2 Gen 2x1 xHCI Host Controller
           +-14.2  Intel Corporation Tiger Lake-H Shared SRAM
           +-16.0  Intel Corporation Tiger Lake-H Management Engine Interface
           +-16.3  Intel Corporation Device 43e3
           +-1c.0-[1c]--
           +-1c.4-[0b]----00.0  Intel Corporation Ethernet Controller I225-LM
           +-1c.5-[09]----00.0  Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz
           +-1c.7-[0a]----00.0  Genesys Logic, Inc GL9755 SD Host Controller
           +-1f.0  Intel Corporation Device 4389
           +-1f.3  Intel Corporation Tiger Lake-H HD Audio Controller
           +-1f.4  Intel Corporation Tiger Lake-H SMBus Controller
           \-1f.5  Intel Corporation Tiger Lake-H SPI Controller

I can use ethernet even after removing thunderbolt module.

Even when loaded, o/p of
$ lsmod | grep -e thunderbolt -e igc
thunderbolt           397312  0
igc                   163840  0

I dont have any other platform with the same Ethernet Controller device.

--
Thanks and Regards
Srikar Dronamraju
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

From: Simon Barber <simon.d.barber@gmail.com>
Date: Tue, 9 Jul 2019 15:59:46 +0100
Subject: [Intel-wired-lan] ibg i210 tx hang will PCIE_ASPM configured
Message-ID: <CAJQj_PrxS3OrPVfopuOQtpJkSt1G4MautCMgTBG0pvB5rYondw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I am are seeing a hang on the transmit side of an  i210 when we have
PCIE_ASPM configured in  the kernel build. i210 is also shared with a bmc.

The kernel is 4.14 based. If I remove the configuration of APSM in the
kernel build I  don't experience the hang. This is with a kernel based
driver rather than a DPDK driver which also experiences the same problem.

Is there a know problem with ASPM and its interaction with the  i210


Simon
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190709/19612c0e/attachment.html>

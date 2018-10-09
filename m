From: Jags N <jagsnn@gmail.com>
Date: Tue, 9 Oct 2018 22:23:35 +0530
Subject: [Intel-wired-lan] fm10k driver - flow control question
Message-ID: <CALQkTo1P_QAyW+y_LE=LFK=y+oDfScqZJLxjdn7eifofNbycAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

In FM10k intel data sheet, I see that the PCIe End Point (PEP) does not
support generation of link based flow control or class based/priority based
flow control pause frames to prevent Host Congestion.

The same behaviour is oberved in dpdk 18.08 fm10k driver, wherein there is
no pfc get or set driver functions defined, which I believe is consistent
with data sheet.

But, in FM10K linux driver ver 0.26.1 (latest), there is code for setting
dcb ets, pfc, dcbx. So I am a bit confused as to how the fm10k driver could
support pfc if the hardware data sheet does not mention about it.

Could someone help me understand or provide any pointers to documents that
details what kind of support is present in 0.26.1 with respect to pfc on
PEP, and if fm10k can support pfc setting/getting on PEP interface to
protect Host Congestion.

Regards,
Jagdish
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181009/8d561978/attachment.html>

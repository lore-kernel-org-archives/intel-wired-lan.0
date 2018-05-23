From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 23 May 2018 07:31:52 -0400
Subject: [Intel-wired-lan] [PATCH v2 1/1] drivers core: multi-threading
 device shutdown
In-Reply-To: <20180523104029.GC15312@amd>
References: <20180505154040.28614-1-pasha.tatashin@oracle.com>
 <20180505154040.28614-2-pasha.tatashin@oracle.com>
 <20180523104029.GC15312@amd>
Message-ID: <CAGM2reb8emos6F+zqKLxDg4u23PHXC=phUbDiJH2YU8k_DtFMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Pavel,

Thank you for looking at this patch. BTW, the version 5 is out. The latest
thread is anchered here:
http://lkml.kernel.org/r/20180516024004.28977-1-pasha.tatashin at oracle.com

> ixgbe is network card, right? So ... it does not have any persistent
> state and no moving parts, and there's no reason we could not "just
> power it down"?

True to what you said, but the same path is used for both regular reboot,
and kexec reboot. In the later case we want to make sure that devices are
quieced and do not send any interrupts, do not do any DMA activity, and
basically in the same state as when system was first cold booted, so the
driver initializing functions can pick and bring the devices up. My
understanding is that because we do not want to diverge the regular reboot
and kexec reboot, we do it for both cases.

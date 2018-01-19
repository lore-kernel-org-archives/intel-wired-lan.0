From: Shrikrishna Khare <skhare@shri-linux.eng.vmware.com>
Date: Thu, 18 Jan 2018 18:42:05 -0800
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <20180118072741.hlkepaeibppz7uih@f1.synalogic.ca>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <20180118072741.hlkepaeibppz7uih@f1.synalogic.ca>
Message-ID: <alpine.DEB.2.10.1801181835490.23969@shri-linux.eng.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On Thu, 18 Jan 2018, Benjamin Poirier wrote:

> On 2018/01/18 15:50, Benjamin Poirier wrote:
> > It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> > 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> > overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> > e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> > on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> > icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.
> > 
> > Some experimentation showed that this flaw in vmware e1000e emulation can
> > be worked around by not setting Other in EIAC. This is how it was before
> > 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
> 
> vmware folks, please comment.

Thank you for bringing this to our attention.

Using the reported build (ESX 6.5, 7526125) and 4.15.0-rc8+ kernel (which 
has the said patch), I could bring up e1000e interface (version: 3.2.6-k),
get dhcp address and even do large file downloads without difficulty.

Could you give us more pointers on how we may be able to reproduce this 
locally? Was there anything different with the configuration when the 
issue was observed? Is the issue consistently reproducible?

Thanks,
Shri

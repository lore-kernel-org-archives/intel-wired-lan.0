From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Thu, 18 Jan 2018 16:41:20 +0900
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <20180118065054.29844-1-bpoirier@suse.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
Message-ID: <20180118074120.j7qbmapusiypsvsq@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/01/18 15:50, Benjamin Poirier wrote:
> It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.
                 (_INT_ASSERTED | _LSC)

> 
> Some experimentation showed that this flaw in vmware e1000e emulation can
> be worked around by not setting Other in EIAC. This is how it was before
> 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
> 
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

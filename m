From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Mon, 21 Aug 2017 10:17:15 -0700
Subject: [Intel-wired-lan] [PATCH 5/5] e1000e: Avoid receiver overrun
	interrupt bursts
In-Reply-To: <20170721183627.13373-5-bpoirier@suse.com>
References: <20170721160937.GA22632@csclub.uwaterloo.ca>
 <20170721183627.13373-1-bpoirier@suse.com>
 <20170721183627.13373-5-bpoirier@suse.com>
Message-ID: <20170821171715.iutchfoz3ksutcvw@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2017/07/21 11:36, Benjamin Poirier wrote:
> When e1000e_poll() is not fast enough to keep up with incoming traffic, the
> adapter (when operating in msix mode) raises the Other interrupt to signal
> Receiver Overrun.
> 
> This is a double problem because 1) at the moment e1000_msix_other()
> assumes that it is only called in case of Link Status Change and 2) if the
> condition persists, the interrupt is repeatedly raised again in quick
> succession.
> 
> Ideally we would configure the Other interrupt to not be raised in case of
> receiver overrun but this doesn't seem possible on this adapter. Instead,
> we handle the first part of the problem by reverting to the practice of
> reading ICR in the other interrupt handler, like before commit 16ecba59bc33
> ("e1000e: Do not read ICR in Other interrupt"). Thanks to commit
> 0a8047ac68e5 ("e1000e: Fix msi-x interrupt automask") which cleared IAME
> from CTRL_EXT, reading ICR doesn't interfere with RxQ0, TxQ0 interrupts
> anymore. We handle the second part of the problem by not re-enabling the
> Other interrupt right away when there is overrun. Instead, we wait until
> traffic subsides, napi polling mode is exited and interrupts are
> re-enabled.
> 
> Reported-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Fixes: 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

What's the status on these patches please? One month later they still
show up as "new" in patchwork.

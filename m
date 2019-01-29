From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Tue, 29 Jan 2019 11:14:11 -0800
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix potential RX buffer
 starvation for AF_XDP
In-Reply-To: <1548770630-16189-1-git-send-email-magnus.karlsson@intel.com>
References: <1548770630-16189-1-git-send-email-magnus.karlsson@intel.com>
Message-ID: <20190129111411.3a4c3599@cakuba.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 29 Jan 2019 15:03:50 +0100, Magnus Karlsson wrote:
> When the RX rings are created they are also populated with buffers so
> that packets can be received. Usually these are kernel buffers, but
> for AF_XDP in zero-copy mode, these are user-space buffers and in this
> case the application might not have sent down any buffers to the
> driver at this point. And if no buffers are allocated at ring creation
> time, no packets can be received and no interupts will be generated so
> the napi poll function that allocates buffers to the rings will never
> get executed.
> 
> To recitfy this, we kick the NAPI context of any queue with an
> attached AF_XDP zero-copy socket in two places in the code. Once after
> an XDP program has loaded and once after the umem is registered.  This
> take care of both cases: XDP program gets loaded first then AF_XDP
> socket is created, and the reverse, AF_XDP socket is created first,
> then XDP program is loaded.
> 
> Fixes: d0bcacd0a130 ("ixgbe: add AF_XDP zero-copy Rx support")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

I may not understand the problem fully, but isn't it kind of normal
that if you create a ring empty you'll never receive packets?  And it
should be reasonably easy to catch while writing an app from scratch
(i.e. it behaves deterministically).

Plus user space can already do the kick manually: create the ring empty,
attach prog, put packets on the ring, and kick xmit - that would work,
no?

Putting the kick in ixgbe_xdp_setup() seems a tiny bit random to me,
but perhaps I'm not seeing the rationale clearly.

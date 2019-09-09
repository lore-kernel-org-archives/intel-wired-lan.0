From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Sep 2019 21:19:17 +0000
Subject: [Intel-wired-lan] [PATCH v2] i40e: fix potential RX buffer
 starvation for AF_XDP
In-Reply-To: <20190909165538.8125-1-jeffrey.t.kirsher@intel.com>
References: <20190909165538.8125-1-jeffrey.t.kirsher@intel.com>
Message-ID: <f8652db1a7654dc6940cb0ebc194278a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, September 9, 2019 9:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2] i40e: fix potential RX buffer starvation
> for AF_XDP
> 
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> When the RX rings are created they are also populated with buffers so that
> packets can be received. Usually these are kernel buffers, but for AF_XDP in
> zero-copy mode, these are user-space buffers and in this case the
> application might not have sent down any buffers to the driver at this point.
> And if no buffers are allocated at ring creation time, no packets can be
> received and no interrupts will be generated so the NAPI poll function that
> allocates buffers to the rings will never get executed.
> 
> To rectify this, we kick the NAPI context of any queue with an attached
> AF_XDP zero-copy socket in two places in the code. Once after an XDP
> program has loaded and once after the umem is registered.
> This take care of both cases: XDP program gets loaded first then AF_XDP
> socket is created, and the reverse, AF_XDP socket is created first, then XDP
> program is loaded.
> 
> Fixes: 0a714186d3c0 ("i40e: add AF_XDP zero-copy Rx support")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



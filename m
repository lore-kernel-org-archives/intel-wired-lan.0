From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 30 Jan 2019 19:41:58 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: fix potential RX buffer
 starvation for AF_XDP
In-Reply-To: <1548770597-16141-1-git-send-email-magnus.karlsson@intel.com>
References: <1548770597-16141-1-git-send-email-magnus.karlsson@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D35402D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Magnus Karlsson
> Sent: Tuesday, January 29, 2019 6:03 AM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> <bjorn.topel@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] i40e: fix potential RX buffer starvation
> for AF_XDP
> 
> When the RX rings are created they are also populated with buffers so that
> packets can be received. Usually these are kernel buffers, but for AF_XDP in
> zero-copy mode, these are user-space buffers and in this case the
> application might not have sent down any buffers to the driver at this point.
> And if no buffers are allocated at ring creation time, no packets can be
> received and no interupts will be generated so the napi poll function that
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
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 13 ++++++++++++-
> drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  5 +++++
>  2 files changed, 17 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



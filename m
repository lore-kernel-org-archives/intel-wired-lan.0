From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 11 Sep 2018 22:00:03 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/4] net: xsk: add a simple buffer
 reuse queue
In-Reply-To: <20180907081848.5438-3-bjorn.topel@gmail.com>
References: <20180907081848.5438-1-bjorn.topel@gmail.com>
 <20180907081848.5438-3-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ECE81@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bj?rn T?pel
> Sent: Friday, September 7, 2018 1:19 AM
> To: ast at kernel.org; daniel at iogearbox.net; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org;
> jakub.kicinski at netronome.com
> Cc: netdev at vger.kernel.org; magnus.karlsson at gmail.com; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 2/4] net: xsk: add a simple buffer reuse
> queue
> 
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> 
> XSK UMEM is strongly single producer single consumer so reuse of frames is
> challenging.  Add a simple "stash" of FILL packets to reuse for drivers to
> optionally make use of.  This is useful when driver has to free (ndo_stop) or
> resize a ring with an active AF_XDP ZC socket.
> 
> v2: Fixed build issues for !CONFIG_XDP_SOCKETS.
> 
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> ---
>  include/net/xdp_sock.h | 69
> ++++++++++++++++++++++++++++++++++++++++++
>  net/xdp/xdp_umem.c     |  2 ++
>  net/xdp/xsk_queue.c    | 55 +++++++++++++++++++++++++++++++++
>  net/xdp/xsk_queue.h    |  3 ++
>  4 files changed, 129 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:29:22 +0000
Subject: [Intel-wired-lan] [next PATCH v5 09/12] igb: Add support for
 using order 1 pages to receive large frames
In-Reply-To: <20170207022659.9864.44658.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022659.9864.44658.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59ABA9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, February 6, 2017 6:27 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v5 09/12] igb: Add support for using
> order 1 pages to receive large frames
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch adds support for using 3K buffers in order 1 pages the same way
> we were using 2K buffers in 4K pages.  We are reserving 1K of room for now
> to have space available for future headroom and tailroom when we enable
> build_skb support.
> 
> One side effect of this patch is that we can end up using a larger buffer
> if jumbo frames is enabled.  The impact shouldn't be too great, but it
> could hurt small packet performance for UDP workloads if jumbo frames is
> enabled as the truesize of frames will be larger.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> v4: Split this code out of patch 6 of the original series.
> 
>  drivers/net/ethernet/intel/igb/igb.h      |   30 +++++++++++++-
>  drivers/net/ethernet/intel/igb/igb_main.c |   64
> +++++++++++++++++++++--------
>  2 files changed, 76 insertions(+), 18 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

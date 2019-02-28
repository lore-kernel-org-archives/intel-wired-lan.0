From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:16:57 +0000
Subject: [Intel-wired-lan] [PATCH S14 07/15] ice: map rx buffer pages
 with DMA attributes
In-Reply-To: <20190213185115.25877-8-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36716C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 13, 2019 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S14 07/15] ice: map rx buffer pages with
> DMA attributes
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Provide DMA_ATTR_WEAK_ORDERING and DMA_ATTR_SKIP_CPU_SYNC
> attributes to the DMA API during the mapping operations on rx side. With
> this change the non-x86 platforms will be able to sync only with what is being
> used (2k buffer) instead of entire page. This should yield a slight
> performance improvement.
> 
> Furthermore, DMA unmap may destroy the changes that were made to the
> buffer by CPU when platform is not a x86 one. DMA_ATTR_SKIP_CPU_SYNC
> attribute usage fixes this issue.
> 
> Also add a sync_single_for_device call during the rx buffer assignment, to
> make sure that the cache lines are cleared before device attempting to write
> to the buffer.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 24 ++++++++++++++++++++----
> drivers/net/ethernet/intel/ice/ice_txrx.h |  3 +++
>  2 files changed, 23 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:27:17 +0000
Subject: [Intel-wired-lan] [next PATCH v5 04/12] igb: Don't bother
 clearing Tx buffer_info in igb_clean_tx_ring
In-Reply-To: <20170207022556.9864.73194.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022556.9864.73194.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59AB49@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, February 6, 2017 6:26 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v5 04/12] igb: Don't bother clearing Tx
> buffer_info in igb_clean_tx_ring
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> In the case of the Tx rings we need to only clear the Tx buffer_info when
> we are resetting the rings.  Ideally we do this when we configure the ring
> to bring it back up instead of when we are taking it down in order to avoid
> dirtying pages we don't need to.
> 
> In addition we don't need to clear the Tx descriptor ring since we will
> fully repopulate it when we begin transmitting frames and next_to_watch
> can
> be cleared to prevent the ring from being cleaned beyond that point instead
> of needing to touch anything in the Tx descriptor ring.
> 
> Finally with these changes we can avoid having to reset the skb member of
> the Tx buffer_info structure in the cleanup path since the skb will always
> be associated with the first buffer which has next_to_watch set.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> v2: Fixed Tx mapping exception path to reset tx_buffer address
> 
>  drivers/net/ethernet/intel/igb/igb.h         |    1
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |   11 ++
>  drivers/net/ethernet/intel/igb/igb_main.c    |  120 ++++++++++++++++------
> ----
>  3 files changed, 83 insertions(+), 49 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

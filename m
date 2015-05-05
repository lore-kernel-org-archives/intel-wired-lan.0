From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 5 May 2015 18:34:44 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] igb: Pull timestamp from fragment
 before adding it to skb
In-Reply-To: <20150423044917.18903.76134.stgit@ahduyck-vm-fedora22>
References: <20150423040941.18903.3545.stgit@ahduyck-vm-fedora22>
 <20150423044917.18903.76134.stgit@ahduyck-vm-fedora22>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DBEBA0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, April 22, 2015 9:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Cong Wang
> Subject: [Intel-wired-lan] [PATCH 1/3] igb: Pull timestamp from fragment
> before adding it to skb
> 
> This change makes it so that we pull the timestamp from the fragment
> before
> we add it to the skb.  By doing this we can avoid a possible issue in
> which
> the fragment can possibly be less than IGB_RX_HDR_LEN due to the timestamp
> being pulled after the copybreak check.
> 
> While making this change I realized we could also pull the rest of the
> igb_pull_tail function into igb_add_rx_frag since in the case of igb,
> unlike ixgbe, we are able to unmap the entire buffer before calling
> add_rx_frag so merging the two allows for sharing of code between the two
> merged functions.
> 
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   94 ++++++++----------------
> -----
>  1 file changed, 25 insertions(+), 69 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

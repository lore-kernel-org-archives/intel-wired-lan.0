From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:27:43 +0000
Subject: [Intel-wired-lan] [next PATCH v5 05/12] igb: Limit maximum
 frame Rx	based on MTU
In-Reply-To: <20170207022608.9864.26216.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022608.9864.26216.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59AB5C@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v5 05/12] igb: Limit maximum frame
> Rx based on MTU
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> In order to support the use of build_skb going forward it will be necessary
> to place a maximum limit on the amount of data we can receive when jumbo
> frames is not enabled.  In order to do this I am adding a new upper limit
> for receive based on the size of a 2K buffer minus padding.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> v5: Fixed bug where RLPML was not set for 82575, i210, and i211 interfaces.
> 
>  drivers/net/ethernet/intel/igb/igb.h      |   10 +++++++++-
>  drivers/net/ethernet/intel/igb/igb_main.c |   21 +++++++++++++++++----
>  2 files changed, 26 insertions(+), 5 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

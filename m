From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:28:27 +0000
Subject: [Intel-wired-lan] [next PATCH v5 07/12] igb: Use page_address
 offset from page instead of masking virtual address
In-Reply-To: <20170207022632.9864.8422.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022632.9864.8422.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59AB7E@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v5 07/12] igb: Use page_address
> offset from page instead of masking virtual address
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Update the handling of page addresses so that we always refer to them
> using
> a void pointer, and try to use the consistent name of va indicating we are
> working with a virtual address.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> v4: Split this code out of patch 6 of the original series.
> 
>  drivers/net/ethernet/intel/igb/igb.h      |    2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c |   11 +++++------
>  drivers/net/ethernet/intel/igb/igb_ptp.c  |    3 +--
>  3 files changed, 7 insertions(+), 9 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 9 Sep 2016 18:44:20 +0000
Subject: [Intel-wired-lan] [next PATCH 2/3] ixgbe: Limit reporting of
 redirection table if SR-IOV is enabled
In-Reply-To: <20160908032817.25312.89293.stgit@localhost.localdomain>
References: <20160908032606.25312.86849.stgit@localhost.localdomain>
 <20160908032817.25312.89293.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FCA4A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, September 07, 2016 8:28 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: ruslan at purestorage.com; Jayakumar, Muthurajan
> <muthurajan.jayakumar@intel.com>; Blevins, Christopher R
> <christopher.r.blevins@intel.com>
> Subject: [Intel-wired-lan] [next PATCH 2/3] ixgbe: Limit reporting of
> redirection table if SR-IOV is enabled
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The hardware redirection table can support more queues then the PF
> currently has when SR-IOV is enabled.  In order to account for this use the
> RSS mask to trim of the bits that are not used.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


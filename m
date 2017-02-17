From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:28:01 +0000
Subject: [Intel-wired-lan] [next PATCH v5 06/12] igb: Only sync size of
 expected frame in ethtool testing
In-Reply-To: <20170207022620.9864.29933.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022620.9864.29933.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59AB71@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v5 06/12] igb: Only sync size of
> expected frame in ethtool testing
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> We only need to sync the size of the frame that is read to test.  We don't
> need to sync the entire Rx buffer.  This way the testing is more consistent
> with how we handle things in the receive path.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> v4: Split this code out of patch 6 of the original series.
> 
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

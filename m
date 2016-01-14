From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:12:29 +0000
Subject: [Intel-wired-lan] [next PATCH 06/11] igb: Merge VLVF
 configuration	into igb_vfta_set
In-Reply-To: <20160107071103.13648.31968.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071103.13648.31968.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F178@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 06/11] igb: Merge VLVF configuration     into igb_vfta_set
> 
> This change makes it so that we can merge the configuration of the VLVF
> registers into the setting of the VFTA register.  By doing this we simplify
> the logic and make use of similar functionality that we have already added
> for ixgbe making it easier to maintain both drivers.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_mac.c |  119 +++++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/igb/e1000_mac.h |    3 -
>  drivers/net/ethernet/intel/igb/igb_main.c  |  105 ++++---------------------
>  3 files changed, 135 insertions(+), 92 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

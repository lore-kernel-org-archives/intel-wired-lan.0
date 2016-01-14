From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:16:37 +0000
Subject: [Intel-wired-lan] [next PATCH 10/11] igb: Enable use of "bridge
 fdb add" to set unicast table entries
In-Reply-To: <20160107071133.13648.51584.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071133.13648.51584.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F1B0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 10/11] igb: Enable use of "bridge fdb add" to set unicast table entries
> 
> This change makes it so that we can use the bridge utility to add a FDB
> entry for the PF to an igb port.  By doing this we can enable the VFs to
> talk to virtual ports residing on top of the PF.
> 
> In addition this should also address issues with MACVLANs trying to reside
> on top of the PF as well as they would have had similar issues when added
> to the PF with SR-IOV enabled.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   39 ++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 9 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

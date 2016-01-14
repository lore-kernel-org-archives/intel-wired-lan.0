From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:14:45 +0000
Subject: [Intel-wired-lan] [next PATCH 08/11] igb: Add support for VLAN
 promiscuous with SR-IOV and NTUPLE
In-Reply-To: <20160107071118.13648.98637.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071118.13648.98637.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F194@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 08/11] igb: Add support for VLAN promiscuous with SR-IOV and NTUPLE
> 
> This change fixes things so that we can fully support SR-IOV or the
> recently added NTUPLE filtering while allowing support for VLAN promiscuous
> mode.  By making this change we are able to support possible scenarios such
> as SR-IOV with the PF connected to a Linux bridge hosting other VMs.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |    1
>  drivers/net/ethernet/intel/igb/igb_main.c |  313 ++++++++++++++++++++++-------
>  2 files changed, 242 insertions(+), 72 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

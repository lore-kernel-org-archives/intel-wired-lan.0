From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:10:57 +0000
Subject: [Intel-wired-lan] [next PATCH 04/11] igb: Do not factor VLANs
 into	RLPML calculation
In-Reply-To: <20160107071046.13648.85457.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071046.13648.85457.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F15B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 04/11] igb: Do not factor VLANs into     RLPML calculation
> 
> The RLPML registers already take the size of VLAN headers into account when
> determining the maximum packet length.  This is called out in EAS documents
> for several parts including the 82576 and the i350.  As such we can drop
> the addition of size to the value programmed into the RLPML registers.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |    1 -
>  drivers/net/ethernet/intel/igb/igb_main.c |   43 +----------------------------
>  2 files changed, 2 insertions(+), 42 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

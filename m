From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:11:25 +0000
Subject: [Intel-wired-lan] [PATCH S40 01/15] iavf: Enable support for up
 to 16 queues
In-Reply-To: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
Message-ID: <87e86f4dc9764af59aecebf2a18edfbd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 01/15] iavf: Enable support for up to 16
> queues
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Previous devices could only allocate 4 MSI-X vectors per VF so there was a
> limitation of 4 queues. 800-series hardware can allocate more than 4 MSI-X
> vectors, so expand the limitation on the number of queues that the driver
> can support to account for these capabilities.
> 
> Fix eththool channel operations to accommodate this change and adjust the
> reporting of max number of queues to what is given to us by the PF. Since
> we're not requesting queues above this value, just trigger reset to activate
> the queues, which we already own.
> 
> Finally, fix a test condition that would display an incorrect error message.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  2 +-
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 20 +++++++-------
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  2 +-
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 27 -------------------
>  4 files changed, 11 insertions(+), 40 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



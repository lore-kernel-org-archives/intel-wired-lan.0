From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:40:58 +0000
Subject: [Intel-wired-lan] [PATCH 6/8] ice: Query the Tx scheduler node
 before adding it
In-Reply-To: <20180920002311.10891-7-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
 <20180920002311.10891-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC3EA@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 6/8] ice: Query the Tx scheduler node
> before adding it
> 
> Query the Tx scheduler tree node information from FW before adding it to
> the driver's software database. This will keep the node information current in
> driver.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  5 ++
>  drivers/net/ethernet/intel/ice/ice_sched.c      | 67
> ++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



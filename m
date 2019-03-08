From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:36:39 +0000
Subject: [Intel-wired-lan] [PATCH S17 15/17] ice: Refactor link event
 flow
In-Reply-To: <20190228232603.32156-16-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
 <20190228232603.32156-16-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368F17@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S17 15/17] ice: Refactor link event flow
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the link event flow works, but can be much better.
> Refactor the link event flow to make it cleaner and more clear on what is
> going on.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 20 +++++++
>  drivers/net/ethernet/intel/ice/ice_main.c | 93 +++++++++++++++------------
> ----
>  2 files changed, 65 insertions(+), 48 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



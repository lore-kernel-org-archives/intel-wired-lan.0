From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 22:35:53 +0000
Subject: [Intel-wired-lan] [next PATCH S13 11/15] i40evf: use
 capabilities	flags properly
In-Reply-To: <1440798961-17326-12-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5EF8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, August 28, 2015 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S13 11/15] i40evf: use capabilities flags
> properly
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Use the capabilities passed to us by the PF driver to control VF driver
> behavior. In the process, clean up the VLAN add/remove code so it's not a
> horrible morass of ifdefs.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I1050eaf12b658a26fea6813047c9964163c70a73
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree

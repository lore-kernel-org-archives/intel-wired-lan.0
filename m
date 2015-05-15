From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 15 May 2015 16:10:28 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2] ixgbevf: add support for
 reporting RSS key and hash table for X550
In-Reply-To: <20150430185055.12162.45551.stgit@localhost6.localdomain6>
References: <20150430185055.12162.45551.stgit@localhost6.localdomain6>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F835369@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, April 30, 2015 11:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH v2] ixgbevf: add support for reporting
> RSS key and hash table for X550
> 
> This patch extends the reporting of the RSS key and hash table by adding support
> for X550 VFs. The difference is that X550 VFs have their own registers for RSS
> key and indirection table, so there is no need to query the PF.
> 
> The RSS key and indirection table are stored in the adapter structure during the
> configuration of VFRSSRK and VFRETA which in turn can be used in ethtool for
> reporting.
> 
> The logic for writing VFRETA is also changed to make sure that the indirection
> table is reported correctly.
> 
> In addition this patch adds defines for the VFRETA entries and number of
> VFRSSRK registers as well as some whitespace cleanups.
> 
> -v2 updated description
> 
> Reported-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c      |   51 ++++++++++++---------
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    9 +++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   21 +++++----
>  3 files changed, 47 insertions(+), 34 deletions(-)

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>


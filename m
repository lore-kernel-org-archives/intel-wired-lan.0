From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 19:45:13 +0000
Subject: [Intel-wired-lan] [PATCH v3 3/4] e1000e: Do not write lsc to
 ics in	msi-x mode
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E25FE7@ORSMSX101.amr.corp.intel.com>
References: <1447113021-1611-1-git-send-email-bpoirier@suse.com>,
 <1447113021-1611-4-git-send-email-bpoirier@suse.com>,
 <309B89C4C689E141A5FF6A0C5FB2118B81E25FE7@ORSMSX101.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E27430@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Benjamin Poirier [bpoirier at suse.com]
> Sent: Monday, November 09, 2015 3:50 PM
> To: Kirsher, Jeffrey T
> Cc: Frank Steiner; linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v3 3/4] e1000e: Do not write lsc to ics in    msi-x mode
>
> In msi-x mode, there is no handler for the lsc interrupt so there is no
> point in writing that to ics now that we always assume Other interrupts
> are caused by lsc.
>
> Reviewed-by: Jasna Hodzic <jhodzic@ucdavis.edu>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/defines.h |  3 ++-
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 27 ++++++++++++++++-----------
>  2 files changed, 18 insertions(+), 12 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

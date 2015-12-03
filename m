From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 19:45:46 +0000
Subject: [Intel-wired-lan] [PATCH v3 2/4] e1000e: Do not read icr in
 Other	interrupt
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E25FD6@ORSMSX101.amr.corp.intel.com>
References: <1447113021-1611-1-git-send-email-bpoirier@suse.com>,
 <1447113021-1611-3-git-send-email-bpoirier@suse.com>,
 <309B89C4C689E141A5FF6A0C5FB2118B81E25FD6@ORSMSX101.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E27440@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Benjamin Poirier [bpoirier at suse.com]
> Sent: Monday, November 09, 2015 3:50 PM
> To: Kirsher, Jeffrey T
> Cc: Frank Steiner; linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v3 2/4] e1000e: Do not read icr in Other      interrupt
>
> removes the icr read in the other interrupt handler, uses eiac to
> autoclear the Other bit from icr and ims. This allows us to avoid
> interference with rx and tx interrupts in the Other interrupt handler.
>
> The information read from icr is not needed. IMS is configured such that
> the only interrupt cause that can trigger the Other interrupt is Link
> Status Change.
>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
>
> ---
> I noticed a 8-16% improvement in netperf rr tests after applying this
> patch. This is a little surprising since this patch touches the handling
> of Other interrupts, which do not occur during such a test. Some
> profiling was not very insightful but the improvement seems related to
> writing Other to EIAC.
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

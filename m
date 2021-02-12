From: Joseph, Jithu <jithu.joseph@intel.com>
Date: Fri, 12 Feb 2021 19:16:53 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 1/9] igc: Fix
 igc_ptp_rx_pktstamp()
In-Reply-To: <578c9ceb86e0d6007cab529c4215372f61d023d3.camel@intel.com>
References: <20210210215848.24514-1-vedang.patel@intel.com>
 <20210210215848.24514-2-vedang.patel@intel.com>
 <578c9ceb86e0d6007cab529c4215372f61d023d3.camel@intel.com>
Message-ID: <f6fb65d0a78b51489323486ca218b2f3d9c441c3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-02-11 at 00:30 +0000, Nguyen, Anthony L wrote:
> On Wed, 2021-02-10 at 13:58 -0800, Vedang Patel wrote:
> > From: Andre Guedes <andre.guedes@intel.com>
> > 
> > The comment describing the timestamps layout in the packet buffer
> > is
> > wrong and the code is actually retrieving the timestamp in Timer 1
> > reference instead of Timer 0. This hasn't been a big issue so far
> > because hardware is configured to report both timestamps using
> > Timer
> > 0
> > (see IGC_SRRCTL register configuration in
> > igc_ptp_enable_rx_timestamp()
> > helper). This patch fixes the comment and the code so we retrieve
> > the
> > timestamp in Timer 0 reference as expected.
> > 
> > This patch also takes the opportunity to get rid of the hw.mac.type
> > check
> > since it is not required.
> > 
> > Fixes: 81b055205e8ba ("igc: Add support for RX timestamping")
> 
> This seems better suited for net. I can split it and send it that
> route, but is there a reason that it needs to stay in this series?
> 

A subsequent patch  in this series (f6ddfa4ba2ed - igc: Refactor Rx
timestamp handling) is dependent on this patch.  

Please go ahead and split this patch from this series and send it via
the "net route" you mention, if that is more appropriate. 

Let us know if you want us to resend the rest of the patches in this
series (without the first patch) .

Jithu

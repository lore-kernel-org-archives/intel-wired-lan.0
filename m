From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 4 May 2015 22:28:43 +0000
Subject: [Intel-wired-lan] [PATCH v2] igb: disable IPv6 extension header
 processing
In-Reply-To: <1429690393.2638.218.camel@jtkirshe-mobl>
References: <20150417182418.13628.80701.stgit@htfujina-fc.jf.intel.com>
 <1429690393.2638.218.camel@jtkirshe-mobl>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DBE237@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, April 22, 2015 1:13 AM
> To: Fujinaka, Todd
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v2] igb: disable IPv6 extension
> header processing
> 
> On Fri, 2015-04-17 at 11:24 -0700, Todd Fujinaka wrote:
> > Disable IPv6 extension header processing as per hardware errata.
> >
> > Also fix copyright date.
> >
> > Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igb/e1000_82575.c   |   12 ++++++++----
> >  drivers/net/ethernet/intel/igb/e1000_defines.h |    3 ++-
> >  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> Thanks Todd, applied.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>


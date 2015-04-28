From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 28 Apr 2015 03:17:41 +0000
Subject: [Intel-wired-lan] [PATCH v1 net-next 1/3] igb: set driver data
 for device entries that were missing
In-Reply-To: <553E58E5.9000105@cumulusnetworks.com>
References: <1428707018-6405-1-git-send-email-jtoppins@cumulusnetworks.com>
 <553E58E5.9000105@cumulusnetworks.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DBB03B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Jonathan Toppins
> Sent: Monday, April 27, 2015 8:42 AM
> To: Kirsher, Jeffrey T
> Cc: Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald
> C; Vick, Matthew; Ronciak, John; Williams, Mitch A; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; gospo at cumulusnetworks.com;
> shm at cumulusnetworks.com
> Subject: Re: [PATCH v1 net-next 1/3] igb: set driver data for device
> entries that were missing
> 
> On 4/10/15 7:03 PM, Jonathan Toppins wrote:
> > Three of the supported PCI device entries neglected to set driver data
> > to "board_82575". This is not a problem until a new board type is
> > defined, so avoid the potential problem all together.
> >
> > Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
> > ---
> >   drivers/net/ethernet/intel/igb/igb_main.c |    6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Well, regression tested that is as I don't have any of the potential new boards.

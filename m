From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 28 Jun 2019 03:20:29 +0000
Subject: [Intel-wired-lan] [PATCH v3] e1000e: PCIm function state support
In-Reply-To: <e54d6835-84bc-17bb-de59-d87c53bd5bb4@intel.com>
References: <20190625143911.37284-1-vitaly.lifshits@intel.com>
 <e54d6835-84bc-17bb-de59-d87c53bd5bb4@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B5493@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Neftin, Sasha
> Sent: Tuesday, June 25, 2019 8:15 AM
> To: Lifshits, Vitaly <vitaly.lifshits@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v3] e1000e: PCIm function state support
> 
> On 6/25/2019 17:39, Vitaly Lifshits wrote:
> > Due to commit: 5d8682588605 ("[misc] mei: me: allow runtime
> > 			pm for platform with D0i3")
> > When disconnecting the cable and reconnecting it the NIC
> > enters DMoff state. This caused wrong link indication
> > and duplex mismatch. This bug is described in:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1689436
> >
> > Checking PCIm function state and performing PHY reset after a
> > timeout in watchdog task solves this issue.
> >
> > Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > ---
> >
> > V2: Fixed typos in commit massage
> > V3: Fixed minor typo
> > ---
> >   drivers/net/ethernet/intel/e1000e/defines.h |  3 +++
> >   drivers/net/ethernet/intel/e1000e/netdev.c  | 18 +++++++++++++++++-
> >   2 files changed, 20 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

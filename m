From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Wed, 3 Aug 2016 20:09:12 +0000
Subject: [Intel-wired-lan] [next PATCH S41 4/5] i40e: Add support for
 ARP NS in X722
In-Reply-To: <754e82ce-75df-56f1-3fdd-d74631d36b5c@onemain.com>
References: <1470244815-31174-1-git-send-email-bimmy.pujari@intel.com>
 <1470244815-31174-5-git-send-email-bimmy.pujari@intel.com>
 <754e82ce-75df-56f1-3fdd-d74631d36b5c@onemain.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6265024985B@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Wednesday, August 03, 2016 11:12 AM
> To: Pujari, Bimmy <bimmy.pujari@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [next PATCH S41 4/5] i40e: Add support for ARP
> NS in X722
> 
> 
> 
> On 08/03/2016 10:20 AM, Bimmy Pujari wrote:
> > From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> >
> > This patch adds support and interface for supporting ARP NS
> > proxy offload in firmware for X722.
> 
> This looks like it fixes a byte order issue rather than adding new support.
> sln
> 
Thanks, you are correct.  I missed that distinction when I split it up initially.  

Bimmy, can we respin this patch with the following title and description instead:

I40e: Fix byte ordering in ARP NS code for X722

This patch fixes byte ordering problems found when enabling this feature support.  Without this patch, the feature will not work correctly.  This patch fixes the definitions to have the correct byte order.

Thanks,

Carolyn



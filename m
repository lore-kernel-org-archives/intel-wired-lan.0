From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 15 Oct 2015 16:35:59 +0000
Subject: [Intel-wired-lan] [next-queue 15/17] fm10k: change default Tx
 ITR to 25usec
In-Reply-To: <561F0E2B.5060308@gmail.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-15-git-send-email-jacob.e.keller@intel.com>
 <561E7195.2010605@gmail.com> <1444838391.26286.11.camel@intel.com>
 <561E8176.8050803@gmail.com> <1444845432.26286.29.camel@intel.com>
 <561EE4C8.9060502@gmail.com> <1444866251.26286.54.camel@intel.com>
 <561F0E2B.5060308@gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB58577A8A23@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Wednesday, October 14, 2015 7:24 PM
> To: Keller, Jacob E; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [next-queue 15/17] fm10k: change default Tx
> ITR to 25usec
> 
> > There is no hardware ethernet flow control at all for the fm10k
> > interface.
> 
> There is a flow control mechanism in the form of DMA back pressure that
> can be exerted by the PEP interfaces.  It is controlled via the ethtool
> flow control interface.  I believe it is defaulted to off though since
> that is what is in the current upstream driver.
> 
> - Alex

Ah yes that. It is disabled.

Regards,
Jake

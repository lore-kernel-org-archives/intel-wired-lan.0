From: KY Srinivasan <kys@microsoft.com>
Date: Fri, 15 Apr 2016 02:51:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/2] ethernet: intel: Support
	Hyper-V hosts
In-Reply-To: <CAL3LdT4c5nhxeOrWcCPfGXAJVx2iWyjjMik6aaF3V-STBRXo0A@mail.gmail.com>
References: <1460678121-30308-1-git-send-email-kys@microsoft.com>
 <CAL3LdT4c5nhxeOrWcCPfGXAJVx2iWyjjMik6aaF3V-STBRXo0A@mail.gmail.com>
Message-ID: <SN2PR03MB1919A09CCC5A47893DF88BBCA0680@SN2PR03MB1919.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: tarbal at gmail.com [mailto:tarbal at gmail.com] On Behalf Of Jeff Kirsher
> Sent: Thursday, April 14, 2016 7:21 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: David Miller <davem@davemloft.net>; netdev
> <netdev@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>;
> devel at linuxdriverproject.org; olaf at aepfle.de; apw at canonical.com;
> jasowang at redhat.com; eli at mellanox.com; jackm at mellanox.com;
> yevgenyp at mellanox.com; Ronciak, John <john.ronciak@intel.com>; intel-
> wired-lan at linuxonhyperv.com
> Subject: Re: [PATCH net-next 0/2] ethernet: intel: Support Hyper-V hosts
> 
> On Thu, Apr 14, 2016 at 4:55 PM, K. Y. Srinivasan <kys@microsoft.com>
> wrote:
> > Make adjustments to the Intel 10G VF driver to support
> > running on Hyper-V hosts.
> >
> > K. Y. Srinivasan (2):
> >   ethernet: intel: Add the device ID's presented while running on
> >     Hyper-V
> >   intel: ixgbevf: Support Windows hosts (Hyper-V)
> >
> >  drivers/net/ethernet/intel/ixgbevf/defines.h      |    5 +
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   11 ++
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   56 ++++++---
> >  drivers/net/ethernet/intel/ixgbevf/mbx.c          |   12 ++
> >  drivers/net/ethernet/intel/ixgbevf/vf.c           |  138
> +++++++++++++++++++++
> >  drivers/net/ethernet/intel/ixgbevf/vf.h           |    2 +
> >  6 files changed, 206 insertions(+), 18 deletions(-)
> 
> Don't know how you butchered the mailing list address, but you did not
> send this series to intel-wired-lan at lists.osuosl.org mailing list.
> Please address the requested changes that Mark suggested and resubmit
> to the correct mailing list please.

Will do.

Thanks,

K. Y
